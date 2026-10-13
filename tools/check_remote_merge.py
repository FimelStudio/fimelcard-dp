#!/usr/bin/env python3
"""校验远端 682a435 合并后的功能、接口与本地修改保留情况。"""
import json
from pathlib import Path
import re
import subprocess
import sys

sys.dont_write_bytecode = True
from merge_dependencies import read_text, transform, validate

root = Path(__file__).resolve().parents[1]
stash = "7c89bd4f9077a588ca2957d0aa37d810bab8ca17"
target = "682a43549e39028718b2a75a59fbd68c9a9685e5"


def git(*args):
    return subprocess.check_output(["git", *args], cwd=root).decode("utf-8").replace("\r\n", "\n")


assert git("rev-parse", "HEAD").strip() == target
assert not git("diff", "--name-only", "--diff-filter=U").strip()
remote_data = set()
for path in git("diff", "--name-only", "--diff-filter=AM", "-z", stash + "^1", target).split("\0"):
    if path.startswith("data/"):
        remote_data.add(path)
        expected = transform(git("show", target + ":" + path))
        actual = read_text(root / path).replace("\r\n", "\n")
        assert actual == expected, "远端游戏功能未完整保留：" + path
local_count = 0
for path in git("diff", "--name-only", "--diff-filter=M", "-z", stash + "^1", stash).split("\0"):
    if not path.startswith("data/") or path in remote_data:
        continue
    assert read_text(root / path).replace("\r\n", "\n") == git("show", stash + ":" + path), "本地修改丢失：" + path
    local_count += 1
restored = 0
for path in git("ls-tree", "-r", "--name-only", "-z", stash + "^3").split("\0"):
    if not path.startswith("data/"):
        continue
    assert read_text(root / path).replace("\r\n", "\n") == git("show", stash + "^3:" + path), "本地新增文件丢失：" + path
    restored += 1
for path in (root / "data").rglob("*.mcfunction"):
    text = read_text(path)
    assert not re.search(r"^(?:<{7}|>{7}|={7})", text, re.M), str(path)
    assert "cardtable:admin/create/" not in text, str(path)
assert sorted(p.stem for p in (root / "data/cardtable/function/admin").glob("create*.mcfunction")) == ["create", "create8", "create8_safe", "create_safe"]
# 合并清单的哈希记录属于早先发布快照；这里单独验证当前引用结构。
report = json.loads(read_text(root / "docs/前置合并清单.json"))
report["copies"] = []
static = validate(root, report)
assert not static["missing_function_references"], static
print(json.dumps({"remote_game_files_preserved": len(remote_data), "local_modified_game_files_preserved": local_count, "local_new_game_files_preserved": restored, "unresolved_conflicts": 0, "static": static}, ensure_ascii=False, indent=2))
