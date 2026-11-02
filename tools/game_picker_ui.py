"""便携的选游界面读写；只重建文本组件，不读取个人素材或复制资源包。"""
from pathlib import Path
import copy
import json
import re

PACK=Path(__file__).resolve().parents[1]
ICON_COLUMNS=5
ICON_ROW_WIDTH=ICON_COLUMNS*80+10


def game_number(action):
    match=re.search(r'\$\(p(\d+)\)',action.get('action',{}).get('command',''))
    return int(match[1]) if match else 100000


def load_picker(pack,capacity):
    """提供注册脚本使用的动作元数据；支持旧按钮和新的八切片图标。"""
    pack=Path(pack);path=pack/f'data/cardtable/function/menu/picker/show{capacity}.mcfunction'
    text=path.read_text(encoding='utf-8');current=json.loads(text[text.index('{'):])
    if 'actions' in current:return current
    backup=pack/f'docs/game-icons/picker{capacity}-original.json'
    meta=json.loads(backup.read_text(encoding='utf-8')) if backup.exists() else {'type':'minecraft:multi_action','columns':3,'pause':False,'exit_action':{'label':{'text':'取消'}}}
    actions={}
    for block in current.get('body',[]):
        for tile in block.get('contents',{}).get('extra',[]):
            click=tile.get('click_event',{});hover=tile.get('hover_event',{})
            if click.get('action')!='run_command':continue
            number=int(re.search(r'\$\(p(\d+)\)',click['command'])[1])
            action=copy.deepcopy(next((entry for entry in meta.get('actions',[]) if game_number(entry)==number),{'width':150}))
            action['label']=copy.deepcopy(hover.get('value',hover.get('contents')))
            action['action']={'type':'minecraft:run_command','command':click['command']}
            number=game_number(action)
            if number in actions:assert actions[number]==action,'同图标不同切片提交值或悬停文本不一致'
            actions[number]=action
    assert actions,'图标窗口没有可识别的游戏动作'
    meta['title']=current['title'];meta['actions']=[actions[key] for key in sorted(actions)]
    return meta


def render_icons(meta):
    actions=meta['actions']
    body=[{'type':'minecraft:plain_message','width':ICON_ROW_WIDTH,'contents':{'text':'点击图标选择游戏；悬停查看人数。','color':'gray'}}]
    for row in range(0,len(actions),ICON_COLUMNS):
        extra=[]
        for strip in range(8):
            for action in actions[row:row+ICON_COLUMNS]:
                game=game_number(action)
                assert 1<=game<64,'新编号超出当前图标字体编码范围，须先扩展字形协议'
                extra.append({'text':chr(0xE600+game*8+strip),'font':'card:game_icons','color':'white','shadow_color':0,
                              'click_event':{'action':'run_command','command':action['action']['command']},
                              'hover_event':{'action':'show_text','value':action['label']}})
                extra.append({'text':chr(0xE800+game*8+strip),'font':'card:game_icons'})
            if strip<7:extra.append({'text':'\n'})
        body.append({'type':'minecraft:plain_message','width':ICON_ROW_WIDTH,'contents':{'text':'','extra':extra}})
    return {'type':'minecraft:notice','title':meta['title'],'body':body,'action':{'label':{'text':'取消'}},'pause':False,'after_action':'close'}


def write_picker(pack,capacity,meta):
    pack=Path(pack);path=pack/f'data/cardtable/function/menu/picker/show{capacity}.mcfunction'
    text=path.read_text(encoding='utf-8');current=json.loads(text[text.index('{'):])
    meta=copy.deepcopy(meta);meta['actions'].sort(key=game_number)
    icon_mode=current.get('type')=='minecraft:notice'
    if icon_mode:
        backup=pack/f'docs/game-icons/picker{capacity}-original.json';backup.parent.mkdir(parents=True,exist_ok=True)
        backup.write_text(json.dumps(meta,ensure_ascii=False,separators=(',',':'))+'\n',encoding='utf-8')
    dialog=render_icons(meta) if icon_mode else meta
    path.write_text('$dialog show @a[tag=ct.switch_actor,limit=1] '+json.dumps(dialog,ensure_ascii=False,separators=(',',':'))+'\n',encoding='utf-8')


def set_label(pack,capacity,game,label):
    meta=load_picker(pack,capacity)
    entry=next(action for action in meta['actions'] if game_number(action)==game)
    entry['label']={'text':label};write_picker(pack,capacity,meta)


def build_picker(pack=PACK):
    """依据已提交的动作备份重建窗口；不生成或触碰任何纹理。"""
    for capacity in (4,8):
        source=Path(pack)/f'docs/game-icons/picker{capacity}-original.json'
        write_picker(pack,capacity,json.loads(source.read_text(encoding='utf-8')))


if __name__=='__main__':
    build_picker()
    print('已从仓库动作元数据重建四人桌与八人桌图标窗口；未修改资源包。')
