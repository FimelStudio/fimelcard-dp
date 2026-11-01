"""导出情书原创宫廷肖像、原版模型与可编辑源文件。"""
import copy
import hashlib
import json
import shutil
from PIL import Image, ImageDraw, ImageFont
from boardgame_assets import PACK, RP, CARD, export_model, export_texture, json_file, text_file, cube, disc

ROLES = ('spy', 'guard', 'priest', 'baron', 'handmaid', 'prince', 'chancellor', 'king', 'countess', 'princess')
LABELS = ('SPY', 'GUARD', 'PRIEST', 'BARON', 'HANDMAID', 'PRINCE', 'CHANCELLOR', 'KING', 'COUNTESS', 'PRINCESS')
SOURCE = RP/'.source/love_letter'
W, H = 256, 384
BURGUNDY, GOLD, PAPER, INK = '#742738', '#d8b668', '#f4e9ce', '#352a23'
FONT_SIZE = (128, 192)


def font_assets():
    """为字体单独导出牌面，不能将 256×384 物品纹理直接交给字体。

    26.2 客户端的 FontTexture 图集只有 256×256。BitmapProvider 的
    height 只改变显示比例，上传的字形仍是 PNG 的原始像素大小。
    保留物品原图，字体使用相同比例的 128×192 缩略图。
    """
    target = CARD/'textures/font/love_letter'
    target.mkdir(parents=True, exist_ok=True)
    for selected in (False, True):
        providers = []
        for index, role in enumerate(ROLES):
            name = role + ('_selected' if selected else '')
            with Image.open(CARD/f'textures/item/love_letter/{name}.png') as source:
                source.resize(FONT_SIZE, Image.Resampling.LANCZOS).save(target/f'{name}.png')
            providers.append({'type':'bitmap','file':f'card:font/love_letter/{name}.png',
                              'ascent':50,'height':54,'chars':[chr(0xe800+index)]})
        json_file(CARD/f'font/love_letter/dialog{"_selected" if selected else ""}.json',{'providers':providers})


def font(size, bold=False):
    return ImageFont.truetype('C:/Windows/Fonts/' + ('georgiab.ttf' if bold else 'georgia.ttf'), size)


def frame(draw, selected=False):
    draw.rounded_rectangle((1, 1, 254, 382), radius=17, fill=BURGUNDY, outline='#392122', width=2)
    draw.rounded_rectangle((7, 7, 248, 376), radius=13, fill=PAPER, outline=GOLD, width=3)
    draw.rounded_rectangle((13, 13, 242, 370), radius=8, outline='#b79955', width=1)
    if selected:
        draw.rounded_rectangle((2, 2, 253, 381), radius=16, outline='#fff3a2', width=7)


def seal(draw, x, y, r, letter=True):
    draw.ellipse((x-r+1, y-r+3, x+r+1, y+r+3), fill='#a48a5c')
    draw.ellipse((x-r, y-r, x+r, y+r), fill=BURGUNDY, outline='#471a24', width=2)
    draw.ellipse((x-r+5, y-r+5, x+r-5, y+r-5), outline='#b8666e', width=2)
    if letter:
        rr = r*.52
        draw.polygon([(x,y+rr*.88),(x-rr,y-rr*.12),(x-rr*.75,y-rr*.65),(x-rr*.25,y-rr*.7),(x,y-rr*.3),
                      (x+rr*.25,y-rr*.7),(x+rr*.75,y-rr*.65),(x+rr,y-rr*.12)], fill=GOLD)


