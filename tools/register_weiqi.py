# -*- coding: utf-8 -*-
"""接入围棋20，保留未使用的19号及全部已有游戏。"""
import contextlib
import io
import register_boardgames as base


def main():
    base.GAMES=((20,'weiqi','go','围棋',2),)
    with contextlib.redirect_stdout(io.StringIO()):base.main()
    print('WeiQi20 registered; reserved19 cannot be selected; existing games preserved.')


if __name__=='__main__':main()
