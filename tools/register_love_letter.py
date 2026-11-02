"""追加情书17，保留阿瓦隆16和其他模块的最新注册。"""
import contextlib
import io
import json
import register_boardgames as base
from game_picker_ui import set_label


def main():
    base.GAMES = ((17,'love_letter','ll','情书',6),)
    with contextlib.redirect_stdout(io.StringIO()):
        base.main()
    for capacity, maximum in ((4,4),(8,6)):
        set_label(base.PACK,capacity,17,f'情书（2–{maximum}人）')
    print('情书17已注册，阿瓦隆16与既有分派保留。')


if __name__=='__main__':main()
