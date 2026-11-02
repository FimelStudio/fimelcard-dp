"""按依赖顺序重建卡坦岛21；只写项目文件，不加载或改动玩家世界。

默认重建规则、模型/纹理、图片字体、界面与注册；--audio 另从保留原文件
重新编码音效和背景音乐（需要 ffmpeg）。原素材须位于资源包 .source/catan。
"""
import argparse
import subprocess
import sys
from pathlib import Path

TOOLS=Path(__file__).resolve().parent


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--audio',action='store_true',help='重新编码已保留的音频源文件')
    args=parser.parse_args()
    steps=[('engine',[]),('visual',[]),('font',[]),('sound',['--assets'] if args.audio else []),('settings',[]),('ui',[]),('input',[]),('game',[])]
    for module,options in steps:
        subprocess.run([sys.executable,str(TOOLS/f'build_catan_{module}.py'),*options],cwd=TOOLS.parent,check=True)
    subprocess.run([sys.executable,str(TOOLS/'register_catan.py')],cwd=TOOLS.parent,check=True)


if __name__=='__main__':main()
