# -*- coding: utf-8 -*-
"""接入围棋20，保留19号命悬一线及全部已有游戏。"""
import contextlib
import io
import register_boardgames as base


def main():
    base.GAMES=((20,'weiqi','go','围棋',2),)
    with contextlib.redirect_stdout(io.StringIO()):base.main()
    print('围棋20已注册；保留19号命悬一线及其他已有游戏。')


if __name__=='__main__':main()
