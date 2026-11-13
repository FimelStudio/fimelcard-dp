"""重建直接交互游戏的本桌暂停护栏与规则窗口，保留其他游戏产物。"""
import json
from pathlib import Path

PACK=Path(__file__).resolve().parents[1]


def finish(namespace):
    from build_table_pause_guards import game_guards, discard_inputs, write_guarded
    _, entries=game_guards((namespace,))
    path=PACK/'tools/table_pause_guard_manifest.json'
    records=json.loads(path.read_text(encoding='utf-8'));records.update(entries)
    path.write_text(json.dumps(records,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')
    discard_inputs()
    from build_game_rules import make_dialog
    dialog=make_dialog(namespace);dialog['after_action']='close'
    root=PACK/f'data/{namespace}/function/rules'
    write_guarded(root/'show.mcfunction',f'function {namespace}:rules/panel\n',encoding='utf-8')
    write_guarded(root/'panel.mcfunction','dialog show @a[tag=ct.rules_actor,limit=1] '+json.dumps(dialog,ensure_ascii=False,separators=(',',':'))+'\n',encoding='utf-8')
