# -*- coding: utf-8 -*-
"""命悬一线19：蛛丝模式，2-8人，私密数字、公开描述、三关合作。"""
from pathlib import Path
import json
P=Path(__file__).resolve().parents[1];F=P/'data/ito/function'
def put(n,s):
 p=F/(n+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True);p.write_text(s.strip()+'\n',encoding='utf8')
def js(x):return json.dumps(x,ensure_ascii=False,separators=(',',':'))
def say(s,color='yellow',target='@a[tag=it.audience]'):return 'tellraw '+target+' '+js({'text':'[命悬一线] '+s,'color':color})
def build():
 from build_ito_runtime import build as runtime
 from build_ito_themes import build as themes
 from build_ito_ui import build as ui
 from build_ito_display import build as display
 runtime();themes();ui();display()
 from build_ito_settings import build as settings
 settings()
if __name__=='__main__':build()
