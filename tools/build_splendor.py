"""按依赖重建璀璨宝石22；仅更新本游戏与新增输入所需的暂停清理。"""
from pathlib import Path
import json
import subprocess
import sys


def main():
    tools=Path(__file__).resolve().parent
    for module in ('engine','assets','visual','sound','inventory','hud','game','settings','ui'):
        subprocess.run([sys.executable,str(tools/('build_splendor_'+module+'.py'))],cwd=tools.parent,check=True)
    from build_direct_interactions import build as direct_interactions
    direct_interactions("splendor")
    from register_splendor import register_rules
    register_rules()
    from build_table_pause_guards import game_guards, discard_inputs
    _, entries = game_guards(('splendor',))
    manifest_path = tools/'table_pause_guard_manifest.json'
    manifest = json.loads(manifest_path.read_text(encoding='utf-8'))
    manifest.update(entries)
    manifest_path.write_text(json.dumps(manifest,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    discard_inputs()


if __name__ == '__main__':
    main()
