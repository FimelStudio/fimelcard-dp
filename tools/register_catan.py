"""注册卡坦岛21，保持命悬一线19与围棋20及用户菜单文本。"""
import contextlib
import io
import json
import register_boardgames as base


def main():
    base.GAMES=((21,'catan','ca','卡坦岛',4),)
    with contextlib.redirect_stdout(io.StringIO()): base.main()
    for cap in (4,8):
        name=f'menu/picker/show{cap}'
        raw=base.read(name);dialog=json.loads(raw[raw.index('{'):])
        for a in dialog['actions']:
            if a.get('action',{}).get('command','').endswith('$(p21)'):
                a['label']['text']='卡坦岛（3–4人）'
        base.write(name,'$dialog show @a[tag=ct.switch_actor,limit=1] '+json.dumps(dialog,ensure_ascii=False,separators=(',',':')))
    print('已注册卡坦岛21；保留19号命悬一线。')


if __name__=='__main__':main()
