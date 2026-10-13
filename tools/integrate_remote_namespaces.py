#!/usr/bin/env python3
"""远端更新接入内置前置时，同步其新增引用；默认只预览。"""
import argparse
import json
from pathlib import Path
import subprocess
import sys

sys.dont_write_bytecode = True
from merge_dependencies import TEXT_SUFFIXES, read_text, transform, write_text

PACK = Path(__file__).resolve().parents[1]


def git(*args):
    return subprocess.check_output(["git", *args], cwd=PACK).decode("utf-8")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--base", default="b22a9b9")
    parser.add_argument("--apply", action="store_true")
    parser.add_argument("--stash", default="7c89bd4f9077a588ca2957d0aa37d810bab8ca17")
    args = parser.parse_args()
    deleted_tools = []
    for name in git("diff", "--name-only", "--diff-filter=U", "-z").split("\0"):
        if not name.startswith("tools/"):
            continue
        original = git("show", args.stash + "^1:" + name).replace("\r\n", "\n")
        local = git("show", args.stash + ":" + name).replace("\r\n", "\n")
        if local != transform(original):
            raise RuntimeError("已删除工具含额外本地改动，需要单独合并：" + name)
        deleted_tools.append(name)
    changed = []
    for name in git("diff", "--name-only", "-z", args.base, "HEAD").split("\0"):
        path = PACK / name
        if not name or not path.is_file() or path.suffix not in TEXT_SUFFIXES:
            continue
        original = read_text(path)
        if "<<<<<<< Updated upstream" in original:
            raise RuntimeError("仍存在冲突：" + name)
        updated = transform(original)
        if updated != original:
            changed.append(name)
            if args.apply:
                write_text(path, updated)
    print(json.dumps({"adapted_files": changed, "deleted_tools_only_had_identifier_changes": deleted_tools}, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
