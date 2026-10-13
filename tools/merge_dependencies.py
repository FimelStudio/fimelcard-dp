#!/usr/bin/env python3
"""合并前置的可审计工具；默认仅检查，显式 --apply 才修改文件。"""

import argparse
import collections
import hashlib
import json
from pathlib import Path
import re
import shutil
import tempfile
import zipfile
from datetime import datetime, timezone, timedelta

PACK_NAMES = [
    "[1.21.1+] SKapi Libs Ver2.1 DP",
    "[1.21.4] SK Firework 烟花 V2.0",
    "[1.21+] SK Form 表单输入系统 V1.0",
    "[前置]文本动画库重制版 V26.0 - 1.21.6+",
    "BetterTitle DP 26.1",
]
NAMESPACES = {
    "sklibs": "fimel_sklibs",
    "skform": "fimel_skform",
    "cgt_anim_text": "fimel_anim_text",
    "cgt_math_light": "fimel_math_light",
    "title": "fimel_title",
}
TEXT_SUFFIXES = {".mcfunction", ".json", ".mcdoc", ".txt", ".md", ".py", ".ps1", ".bat", ".mjs"}
OBJECTIVES = {
    "cgt.AnimText.storage": "fca_store",
    "cgt.AnimText.entity.count": "fca_id",
    "cgt.AnimText.entity.style": "fca_style",
    "cgt.AnimText.entity.timer": "fca_timer",
    "cgt.AnimText.entity.timer.max": "fca_timer_max",
    "cgt.AnimText.entity.timer.start": "fca_timer_start",
    "cgt.AnimText.entity.timer.total": "fca_timer_total",
    "cgt.AnimText.player.count": "fca_player_id",
    "cgt.MathLight.storage": "fcm_store",
    "skapi.skapilib": "fcs_lib",
    "skapi.skapilib.life": "fcs_life",
    "skapi.arrays.temp": "fcs_arr_tmp",
    "skapi.arrays.var": "fcs_arr_var",
    "skapi.math": "fcs_math",
    "skapi.firework": "fcs_fw",
    "skapi.firework.launchtime": "fcs_fw_time",
    "skapi.firework.trigger": "fcs_fw_trigger",
    "skapi.animator.thisframe": "fcs_an_frame",
    "skapi.animator.targetframe": "fcs_an_target",
    "skapi.animator.color": "fcs_an_color",
    "skapi.animator.phy.vx": "fcs_an_vx",
    "skapi.animator.phy.vy": "fcs_an_vy",
    "skapi.animator.phy.g": "fcs_an_g",
    "skapi.animator.phy.t": "fcs_an_t",
    "skform.submit": "fcs_form_submit",
    "title.int": "fbt_int",
    "title.io": "fbt_io",
    "title.panel_id": "fbt_panel",
}
STORAGES = {
    "minecraft:cgt_anim_text": "fimel_anim_text:runtime",
    "minecraft:cgt_math_light": "fimel_math_light:runtime",
    "minecraft:skapi.skapilib": "fimel_sklibs:runtime",
    "skapi.skapilib": "fimel_sklibs:runtime",
    "skapi.arrays": "fimel_sklibs:arrays",
    "skapi.math": "fimel_sklibs:math",
    "skapi.player": "fimel_sklibs:player",
    "skapi.animator": "fimel_sklibs:animator",
    "skapi.skfirework": "fimel_sklibs:firework",
    "skapi.form": "fimel_skform:runtime",
    "title:io": "fimel_title:io",
}
TAG_PREFIXES = {
    "cgt_anim_text.": "fimel.anim_text.",
    "skfirework.": "fimel.skfirework.",
    "skanimator.": "fimel.skanimator.",
    "skform.": "fimel.skform.",
}


def replace_token(text, old, new):
    return re.sub(r"(?<![\w.:/-])" + re.escape(old) + r"(?![\w.:/-])", lambda _: new, text)


