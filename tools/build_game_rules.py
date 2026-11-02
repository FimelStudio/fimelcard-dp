"""统一游戏内规则窗口。正文唯一来源为 tools/game_rules.json；无需改动规则执行器。"""
from pathlib import Path
import json
import re

PACK = Path(__file__).resolve().parents[1]
SOURCE = PACK / 'tools/game_rules.json'
SECTIONS = ('人数与目标', '操作方式', '对局流程', '特殊规则', '暂停与结束', '管理命令')
WIDTH = 480
PAUSE = '任一参与者离线，整桌暂停；全部原参与者重新上线后继续。等待期间可通过桌边“结束游戏”投票中止；已结束后才上线的玩家会清除旧局道具与状态。下椅不等于退出。重载保留当前对局，旧窗口通过当前操作物重开。规则窗口本身不会暂停游戏。'


def parse_snbt_json(value):
    """旧窗口使用JSON或仅省略对象键引号的SNBT；不改字符串内的文本。"""
    value = value.replace('$(storm)', '{"__dynamic__":"storm"}')
    parts = re.split(r'("(?:\\.|[^"\\])*")', value)
    for i in range(0, len(parts), 2):
        parts[i] = re.sub(r'([A-Za-z_][A-Za-z0-9_]*)\s*:', r'"\1":', parts[i])
    return json.loads(''.join(parts))


def get_dialog(text):
    for line in text.splitlines():
        found=re.match(r'\$?dialog show \S+ (.*)$',line)
        if found:return parse_snbt_json(found[1])
    raise ValueError('未找到规则Dialog')


def _component(value):
    if isinstance(value,str):return {'text':value,'color':'white'}
    if value.get('__dynamic__'):return value
    value=dict(value)
    value['color']='white'
    value.pop('bold',None)
    return value


def make_dialog(namespace):
    record=json.loads(SOURCE.read_text(encoding='utf-8'))[namespace]
    body=[]
    for section in SECTIONS:
        paragraphs=record['sections'].get(section,[])
        if section=='暂停与结束':paragraphs=[{'text':PAUSE}]+paragraphs
        if section=='管理命令':paragraphs=[{'text':f'有命令权限的管理员可在同维度牌桌8格内执行 /function {namespace}:admin/abort，中止最近一场本游戏并保留牌桌。普通玩家通过桌边菜单和游戏操作物游玩。'}]
        if not paragraphs:continue
        contents=[{'text':section+'\n','color':'aqua','bold':True}]
        for index,paragraph in enumerate(paragraphs):
            if index:contents.append({'text':'\n\n'})
            heading=paragraph.get('heading','')
            if heading and heading!=section:
                contents.append({'text':heading+'：','color':'white','bold':True})
            parts=paragraph.get('contents',[{'text':paragraph.get('text','')}])
            contents.extend(_component(p) for p in parts)
        body.append({'type':'minecraft:plain_message','width':WIDTH,'contents':contents})
    dialog={'type':'minecraft:notice','title':{'text':record['name']+' · 游戏规则','color':'gold','bold':True},
            'body':body,'action':{'label':{'text':'关闭规则'},'width':140},'pause':False,'can_close_with_escape':True}
    if namespace=='liars_holdem':
        dialog['action']={'label':{'text':'查看牌型大小','color':'gold'},'width':140,
                          'action':{'type':'minecraft:run_command','command':'trigger lh_help set 1'}}
    return dialog


def normalize_rule_output(path,text):
    """供所有游戏生成器的write_guarded调用；只替换规则命令，不改变上下文与清理。"""
    parts=Path(path).as_posix().split('/')
    try:
        index=parts.index('data')
        namespace=parts[index+1]
    except (ValueError,IndexError):return text
    if parts[index+2:index+4]!=['function','rules']:return text
    if parts[-1] not in ('show.mcfunction','show_dialog.mcfunction','open.mcfunction','player.mcfunction'):return text
    if not SOURCE.exists():return text
    records=json.loads(SOURCE.read_text(encoding='utf-8'))
    if namespace not in records:return text
    # 花火show负责读取本桌动态设置；飞行棋show保留其已有open转发。
    if not re.search(r'^\$?dialog show ',text,re.M):return text
    payload=json.dumps(make_dialog(namespace),ensure_ascii=False,separators=(',',':'))
    if namespace=='hanabi':payload=payload.replace('{"__dynamic__":"storm"}','$(storm)')
    result=[]
    for line in text.splitlines():
        found=re.match(r'(\$?dialog show \S+) .+$',line)
        result.append(found[1]+' '+payload if found else line)
    return '\n'.join(result)+'\n'


def build():
    records=json.loads(SOURCE.read_text(encoding='utf-8'))
    count=0
    for namespace in records:
        for name in ('show','show_dialog','open','player'):
            p=PACK/f'data/{namespace}/function/rules/{name}.mcfunction'
            if not p.exists():continue
            before=p.read_text(encoding='utf-8')
            after=normalize_rule_output(p,before)
            p.write_text(after,encoding='utf-8')
            count+=int(before!=after)
    print(f'已统一{len(records)}个游戏规则（{count}个窗口更新）。')


if __name__=='__main__':build()
