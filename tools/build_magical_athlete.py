"""按依赖重建胡闹运动会23及公共接入，不读取或启动玩家存档。"""
from pathlib import Path
import subprocess
import sys


def main():
    tools = Path(__file__).resolve().parent
    for module in ('engine', 'assets', 'sound', 'game', 'settings', 'ui', 'visual', 'icon'):
        subprocess.run([sys.executable, str(tools / ('build_magical_athlete_' + module + '.py'))], cwd=tools.parent, check=True)
    for script in ('register_magical_athlete', 'build_table_chair_settings', 'build_table_sessions', 'build_table_pause_guards'):
        subprocess.run([sys.executable, str(tools / (script + '.py'))], cwd=tools.parent, check=True)

    from build_direct_interactions import build as direct_interactions
    direct_interactions("magical_athlete")


if __name__ == '__main__':
    main()