def transform(text):
    # storage 同名记分项必须先按 storage 命令上下文改，避免把记分板改成存储 ID。
    for old, new in sorted(STORAGES.items(), key=lambda pair: -len(pair[0])):
        text = re.sub(r"(\bstorage\s+)" + re.escape(old) + r"(?![\w.:/-])", lambda match: match[1] + new, text)
        text = re.sub(r"((?:[\"']?storage[\"']?\s*:\s*)[\"'])" + re.escape(old) + r"([\"'])", lambda match: match[1] + new + match[2], text)
        if old.startswith("minecraft:"):
            text = replace_token(text, old, new)
    text = re.sub(r"(\bstorage\s+)cgt_math_light(?![\w.:/-])", r"\1fimel_math_light:runtime", text)
    for old, new in sorted(OBJECTIVES.items(), key=lambda pair: -len(pair[0])):
        text = replace_token(text, old, new)
    # SK Form 按表单与字段动态创建的 trigger 也需要隔离。
    text = text.replace("skapi.form_trigger_", "fcs_ft_")
    for old, new in TAG_PREFIXES.items():
        text = re.sub(r"(?<![\w.:/-])" + re.escape(old), lambda _: new, text)
    for old, new in NAMESPACES.items():
        if old == "title":
            # title:x_displace 等是现有资源包字体，不是数据包函数。
            text = re.sub(r"(?<![\w.:/-])title:(?=(?:io\b|code/|new_panel\b|new_part\b|new_text\b|replace_panel\b))", "fimel_title:", text)
        else:
            text = re.sub(r"(?<![\w.:/-])" + re.escape(old) + ":", lambda _: new + ":", text)
    # BetterTitle 原包的固定 UUID 必须独立；该辅助实体不再与原包重复。
    text = text.replace("UUID:[I;173, 11337728, 0, 1]", "UUID:[I;173, 11337728, 0, 1178815820]")
    text = text.replace("# ad-ad-0-0-1", "# 卡牌内置 BetterTitle 独立辅助实体 UUID，避免与外部原包重复")
    return text


def write_text(path, text):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(text.encode("utf-8"))


def write_json(path, value):
    write_text(path, json.dumps(value, ensure_ascii=False, indent=2) + "\n")


def renamed_path(relative):
    parts = list(relative.parts)
    if len(parts) >= 2 and parts[0] == "data":
        parts[1] = NAMESPACES.get(parts[1], parts[1])
    return Path(*parts)