def front(atlas, role, index):
    """用固定排版生成牌面，仅肖像插画来自图像生成。"""
    image = Image.new('RGB', (W,H), PAPER)
    draw = ImageDraw.Draw(image)
    frame(draw)
    # 等分坐标与原始五列、两行的肖像图集一致。
    col, row = index%5, index//5
    left, top = round(col*atlas.width/5), round(row*atlas.height/2)
    right, bottom = round((col+1)*atlas.width/5), round((row+1)*atlas.height/2)
    portrait = atlas.crop((left, top, right, bottom)).resize((216, 278), Image.Resampling.LANCZOS)
    image.paste(portrait, (20,36))
    draw.rectangle((19,35,236,314), outline='#a78b4c', width=2)
    draw.rectangle((21,316,234,363), fill=PAPER)
    text_size = 18 if len(LABELS[index])>9 else 21
    draw.text((128,337), LABELS[index], anchor='mm', font=font(text_size, True), fill=INK)
    draw.line((45,357,211,357), fill='#bda26c', width=1)
    draw.ellipse((14,14,65,65), fill=BURGUNDY, outline=GOLD, width=3)
    draw.text((39,39), str(index), anchor='mm', font=font(36, True), fill='#fff6d7')
    draw.ellipse((209,287,241,319), fill=BURGUNDY, outline=GOLD, width=2)
    draw.text((225,303), str(index), anchor='mm', font=font(22, True), fill='#fff6d7')
    return image


def back():
    image = Image.new('RGB', (W,H), PAPER)
    draw = ImageDraw.Draw(image);frame(draw)
    draw.rounded_rectangle((20,20,235,363), radius=8, fill=BURGUNDY, outline=GOLD, width=2)
    for y in range(32,365,20):
        for x in range(30,240,20):
            draw.polygon([(x,y-3),(x+3,y),(x,y+3),(x-3,y)], fill='#914454')
    draw.rounded_rectangle((49,124,206,257), radius=8, fill=PAPER, outline=GOLD, width=3)
    draw.line((50,128,128,193,205,128), fill='#c3ab77', width=3)
    draw.line((50,255,111,195), fill='#c3ab77', width=2)
    draw.line((205,255,145,195), fill='#c3ab77', width=2)
    seal(draw,128,195,29)
    draw.text((128,299), 'LOVE', anchor='mm', font=font(23,True), fill='#edd9a4')
    draw.text((128,325), 'LETTER', anchor='mm', font=font(23,True), fill='#edd9a4')
    return image


def card_model(role):
    # 保持 fake_card.json 的十二乘十八外形，以及北面为正面的约定。
    element = cube([1,0,8], [13,18,8.35], 'edge', 'card')
    element['faces']['north'] = {'texture':'#front', 'uv':[0,0,16,16]}
    element['faces']['south'] = {'texture':'#back', 'uv':[16,0,0,16]}
    model = {'credit':'Fimel Cards original court cards; portrait atlas generated with built-in image_gen',
             'textures': {'front':f'card:item/love_letter/{role}', 'back':'card:item/love_letter/back',
                          'edge':'card:item/love_letter/edge','particle':f'card:item/love_letter/{role}'},
             'elements':[element]}
    base = json.loads((CARD/'models/item/fake_card.json').read_text(encoding='utf-8'))
    model['display'] = base['display']
    return model


