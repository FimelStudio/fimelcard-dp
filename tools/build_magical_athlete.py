"""按依赖重建胡闹运动会23及公共接入，不读取或启动玩家存档。"""
from pathlib import Path
import subprocess
import sys


def main():
    tools = Path(__file__).resolve().parent
    for module in ('engine', 'assets', 'sound', 'game', 'settings', 'ui', 'visual', 'icon'):
        subprocess.run([sys.executable, str(tools / ('build_magical_athlete_' + module + '.py'))], cwd=tools.parent, check=True)
    # 公共注册与会话文件已随仓库保存；单个游戏重建只更新自己的护栏。
    from build_direct_interactions import build as direct_interactions
    direct_interactions("magical_athlete")


if __name__ == '__main__':
    main()