def make_plan(root):
    inventory, declarations, collisions, errors = collect_inventory(root)
    if errors:
        raise RuntimeError("原包存在无效 JSON：" + repr(errors))
    if set(declarations) != set(OBJECTIVES):
        raise RuntimeError("记分项清单变化，需要人工核对：" + repr(set(declarations) ^ set(OBJECTIVES)))
    stage = Path(tempfile.mkdtemp(prefix="fimel-merge-"))
    # 仅复制发布数据、根文档；.git 与历史工具备份不进入发布包。
    source = root / "fimel_cards"
    shutil.copytree(source / "data", stage / "data")
    for path in source.rglob("*"):
        if not path.is_file() or any(part in {".git", "data", "tools"} for part in path.relative_to(source).parts):
            continue
        dest = stage / path.relative_to(source)
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, dest)
    for path in stage.rglob("*"):
        if path.is_file() and path.suffix in TEXT_SUFFIXES:
            value = transform(read_text(path))
            if value != read_text(path):
                write_text(path, value)
    # 当前开发生成器同步新接口；历史备份不改，合并脚本自己的映射常量也不改。
    for path in (source / "tools").rglob("*"):
        relative = path.relative_to(source)
        if not path.is_file() or path.suffix not in TEXT_SUFFIXES:
            continue
        if any("backup" in part or part == "__pycache__" for part in relative.parts):
            continue
        if path.name in {"merge_dependencies.py", "test_merged_pack.py"}:
            continue
        original = read_text(path)
        updated = transform(original)
        if updated != original:
            write_text(stage / relative, updated)
    entries = {"load": [], "tick": []}
    copies = []
    for pack in PACK_NAMES:
        source_pack = root / pack
        for path in sorted((source_pack / "data").rglob("*")):
            if not path.is_file():
                continue
            relative = renamed_path(path.relative_to(source_pack))
            if relative.as_posix() in {"data/minecraft/tags/function/load.json", "data/minecraft/tags/function/tick.json"}:
                tag = json.loads(transform(read_text(path)))
                if tag.get("replace"):
                    raise RuntimeError("前置 load/tick 不能包含 replace:true")
                key = path.stem
                entries[key].extend(tag["values"])
                continue
            if path.suffix not in {".mcfunction", ".json", ".nbt"}:
                # 笔记/调用关系图片不是游戏资源；中文路径置于 data 会被服务端报错。
                relative = Path("docs/vendor") / NAMESPACES[path.relative_to(source_pack).parts[1]] / path.relative_to(source_pack)
            dest = stage / relative
            if dest.exists():
                raise RuntimeError("不可覆盖同路径资源：" + relative.as_posix())
            dest.parent.mkdir(parents=True, exist_ok=True)
            if path.suffix in TEXT_SUFFIXES:
                write_text(dest, transform(read_text(path)))
            else:
                shutil.copy2(path, dest)
            copies.append({"source": str(path.relative_to(root)), "target": relative.as_posix(), "sha256": hashlib.sha256(dest.read_bytes()).hexdigest()})
        # 发布保留来源文档和原始元数据；生成工具按隔离后的接口更新。
        vendor_name = next(NAMESPACES[p.name] for p in (source_pack / "data").iterdir() if p.name in NAMESPACES)
        for path in sorted(source_pack.rglob("*")):
            if not path.is_file() or "data" in path.relative_to(source_pack).parts or ".git" in path.parts:
                continue
            relative = path.relative_to(source_pack)
            if relative.parts[0] == "Tools":
                dest = stage / "tools" / "vendor" / vendor_name / Path(*relative.parts[1:])
                if path.suffix in TEXT_SUFFIXES:
                    write_text(dest, transform(read_text(path)))
                else:
                    dest.parent.mkdir(parents=True, exist_ok=True)
                    shutil.copy2(path, dest)
            elif path.name not in {"spyglass.json", ".DS_Store"}:
                dest = stage / "docs" / "vendor" / vendor_name / relative
                dest.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy2(path, dest)
    for key in ("load", "tick"):
        path = stage / "data" / "minecraft" / "tags" / "function" / (key + ".json")
        main_values = json.loads(read_text(path))["values"]
        if key == "load":
            values = ["fimel_vendor:load"] + main_values
        else:
            values = entries[key] + main_values
        unique = list(dict.fromkeys(values))
        write_json(path, {"values": unique})
    load_lines = ["# 内置前置先创建独立状态，再加载各游戏；升级迁移只执行一次。", "scoreboard objectives add fv_ctx dummy"]
    load_lines += [f"scoreboard objectives add {OBJECTIVES[old]} {criterion}" for old, criterion in sorted(declarations.items()) if old != "skapi.arrays.var"]
    load_lines += ["execute unless score #migration fv_ctx matches 1 if score #version ct_ctx matches 1.. run function fimel_vendor:migrate", "scoreboard players set #migration fv_ctx 1"]
    load_lines += ["function " + entry for entry in dict.fromkeys(entries["load"])]
    write_text(stage / "data/fimel_vendor/function/load.mcfunction", "\n".join(load_lines) + "\n")
    create_migration(root, stage, inventory)
    add_hud_bridge(stage)
    metadata = json.loads(read_text(stage / "pack.mcmeta"))
    metadata["pack"]["min_format"] = [107, 1]
    metadata["pack"]["max_format"] = [107, 1]
    write_json(stage / "pack.mcmeta", metadata)
    for copy in copies:
        if copy["target"] in {"data/fimel_title/function/code/tick.mcfunction", "data/fimel_title/function/code/player_tick.mcfunction"}:
            copy["adaptation"] = "增加原版 BetterTitle 的 Actionbar 占用归还接口；原有渲染逻辑不变"
            copy["sha256"] = hashlib.sha256((stage / copy["target"]).read_bytes()).hexdigest()
    original_main = {p.relative_to(source).as_posix(): hashlib.sha256(p.read_bytes()).hexdigest() for p in (source / "data").rglob("*") if p.is_file()}
    report = {"sources": PACK_NAMES, "namespaces": NAMESPACES, "objectives": OBJECTIVES, "storages": STORAGES, "tag_prefixes": TAG_PREFIXES, "load": entries["load"], "tick": entries["tick"], "copies": copies, "original_main_sha256": original_main}
    write_json(stage / "docs/前置合并清单.json", report)
    return stage, report