def build():
    SOURCE.mkdir(parents=True,exist_ok=True)
    atlas_path = SOURCE/'portraits_original.png'
    if not atlas_path.exists():
        raise SystemExit('Restore .source/love_letter/portraits_original.png before rebuilding the art.')
    atlas = Image.open(atlas_path).convert('RGB')
    # 同时在源文件与资源包纹理中保留完整的原始肖像图集。
    export_texture('love_letter','portraits',atlas)
    export_texture('love_letter','edge',Image.new('RGB',(16,16),'#ead9b0'))
    preview = Image.new('RGB',(W*5,H*2),'#2e2025')
    for index, role in enumerate(ROLES):
        image = front(atlas,role,index)
        export_texture('love_letter',role,image)
        preview.paste(image,(index%5*W,index//5*H))
        selected = image.copy(); draw = ImageDraw.Draw(selected)
        draw.rounded_rectangle((1,1,254,382),radius=16,outline='#fff3a2',width=7)
        export_texture('love_letter',role+'_selected',selected)
        export_model('love_letter',role,card_model(role))
    export_texture('love_letter','back',back())
    export_model('love_letter','back',card_model('back'))
    box_image = back().resize((256,384),Image.Resampling.NEAREST)
    export_texture('love_letter','box',box_image)
    box = cube([6,0,7],[16,16,11],'side','court_card_box')
    box['faces']['north']={'texture':'#front','uv':[0,0,16,16]}
    box['faces']['south']={'texture':'#front','uv':[16,0,0,16]}
    basebox=json.loads((CARD/'models/item/cardbox.json').read_text(encoding='utf-8'))
    export_model('love_letter','box',{'textures':{'front':'card:item/love_letter/box','side':'card:item/love_letter/edge',
                  'particle':'card:item/love_letter/box'},'elements':[box],'display':basebox['display']})
    favor=Image.new('RGB',(128,128),'#cba253');draw=ImageDraw.Draw(favor)
    for radius in range(60,0,-1):
        shade=round(148+70*(1-radius/60))
        draw.ellipse((64-radius,64-radius,64+radius,64+radius),fill=(shade,round(shade*.71),round(shade*.27)))
    draw.ellipse((8,8,120,120),outline='#fff0b0',width=4)
    seal(draw,64,64,45)
    export_texture('love_letter','favor',favor)
    export_texture('love_letter','favor_edge',Image.new('RGB',(16,16),'#b18b42'))
    export_model('love_letter','favor',disc('card:item/love_letter/favor','card:item/love_letter/favor_edge',height=1.2))
    export_texture('love_letter','protection',Image.new('RGB',(16,16),'#72d8c3'))
    protect={'textures':{'all':'card:item/love_letter/protection','particle':'card:item/love_letter/protection'},'elements':[
        cube([.2,0,.2],[15.8,.08,.6]),cube([.2,0,15.4],[15.8,.08,15.8]),
        cube([.2,0,.6],[.6,.08,15.4]),cube([15.4,0,.6],[15.8,.08,15.4])]}
    export_model('love_letter','protection',protect)
    font_assets()
    preview.save(SOURCE/'cards_preview.png')
    prompt=(PACK/'tools/love_letter_image_prompt.txt').read_text(encoding='utf-8')
    text_file(SOURCE/'prompt.txt',prompt)
    text_file(SOURCE/'README.md','''# 情书原创资源

宫廷角色肖像由内置 image_gen 生成，使用原创人物与服饰；未临摹商业《情书》插画。完整原图保存在 portraits_original.png，生成提示词见 prompt.txt。
十个角色按 5 列 × 2 行排列：spy、guard、priest、baron、handmaid；prince、chancellor、king、countess、princess。
生成图只负责肖像。256×384 牌面的数字、英文名、信封、封蜡、金色边框和好感标记均由确定性资源脚本绘制。
资源名使用角色英文名，不使用连续 c0 编号。物品保留 256×384 牌面；对话框和私人 HUD 使用 textures/font/love_letter/ 下的 128×192 专用字形，避免超过原版 256×256 字体图集限制。
models/ 保存可编辑 Blockbench Java 模型与嵌入纹理；牌和牌盒参照本项目 fake_card / cardbox 原有尺寸。
另有八段原创合成音效，保留 audio/ 中的无损 WAV 源文件；audio_manifest.json 记录发布 OGG 的时长及 SHA-256，来源与重建方式见 audio/README.md。
从数据包目录运行 python tools/build_love_letter_assets.py 可重建；需要 Pillow 及 Windows Georgia 字体。重建不会重新调用图像生成服务。
''')
    manifest={'generator':'built-in image_gen','atlas':str(atlas_path.relative_to(RP)).replace('\\','/'),
              'atlas_sha256':hashlib.sha256(atlas_path.read_bytes()).hexdigest(),'grid':[5,2],
              'roles':list(ROLES),'front_pixels':[W,H],'model_prefix':'card:love_letter/'}
    json_file(SOURCE/'manifest.json',manifest)
    print('Exported 10 court cards, card back, box, favor and editable Blockbench sources.')


if __name__=='__main__':
    build()
