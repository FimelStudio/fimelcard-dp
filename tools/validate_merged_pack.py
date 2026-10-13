#!/usr/bin/env python3
"""校验已发布主包、原包移植内容和玩家 ZIP；不修改任何游戏文件。"""
import hashlib
import json
from pathlib import Path
import zipfile
import sys

sys.dont_write_bytecode = True
from merge_dependencies import TEXT_SUFFIXES, read_text, transform, validate


def check():
    pack = Path(__file__).resolve().parents[1]
    report = json.loads(read_text(pack / "docs/前置合并清单.json"))
    backup = Path(report["installation"]["backup"])
    release = Path(report["installation"]["release"])
    static = validate(pack, report)
    compared = 0
    with zipfile.ZipFile(backup / "fimel_cards-合并前.zip") as archive:
        for name, old_hash in report["original_main_sha256"].items():
            raw = archive.read(name)
            assert hashlib.sha256(raw).hexdigest() == old_hash, "主包原始快照不符：" + name
            if name in {"data/minecraft/tags/function/load.json", "data/minecraft/tags/function/tick.json"}:
                continue
            expected = raw
            if Path(name).suffix in TEXT_SUFFIXES:
                text = raw.decode("utf-8-sig")
                updated = transform(text)
                if updated != text:
                    expected = updated.encode("utf-8")
            assert (pack / name).read_bytes() == expected, "存在非接口映射的游戏逻辑变化：" + name
            compared += 1
    with zipfile.ZipFile(release) as archive:
        names = archive.namelist()
        assert "pack.mcmeta" in names and any(name.startswith("data/") for name in names)
        assert not any(name.startswith((".git/", "tools/")) for name in names)
        for name in names:
            if name.startswith("data/"):
                assert archive.read(name) == (pack / name).read_bytes(), "ZIP 与当前运行版不一致：" + name
        assert not any(name.startswith("data/" + old + "/") for name in names for old in report["namespaces"])
        assert not any("smoke" in name for name in names if name.startswith("data/fimel_vendor/"))
    assert not any((pack.parent / name).exists() for name in report["sources"]), "原前置仍留在 datapacks 中"
    assert all((backup / name).is_dir() for name in report["sources"]), "前置备份不完整"
    print(json.dumps({"static": static, "game_resources_compared_to_backup": compared, "game_logic_changes_other_than_identifier_mapping": 0, "release_matches_installed_runtime": True, "original_packs_recoverable": True, "release_size_bytes": release.stat().st_size}, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    check()