def create_migration(root, stage, inventory):
    # 只在已有卡牌安装记录的世界执行。新装进其他地图不会自动接管外部库。
    lines = ["# 首次从分离版更新时复制状态，不清除外部库 storage 或计分板。", "scoreboard players set #legacy fv_ctx 1"]
    canonical = {}
    for old, new in STORAGES.items():
        src = old if ":" in old else "minecraft:" + old
        canonical[src] = new
    keys = {
        "minecraft:cgt_anim_text": ["global", "local", "positional", "storage", "temp"],
        "minecraft:cgt_math_light": ["calculation", "constant", "temp"],
        # 不迁移 SK 队列/表单缓存：其中包含旧函数名/trigger 字符串。
        # 原实现 reload 本就清缓存，复制它们会重新引入外部库调用。
        "title:io": ["panels", "part_buffer", "neg_part_buffer", "text_buffer", "neg_text_buffer", "panel_buffer"],
    }
    for src, dst in canonical.items():
        for key in keys.get(src, []):
            lines.append(f"execute if data storage {src} {key} unless data storage {dst} {key} run data modify storage {dst} {key} set from storage {src} {key}")
    # 全局假玩家只从实际代码中收集；不会把其他目标分数放入本包。
    all_text = "\n".join(read_text(p) for pack in ["fimel_cards"] + PACK_NAMES for p in (root / pack / "data").rglob("*.mcfunction"))
    fake_pairs = set()
    for holder, objective in re.findall(r"(?<![\w])([#\w.+-]+)\s+(" + "|".join(re.escape(key) for key in sorted(OBJECTIVES, key=len, reverse=True)) + r")(?![\w.])", all_text):
        if holder not in {"add", "remove", "reset", "get", "set", "dummy", "score", "matches"}:
            fake_pairs.add((holder, objective))
    for holder, old in sorted(fake_pairs):
        new = OBJECTIVES[old]
        lines.append(f"execute if score {holder} {old} = {holder} {old} unless score {holder} {new} = {holder} {new} run scoreboard players operation {holder} {new} = {holder} {old}")
    lines += ["execute as @a[tag=ct.player] run function fimel_vendor:migrate_player", "execute in minecraft:overworld run function fimel_vendor:migrate_animations", "execute in minecraft:the_nether run function fimel_vendor:migrate_animations", "execute in minecraft:the_end run function fimel_vendor:migrate_animations"]
    write_text(stage / "data/fimel_vendor/function/migrate.mcfunction", "\n".join(lines) + "\n")
    entity_lines = ["# 仅用于当前卡牌玩家或已确认属于本牌桌的旧动画实体。"]
    for old, new in OBJECTIVES.items():
        entity_lines.append(f"execute if score @s {old} = @s {old} unless score @s {new} = @s {new} run scoreboard players operation @s {new} = @s {old}")
    for old in sorted(inventory["tags"]):
        new = next((prefix + old[len(src):] for src, prefix in TAG_PREFIXES.items() if old.startswith(src)), old)
        if new != old:
            entity_lines += [f"execute if entity @s[tag={old}] run tag @s add {new}", f"tag @s remove {old}"]
    write_text(stage / "data/fimel_vendor/function/migrate_entity.mcfunction", "\n".join(entity_lines) + "\n")
    player = ["# 离线的卡牌玩家重连时仍可复制原来的私有面板分数。", "function fimel_vendor:migrate_entity", "tag @s add fimel.vendor_migrated"]
    write_text(stage / "data/fimel_vendor/function/migrate_player.mcfunction", "\n".join(player) + "\n")
    anim_lines = ["# 根实体的游戏标签证明归属，再按动画实例 ID 接管字符实体。"]
    for tag in ["fc.transition", "lh.transition", "hb.transition", "ab.transition", "dd.transition"]:
        anim_lines.append(f"execute as @e[tag={tag}] if score @s cgt.AnimText.entity.count = @s cgt.AnimText.entity.count run function fimel_vendor:migrate_animation_root")
    write_text(stage / "data/fimel_vendor/function/migrate_animations.mcfunction", "\n".join(anim_lines) + "\n")
    write_text(stage / "data/fimel_vendor/function/migrate_animation_root.mcfunction", "# 复制同实例字符实体状态，保证进行中的文字过场仍可计时和清理。\nscoreboard players operation #anim_id fv_ctx = @s cgt.AnimText.entity.count\nexecute as @e[tag=cgt_anim_text.positional] if score @s cgt.AnimText.entity.count = #anim_id fv_ctx run function fimel_vendor:migrate_entity\nfunction fimel_vendor:migrate_entity\n")


