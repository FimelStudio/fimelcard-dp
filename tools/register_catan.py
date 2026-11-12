"""注册卡坦岛21，保持命悬一线19与围棋20及用户菜单文本。"""
import contextlib
import io
import json
import register_boardgames as base
from game_picker_ui import set_label


def main():
    base.GAMES=((21,'catan','ca','卡坦岛',4),)
    with contextlib.redirect_stdout(io.StringIO()): base.main()
    for cap in (4,8):
        set_label(base.PACK,cap,21,'卡坦岛（2–4人）')
    print('已注册卡坦岛21；保留19号命悬一线。')


if __name__=='__main__':main()
