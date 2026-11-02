"""按依赖重建璀璨宝石22及其公共注册；不访问玩家世界。"""
from pathlib import Path
import subprocess
import sys


def main():
    tools=Path(__file__).resolve().parent
    for module in ('engine','assets','visual','sound','game','settings','ui'):
        subprocess.run([sys.executable,str(tools/('build_splendor_'+module+'.py'))],cwd=tools.parent,check=True)
    subprocess.run([sys.executable,str(tools/'register_splendor.py')],cwd=tools.parent,check=True)
    for name in ('build_table_chair_settings','build_table_sessions','build_table_pause_guards'):
        subprocess.run([sys.executable,str(tools/(name+'.py'))],cwd=tools.parent,check=True)


if __name__ == '__main__':
    main()