def add_hud_bridge(stage):
    # 同一玩家只有一个 Actionbar，仅在本包显示期间暂存外部 BetterTitle 指针。
    bridge = stage / "data/fimel_vendor/function/hud"
    write_text(bridge / "acquire.mcfunction", """# 只有外部 BetterTitle 真的绑定了面板时才暂时停止它的发送。
execute unless entity @s[tag=fimel.bt_paused] if score @s title.panel_id matches 1.. run function fimel_vendor:hud/save_external
execute if entity @s[tag=fimel.bt_paused] run scoreboard players set @s title.panel_id 0
""")
    write_text(bridge / "save_external.mcfunction", """# 记录外部面板；退出内置界面后恢复。不会改动外部面板内容。
scoreboard players operation @s fbt_external = @s title.panel_id
tag @s add fimel.bt_paused
""")
    write_text(bridge / "release.mcfunction", """# 本包不再占用动作栏时恢复原面板；外部系统已重新绑定时尊重其新选择。
execute unless score @s title.panel_id matches 1.. if score @s fbt_external matches 1.. run scoreboard players operation @s title.panel_id = @s fbt_external
scoreboard players reset @s fbt_external
tag @s remove fimel.bt_paused
""")
    code = stage / "data/fimel_title/function/code"
    original = read_text(code / "tick.mcfunction")
    write_text(code / "tick.mcfunction", "# 离线玩家重连时补做旧版面板迁移；新安装世界不读取外部状态。\nexecute if score #legacy fv_ctx matches 1 as @a[tag=ct.player,tag=!fimel.vendor_migrated] run function fimel_vendor:migrate_player\n# 本包退出界面后恢复外部 BetterTitle 的面板。\nexecute as @a[tag=fimel.bt_paused] unless score @s fbt_panel matches 1.. run function fimel_vendor:hud/release\n" + original)
    original = read_text(code / "player_tick.mcfunction")
    write_text(code / "player_tick.mcfunction", "# 防止外部 BetterTitle 与本包对同一玩家交替覆盖 Actionbar。\nfunction fimel_vendor:hud/acquire\n" + original)
    load = stage / "data/fimel_vendor/function/load.mcfunction"
    write_text(load, read_text(load).replace("scoreboard objectives add fv_ctx dummy", "scoreboard objectives add fv_ctx dummy\nscoreboard objectives add fbt_external dummy"))


