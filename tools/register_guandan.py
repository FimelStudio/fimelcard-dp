"""追加掼蛋18；保留既有阿瓦隆16、情书17及未来游戏注册。"""
import contextlib
import io
import json
import register_boardgames as base
from game_picker_ui import load_picker, write_picker


def main():
    labels={}
    for capacity in (4,8):
        dialog=load_picker(base.PACK,capacity)
        for button in dialog['actions']:
            if button.get('action',{}).get('command','').endswith('$(p18)'):
                labels[capacity]=button['label']
    base.GAMES=((18,'guandan','gd','掼蛋',4),)
    with contextlib.redirect_stdout(io.StringIO()):
        base.main()
    for capacity in (4,8):
        dialog=load_picker(base.PACK,capacity)
        for button in dialog['actions']:
            if button.get('action',{}).get('command','').endswith('$(p18)'):
                button['label']=labels.get(capacity,{'text':'掼蛋（1–4人+人机）'})
        write_picker(base.PACK,capacity,dialog)
    print('掼蛋18已注册；保留既有菜单文本、人机补位与其他游戏分派。')


if __name__=='__main__':main()
