"""追加情书17，保留阿瓦隆16和其他模块的最新注册。"""
import contextlib
import io
import json
import register_boardgames as base


def main():
    base.GAMES = ((17,'love_letter','ll','情书',6),)
    with contextlib.redirect_stdout(io.StringIO()):
        base.main()
    for capacity, maximum in ((4,4),(8,6)):
        name=f'menu/picker/show{capacity}'
        body=base.read(name)
        dialog=json.loads(body[body.index('{'):])
        for button in dialog['actions']:
            if button.get('action',{}).get('command','').endswith('$(p17)'):
                button['label']['text']=f'情书（2–{maximum}人）'
        base.write(name,'$dialog show @a[tag=ct.switch_actor,limit=1] '+json.dumps(dialog,ensure_ascii=False,separators=(',',':')))
    print('情书17已注册，阿瓦隆16与既有分派保留。')


if __name__=='__main__':main()