def apply_plan(root, stage, report):
    # 先完整备份，再逐文件发布；出现异常时原包与主包快照都可恢复。
    for name, expected in report["original_main_sha256"].items():
        if hashlib.sha256((root / "fimel_cards" / name).read_bytes()).hexdigest() != expected:
            raise RuntimeError("暂存后主包被编辑，需要重新生成合并计划：" + name)
    timestamp = datetime.now(timezone(timedelta(hours=8))).strftime("%Y%m%d-%H%M%S")
    backup = root.parent / "卡牌合并备份" / timestamp
    backup.mkdir(parents=True, exist_ok=False)
    snapshot = backup / "fimel_cards-合并前.zip"
    with zipfile.ZipFile(snapshot, "w", compression=zipfile.ZIP_DEFLATED) as archive:
        for path in sorted((root / "fimel_cards").rglob("*")):
            if path.is_file() and ".git" not in path.relative_to(root / "fimel_cards").parts:
                archive.write(path, path.relative_to(root / "fimel_cards"))
    workspace_config = root / "spyglass.json"
    if workspace_config.exists():
        shutil.copy2(workspace_config, backup / "spyglass.json")
    changed = []
    target_pack = root / "fimel_cards"
    for path in sorted(stage.rglob("*")):
        if not path.is_file():
            continue
        dest = target_pack / path.relative_to(stage)
        if dest.exists() and dest.read_bytes() == path.read_bytes():
            continue
        dest.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(path, dest)
        changed.append(path.relative_to(stage).as_posix())
    # 工作区只需原版定义和资源包，内置库已经位于主包 data 内。
    if workspace_config.exists():
        config = json.loads(read_text(workspace_config))
        deps = config.setdefault("env", {}).get("dependencies", [])
        config["env"]["gameVersion"] = "26.2"
        config.pop("gameVersion", None)
        from urllib.parse import unquote
        config["env"]["dependencies"] = [entry for entry in deps if not any(name in unquote(entry) for name in PACK_NAMES)]
        write_json(workspace_config, config)
    # 文件夹移动限定为已核对的这五个绝对路径，备份不在游戏扫描的 datapacks 内。
    for name in PACK_NAMES:
        src = (root / name).resolve()
        if src.parent != root.resolve() or src.name != name:
            raise RuntimeError("前置移动路径验证失败：" + str(src))
        shutil.move(str(src), str(backup / name))
    release_dir = root.parent / "卡牌发布"
    release_dir.mkdir(exist_ok=True)
    release = release_dir / ("fimel_cards-26.2-合并版-" + timestamp + ".zip")
    with zipfile.ZipFile(release, "w", compression=zipfile.ZIP_DEFLATED) as archive:
        for path in sorted(target_pack.rglob("*")):
            if not path.is_file():
                continue
            relative = path.relative_to(target_pack)
            if relative.parts[0] in {".git", "tools"} or path.name == "spyglass.json":
                continue
            archive.write(path, relative.as_posix())
    report["installation"] = {"backup": str(backup), "release": str(release), "changed_files": len(changed)}
    write_json(target_pack / "docs/前置合并清单.json", report)
    print(json.dumps(report["installation"], ensure_ascii=False, indent=2))


def validate(stage, report):
    errors = []
    for path in stage.rglob("*.json"):
        try:
            json.loads(read_text(path))
        except ValueError as exc:
            errors.append(str(path.relative_to(stage)) + ": " + str(exc))
    functions = {p.relative_to(stage / "data").parts[0] + ":" + p.relative_to(stage / "data").as_posix().split("/function/", 1)[1][:-11] for p in (stage / "data").rglob("*.mcfunction")}
    missing = []
    for path in (stage / "data").rglob("*.mcfunction"):
        for number, line in enumerate(read_text(path).splitlines(), 1):
            if line.lstrip().startswith("#"):
                continue
            for ref in re.findall(r"\bfunction\s+([a-z0-9_.-]+:[a-z0-9_./-]+)(?![\w])", line):
                if "$" in line and (ref + "$(" in line or ref.endswith("/")):
                    continue
                if ref not in functions:
                    missing.append([path.relative_to(stage).as_posix(), number, ref])
    for key in ("load", "tick"):
        values = json.loads(read_text(stage / f"data/minecraft/tags/function/{key}.json"))["values"]
        if len(values) != len(set(values)):
            errors.append(key + " 标签重复注册")
        for ref in values:
            if ref not in functions:
                errors.append("加载入口缺失：" + ref)
    for copy in report["copies"]:
        if hashlib.sha256((stage / copy["target"]).read_bytes()).hexdigest() != copy["sha256"]:
            errors.append("移植文件哈希不符：" + copy["target"])
    if errors:
        raise RuntimeError("静态检查失败：" + repr(errors))
    report["validation"] = {"json_valid": True, "copied_resources": len(report["copies"]), "functions": len(functions), "missing_function_references": missing}
    return report["validation"]


