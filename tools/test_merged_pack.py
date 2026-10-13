#!/usr/bin/env python3
"""用独立临时世界验证合并包；复用用户已有测试服务器和已确认的 EULA 文件。"""
import argparse
import json
from pathlib import Path
import queue
import shutil
import subprocess
import tempfile
import threading
import time
import sys

sys.dont_write_bytecode = True
from merge_dependencies import PACK_NAMES, read_text, write_text, write_json


def run_test(stage, originals, java, server_cache, merged_only=False):
    test = Path(tempfile.mkdtemp(prefix="fimel-merged-server-"))
    accepted = server_cache / "eula.txt"
    if not accepted.is_file() or "eula=true" not in read_text(accepted).lower():
        raise RuntimeError("用户已有测试服务器未确认 EULA，不能启动验证。")
    shutil.copy2(accepted, test / "eula.txt")
    write_text(test / "server.properties", 'online-mode=false\nserver-ip=127.0.0.1\nserver-port=0\nlevel-name=world\nlevel-type=minecraft:flat\ngenerator-settings={"biome":"minecraft:plains","layers":[{"block":"minecraft:bedrock","height":1},{"block":"minecraft:stone","height":2},{"block":"minecraft:grass_block","height":1}]}\nspawn-protection=0\nview-distance=2\nsimulation-distance=2\nmax-players=1\nenable-rcon=false\nenable-status=false\nsync-chunk-writes=false\n')
    target = test / "world/datapacks/fimel_cards"
    shutil.copytree(stage / "data", target / "data")
    shutil.copy2(stage / "pack.mcmeta", target / "pack.mcmeta")
    for name in ([] if merged_only else PACK_NAMES):
        src = originals / name
        dst = test / "world/datapacks" / name
        shutil.copytree(src / "data", dst / "data")
        shutil.copy2(src / "pack.mcmeta", dst / "pack.mcmeta")
    smoke = """# 静态脚本无法验证的宏、队列和命名隔离，用原版服务器执行。
scoreboard objectives add title.int dummy
scoreboard objectives add title.panel_id dummy
scoreboard objectives add cgt.AnimText.entity.count dummy
scoreboard players set #smoke fbt_int 123
scoreboard players set #smoke title.int 321
execute if score #smoke fbt_int matches 123 if score #smoke title.int matches 321 run say FC_MERGE_OBJECTIVE_ISOLATION_OK
data modify storage fimel_title:io merge_smoke set value 123
data modify storage title:io merge_smoke set value 321
execute if data storage fimel_title:io {merge_smoke:123} if data storage title:io {merge_smoke:321} run say FC_MERGE_STORAGE_ISOLATION_OK
function fimel_sklibs:skapi_arrays/equal {a:{value:[1,2]},b:{value:[1,2]},output:{data:"storage fimel_sklibs:arrays smoke_equal"}}
execute if score equalResult fcs_arr_tmp matches 1 run say FC_MERGE_ARRAYS_OK
execute positioned 0 110 0 run function hanabi:test/firework_success
execute if entity @e[type=minecraft:firework_rocket,tag=fimel.skfirework.lau] run say FC_MERGE_FIREWORK_OK
execute positioned 0 100 0 rotated 0 0 run function fimel_anim_text:positional/animation/load {data:{text:[{text:"Merge test"}],sound:0,analyse:0b,speed:300,style:30}}
execute if entity @e[tag=fimel.anim_text.positional.animation.center] run say FC_MERGE_TEXT_ANIMATION_OK
execute if data storage fimel_skform:runtime reg.form.skfirework_ui run say FC_MERGE_FORM_REGISTER_OK
data modify storage fimel_skform:runtime database.scoreboards set value []
execute summon minecraft:marker run function fimel_skform:show_form/_scoreboard/_1 {form_id:"smoke",key:"x"}
scoreboard players set #probe fcs_ft_smoke_x 1
execute if score #probe fcs_ft_smoke_x matches 1 run say FC_MERGE_FORM_TRIGGER_OK
function fimel_title:new_panel {id:"#test_panel fv_ctx"}
data modify storage fimel_title:io text set value [{text:"test"}]
data modify storage fimel_title:io font set value "minecraft:default_mod"
data modify storage fimel_title:io neg_font set value "minecraft:default_neg"
data modify storage fimel_title:io x set value 8.0d
data modify storage fimel_title:io y set value 8.0d
data modify storage fimel_title:io dx set value 0.0d
data modify storage fimel_title:io dy set value 0.0d
data modify storage fimel_title:io align set value "left"
data modify storage fimel_title:io origin set value "up-left"
function fimel_title:new_text
scoreboard players operation panel_id fbt_io = #test_panel fv_ctx
function fimel_title:replace_panel
execute if score #test_panel fv_ctx matches 1.. run say FC_MERGE_TITLE_PANEL_OK
execute summon minecraft:marker run function fimel_vendor:smoke_entity
say FC_MERGE_SMOKE_SENT
"""
    write_text(target / "data/fimel_vendor/function/smoke.mcfunction", smoke)
    write_text(target / "data/fimel_vendor/function/smoke_entity.mcfunction", """# 用测试 marker 验证面板占用归还与旧实体状态映射。
scoreboard players set @s title.panel_id 17
scoreboard players set @s fbt_panel 2
function fimel_vendor:hud/acquire
execute if score @s title.panel_id matches 0 if score @s fbt_external matches 17 run say FC_MERGE_HUD_ACQUIRE_OK
function fimel_vendor:hud/release
execute if score @s title.panel_id matches 17 unless entity @s[tag=fimel.bt_paused] run say FC_MERGE_HUD_RELEASE_OK
scoreboard players set @s cgt.AnimText.entity.count 71
tag @s add cgt_anim_text.positional.animation.center
function fimel_vendor:migrate_entity
execute if score @s fca_id matches 71 if entity @s[tag=fimel.anim_text.positional.animation.center] unless entity @s[tag=cgt_anim_text.positional.animation.center] run say FC_MERGE_LEGACY_ENTITY_OK
kill @s
""")
    command = [str(java), "-Xms256M", "-Xmx1024M", "-Dfile.encoding=UTF-8", "-DbundlerRepoDir=" + str(server_cache), "-jar", str(server_cache / "server.jar"), "--nogui"]
    process = subprocess.Popen(command, cwd=test, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, text=True, encoding="utf-8", errors="replace")
    messages = queue.Queue()

    def consume():
        for line in process.stdout:
            messages.put(line.rstrip())
        messages.put(None)

    threading.Thread(target=consume, daemon=True).start()
    output = []
    start = time.monotonic()
    sent = False
    finished = None
    stopped = False
    try:
        while time.monotonic() - start < 150:
            try:
                line = messages.get(timeout=0.25)
            except queue.Empty:
                line = ""
            if line is None:
                break
            if line:
                output.append(line)
                if "ERROR" in line or "FC_MERGE" in line or "Done (" in line:
                    print(line, flush=True)
                if "Done (" in line and not sent:
                    process.stdin.write("datapack list enabled\nforceload add 0 0\nschedule function fimel_vendor:smoke 60t\n")
                    process.stdin.flush()
                    sent = True
                if "FC_MERGE_SMOKE_SENT" in line:
                    finished = time.monotonic()
            if finished and time.monotonic() - finished > 6 and not stopped:
                process.stdin.write("stop\n")
                process.stdin.flush()
                stopped = True
            if stopped and process.poll() is not None:
                break
        if process.poll() is None:
            if not stopped:
                process.stdin.write("stop\n")
                process.stdin.flush()
            process.wait(timeout=30)
    finally:
        if process.poll() is None:
            process.terminate()
        write_text(test / "validation.log", "\n".join(output) + "\n")
    joined = "\n".join(output)
    expected = ["OBJECTIVE_ISOLATION", "STORAGE_ISOLATION", "ARRAYS", "TITLE_PANEL", "FIREWORK", "TEXT_ANIMATION", "FORM_REGISTER", "FORM_TRIGGER", "HUD_ACQUIRE", "HUD_RELEASE", "LEGACY_ENTITY"]
    checks = {key: "FC_MERGE_" + key + "_OK" in joined for key in expected}
    upstream_notes = [line for line in output if "Invalid path in pack: sklibs:function/" in line]
    errors = [line for line in output if ("ERROR" in line or "Unknown function" in line or "Failed to parse" in line or "Couldn't load" in line) and line not in upstream_notes]
    result = {"test_directory": str(test), "server": "26.2", "both_original_and_merged_installed": not merged_only, "checks": checks, "errors": errors, "original_pack_note_warnings": upstream_notes, "exit_code": process.returncode}
    write_json(test / "validation.json", result)
    print(json.dumps(result, ensure_ascii=False, indent=2), flush=True)
    if not all(checks.values()) or errors or process.returncode != 0:
        raise RuntimeError("服务器测试未通过，详见 " + str(test / "validation.log"))
    return result


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("stage", type=Path)
    parser.add_argument("--originals", type=Path, default=Path(__file__).resolve().parents[2])
    parser.add_argument("--java", type=Path, default=Path("C:/Users/柳浪一/AppData/Roaming/.minecraft/runtime/java-runtime-epsilon/bin/java.exe"))
    parser.add_argument("--server-cache", type=Path, default=Path("D:/PCL2/MinecraftPcl/cache/fimel_cards_26_2_test"))
    parser.add_argument("--merged-only", action="store_true")
    args = parser.parse_args()
    run_test(args.stage, args.originals, args.java, args.server_cache, args.merged_only)
