"""追加掼蛋18；保留既有阿瓦隆16、情书17及未来游戏注册。"""
import contextlib
import io
import json
import register_boardgames as base


def main():
    base.GAMES=((18,'guandan','gd','掼蛋',4),)
    with contextlib.redirect_stdout(io.StringIO()):
        base.main()
    for capacity in (4,8):
        name=f'menu/picker/show{capacity}'
        body=base.read(name);dialog=json.loads(body[body.index('{'):])
        for button in dialog['actions']:
            if button.get('action',{}).get('command','').endswith('$(p18)'):
                button['label']['text']='掼蛋（4人）'
        base.write(name,'$dialog show @a[tag=ct.switch_actor,limit=1] '+json.dumps(dialog,ensure_ascii=False,separators=(',',':')))
    print('掼蛋18已注册：4名真人；阿瓦隆16、情书17和其他既有分派保留。')


if __name__=='__main__':main()