def read_text(path):
    # 原包存在带 BOM 的 UTF-8 文件。
    return path.read_bytes().decode("utf-8-sig")


def collect_inventory(root):
    inventory = {"objectives": set(), "storages": set(), "tags": set(), "uuids": set()}
    declarations = {}
    paths = {}
    json_errors = []
    for pack in PACK_NAMES:
        for path in sorted((root / pack / "data").rglob("*")):
            if not path.is_file():
                continue
            rel = path.relative_to(root / pack).as_posix()
            paths.setdefault(rel, []).append((pack, hashlib.sha256(path.read_bytes()).hexdigest()))
            if path.suffix not in TEXT_SUFFIXES:
                continue
            text = read_text(path)
            if path.suffix == ".json":
                try:
                    json.loads(text)
                except ValueError as exc:
                    json_errors.append([str(path), str(exc)])
            for objective, criterion in re.findall(r"scoreboard objectives add\s+(\S+)\s+(\S+)", text):
                if "$" not in objective:
                    inventory["objectives"].add(objective)
                    declarations[objective] = criterion
            inventory["storages"].update(re.findall(r"\bstorage\s+([a-z0-9_.:-]+)", text))
            inventory["tags"].update(re.findall(r"\btag=!?([\w.:-]+)", text))
            inventory["tags"].update(re.findall(r"\btag\s+\S+\s+(?:add|remove)\s+([\w.:-]+)", text))
            # 26.2 的实体标签存放于 minecraft:entity_tags 组件；兼容旧 Tags 写法。
            for value in re.findall(r"(?:Tags|minecraft:entity_tags)\s*:\s*\[([^\]]*)\]", text):
                inventory["tags"].update(re.findall(r"[\"']([\w.:-]+)[\"']", value))
            inventory["uuids"].update(re.findall(r"\bUUID\s*:\s*\[I;([^\]]+)\]", text))
            inventory["uuids"].update(re.findall(r"(?<![\w])([0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12})(?![\w])", text))
    collisions = {key: values for key, values in paths.items() if len(values) > 1}
    return inventory, declarations, collisions, json_errors


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--root", type=Path, default=Path(__file__).resolve().parents[2])
    parser.add_argument("--apply", action="store_true")
    parser.add_argument("--prepare", action="store_true")
    parser.add_argument("--stage", type=Path, help="直接采用已进行服务器测试的暂存包")
    args = parser.parse_args()
    inventory, declarations, collisions, errors = collect_inventory(args.root)
    if not (args.prepare or args.apply):
        print(json.dumps({
        "inventory": {key: sorted(values) for key, values in inventory.items()},
        "criteria": declarations,
        "collisions": collisions,
        "json_errors": errors,
        }, ensure_ascii=False, indent=2))
        return
    if args.stage:
        stage = args.stage.resolve()
        report = json.loads(read_text(stage / "docs/前置合并清单.json"))
    else:
        stage, report = make_plan(args.root)
    result = validate(stage, report)
    write_json(stage / "docs/前置合并清单.json", report)
    print(json.dumps({"stage": str(stage), "validation": result}, ensure_ascii=False, indent=2))
    if args.apply:
        if result["missing_function_references"]:
            raise RuntimeError("仍存在缺失函数引用，停止写入。")
        apply_plan(args.root, stage, report)


if __name__ == "__main__":
    main()
