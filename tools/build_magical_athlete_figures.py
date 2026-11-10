"""36 个独立体素运动员：桌面脚底统一在模型 Y=8，手持使用独立姿态。"""
import hashlib
import json
import math
from PIL import Image, ImageDraw, ImageFont
from boardgame_assets import PACK, RP, CARD, export_model, export_texture, json_file

GAME='magical_athlete'
SOURCE=RP/'.source'/GAME
CHARS=json.loads((PACK/'tools/magical_athlete_characters.json').read_text(encoding='utf-8'))
COLORS={
    'ink':'#26313f','white':'#fff4dc','cream':'#e8d9ad','skin':'#e6b181',
    'brown':'#92613f','darkbrown':'#593e32','gold':'#e9b53f','yellow':'#ffe26b',
    'orange':'#e88d42','red':'#d95152','pink':'#ec94ab','rose':'#bc456e',
    'green':'#69b37a','lime':'#b4d865','darkgreen':'#356b59','teal':'#50b7b4',
    'blue':'#5b9dcc','navy':'#3d577f','purple':'#9676b8','darkpurple':'#59446f',
    'gray':'#91a0a8','silver':'#c2d2d2','black':'#20232b','cyan':'#a4e9e0',
    'hair':'#cf9648','leaf':'#3a955b','flame':'#ffbf55','stone':'#828493',
    'lightstone':'#b0adbe','paper':'#efdfb9','mint':'#a5d8ac','rust':'#af6545',
}
COLOR_INDEX={name:i for i,name in enumerate(COLORS)}
SIDES={'west':(0,0),'east':(0,1),'down':(1,0),'up':(1,1),'north':(2,0),'south':(2,1)}
DISPLAY={
    'gui':{'rotation':[25,225,0],'translation':[0,-4.8,0],'scale':[.62,.62,.62]},
    'firstperson_righthand':{'rotation':[0,160,0],'translation':[-2,3.5,1.5],'scale':[.30,.30,.30]},
    'firstperson_lefthand':{'rotation':[0,200,0],'translation':[-2,3.5,1.5],'scale':[.30,.30,.30]},
    'thirdperson_righthand':{'rotation':[75,45,0],'translation':[0,1,0],'scale':[.24,.24,.24]},
    'thirdperson_lefthand':{'rotation':[75,225,0],'translation':[0,1,0],'scale':[.24,.24,.24]},
    'ground':{'translation':[0,1,0],'scale':[.30,.30,.30]},
    'fixed':{'rotation':[0,180,0],'translation':[0,-5,0],'scale':[.6,.6,.6]},
    'head':{'translation':[0,-5,0],'scale':[.6,.6,.6]},
}


def subtract_box(part,cut):
    """AABB 布尔差：最多六个实心方块，保留原材质与部件名。"""
    low=[max(part['from'][i],cut['from'][i]) for i in range(3)]
    high=[min(part['to'][i],cut['to'][i]) for i in range(3)]
    if any(high[i]<=low[i] for i in range(3)):return [part]
    remaining_low=part['from'][:];remaining_high=part['to'][:];pieces=[]
    for axis in range(3):
        if remaining_low[axis]<low[axis]:
            end=remaining_high[:];end[axis]=low[axis]
            pieces.append({**part,'from':remaining_low[:],'to':end})
        if high[axis]<remaining_high[axis]:
            start=remaining_low[:];start[axis]=high[axis]
            pieces.append({**part,'from':start,'to':remaining_high[:]})
        remaining_low[axis]=low[axis];remaining_high[axis]=high[axis]
    return pieces


def solid_parts(parts):
    """后画的装饰拥有交集；体积不重叠，外部同向面也不会重叠。"""
    result=[]
    for part in parts:
        result=[piece for old in result for piece in subtract_box(old,part)]+[part]
    return result


def subtract_rect(rect,cut):
    a,b,c,d=rect;u,v,w,z=cut
    u=max(a,u);v=max(b,v);w=min(c,w);z=min(d,z)
    if u>=w or v>=z:return [rect]
    pieces=[(a,b,u,d),(w,b,c,d),(u,b,w,v),(u,z,w,d)]
    return [r for r in pieces if r[0]<r[2] and r[1]<r[3]]


def surface_faces(part,parts):
    """裁去所有内部面；部分露出的面返回互不重叠的矩形。"""
    visible={}
    for side,(axis,upper) in SIDES.items():
        other_axes=[i for i in range(3) if i!=axis]
        u,v=other_axes;plane=part['to' if upper else 'from'][axis]
        remaining=[(part['from'][u],part['from'][v],part['to'][u],part['to'][v])]
        for other in parts:
            if other is part:continue
            outward=(other['from'][axis]<=plane<other['to'][axis]) if upper else (other['from'][axis]<plane<=other['to'][axis])
            if not outward:continue
            cut=(other['from'][u],other['from'][v],other['to'][u],other['to'][v])
            remaining=[piece for rect in remaining for piece in subtract_rect(rect,cut)]
            if not remaining:break
        if remaining:visible[side]=remaining
    return visible


class Figure:
    def __init__(self):self.parts=[]
    def box(self,name,bounds,color):
        assert color in COLORS,color
        self.parts.append({'name':name,'from':list(bounds[:3]),'to':list(bounds[3:]),'color':color})
    def eyes(self,y=14,z=4.8,left=6,right=9,color='ink'):
        for name,x in (('left',left),('right',right)):
            self.box(name+'_eye',(x,y,z,x+1,y+1,z+.35),color)
    def human(self,coat='blue',hair='hair',skin='skin',arms=True):
        for name,x in (('left',4.5),('right',9)):
            self.box(name+'_boot',(x,0,5.5,x+2.5,1.8,10),'ink')
            self.box(name+'_leg',(x+.3,1.5,6.4,x+2.2,6,9),coat)
        self.box('body',(4,6,5,12,11.5,10.5),coat)
        self.box('head',(5,11.5,5,11,16,10.5),skin)
        self.box('hair',(5,15,5,11,17,10.5),hair)
        if arms:
            self.box('left_arm',(2,7,6,4,11,9),coat)
            self.box('right_arm',(12,7,6,14,11,9),coat)
        self.eyes()
    def mesh(self):
        low=[min(p['from'][axis] for p in self.parts) for axis in range(3)]
        high=[max(p['to'][axis] for p in self.parts) for axis in range(3)]
        factor=min(1,14/max(high[0]-low[0],high[2]-low[2]),18/(high[1]-low[1]))
        center=((low[0]+high[0])/2,low[1],(low[2]+high[2])/2)
        result=[]
        parts=solid_parts(self.parts)
        for serial,part in enumerate(parts):
            index=COLOR_INDEX[part['color']];u=(index%8)*2;v=(index//8)*2
            points={key:[round(8+(part[key][axis]-center[axis])*factor,6) for axis in range(3)] for key in ('from','to')}
            whole={};patches=[]
            for side,rects in surface_faces(part,parts).items():
                axis,upper=SIDES[side];a,b=[i for i in range(3) if i!=axis]
                full=(part['from'][a],part['from'][b],part['to'][a],part['to'][b])
                face={'texture':'#palette','uv':[u,v,u+2,v+2]}
                if rects==[full]:whole[side]=face;continue
                for patch_index,rect in enumerate(rects):
                    bounds={'from':part['from'][:],'to':part['to'][:]}
                    bounds['from'][axis]=bounds['to'][axis]=part['to' if upper else 'from'][axis]
                    bounds['from'][a],bounds['from'][b],bounds['to'][a],bounds['to'][b]=rect
                    patch_points={key:[round(8+(bounds[key][i]-center[i])*factor,6) for i in range(3)] for key in ('from','to')}
                    patches.append({'name':part['name']+'_'+str(serial)+'_surface_'+side+'_'+str(patch_index),**patch_points,'faces':{side:face}})
            result.append({'name':part['name']+'_'+str(serial),**points,'faces':whole})
            result.extend(patches)
        return result


def sculpt(slug):
    f=Figure();b=f.box
    if slug=='alchemist':
        b('flask_foot',(3,0,4,13,2,12),'darkgreen');b('glass_belly',(2,2,3,14,7,13),'teal')
        b('liquid',(3,2.5,2.8,13,5,3.2),'lime');b('flask_shoulder',(4,7,5,12,10,11),'cyan')
        b('neck',(6,10,6,10,15,10),'cyan');b('rim',(5.4,15,5.4,10.6,16.5,10.6),'gold')
        b('cork',(6,16.5,6,10,18,10),'brown');f.eyes(5.5,2.6,5,10)
    elif slug=='baba-yaga':
        f.human('darkpurple','gray');b('witch_brim',(2,16.4,3,14,17.3,12),'ink')
        b('hat',(5,17.3,5,11,20,10),'purple');b('hat_tip',(4,20,6,8,22,9),'purple')
        b('hook_nose',(7,12,3,9,14,5),'skin');b('broom_handle',(14,0,7,15,15,8),'brown')
        b('broom',(12.5,0,5.5,16,4,9.5),'gold')
    elif slug=='banana':
        for name,box in [('tip',(4,0,6,7,3,10)),('lower',(5,2,5,10,6,11)),('middle',(8,5,5,13,11,11)),('upper',(9,10,6,13,15,10)),('stem',(8,14,6,11,17,10))]:b(name,box,'yellow')
        b('brown_stem',(8,16,6,10,18,9),'brown');b('peel_left',(3,5,6,7,9,8),'gold')
        b('peel_right',(12,5,7,15,9,9),'gold');f.eyes(10.5,4.7,9,11)
    elif slug=='blimp':
        b('gondola',(5,0,6,11,3,10),'brown');b('suspension_left',(5.5,3,6.5,6.5,6,7.5),'ink')
        b('suspension_right',(9.5,3,8.5,10.5,6,9.5),'ink')
        b('balloon',(2,6,4,14,12,12),'orange');b('nose',(0,7.5,5.5,2,10.5,10.5),'yellow')
        b('tail',(14,7,5,16,11,11),'gold');b('top_fin',(12,11,7,15,15,9),'red')
        b('side_fin',(12,8,1.5,15,10,14.5),'red');b('stripe',(5,5.7,3.8,7,12.3,12.2),'cream')
        b('cabin_window',(6,1,5.7,10,2.3,6),'cyan')
    elif slug=='centaur':
        for i,(x,z) in enumerate(((3,4),(10,4),(3,10),(10,10))):b('horse_leg_'+str(i),(x,0,z,x+2,6,z+2),'brown')
        b('horse_body',(2,5,3,13,10,13),'brown');b('tail',(12,8,12,16,10,14),'darkbrown')
        b('torso',(4,10,3.5,10,14,9),'skin');b('human_head',(4,14,3.5,10,18,9),'skin')
        b('mane',(4,17,5,10,19,10),'darkbrown');b('spear',(13,1,4,14,18,5),'gold')
        b('spear_tip',(12,18,3,15,21,6),'silver');f.eyes(15.5,3.2,5,8)
    elif slug=='cheerleader':
        f.human('rose','hair',arms=False);b('skirt',(2.5,5,3.5,13.5,8,12),'pink')
        b('left_raised_arm',(1,10,6,4,15,9),'skin');b('right_raised_arm',(12,10,6,15,15,9),'skin')
        for name,x in (('left',-.5),('right',13)):
            b(name+'_pom',(x,14,4,x+3.5,18,11),'yellow');b(name+'_pom_cross',(x-1,15,6,x+4.5,17,9),'white')
        b('ponytail',(10,14,10,13,18,12),'hair')
    elif slug=='coach':
        f.human('green','brown');b('cap',(4,16,4,12,18,11),'darkgreen');b('cap_peak',(4,15.6,2,12,16.4,5),'darkgreen')
        b('whistle',(7,8,4.4,9,9.4,5),'silver');b('clipboard',(12.5,5,3,16,11,4),'paper')
        b('clip',(13.5,10.5,2.7,15,12,4),'ink');b('stripe',(7,6.2,4.7,9,11,5),'white')
    elif slug=='copycat':
        b('cat_feet',(3,0,4,13,2,12),'purple');b('cat_body',(4,2,5,12,8,12),'purple')
        b('cat_head',(3,8,3,13,15,11),'purple');b('ear_left',(3,14,4,6,18,8),'darkpurple')
        b('ear_right',(10,14,4,13,18,8),'darkpurple');b('muzzle',(5,9,2,11,12,4),'white')
        f.eyes(12,2.7,5,10,'lime');b('tail_up',(12,3,11,15,15,14),'purple')
        b('tail_curl',(10,13,11,15,16,14),'purple');b('nose',(7,10.8,1.7,9,11.8,2.2),'rose')
    elif slug=='dicemonger':
        f.human('orange','brown');b('pack',(3,6,10,13,14,14),'darkbrown')
        for i,(x,y,z) in enumerate(((1,2,2),(10,2,2),(5,16,4))):
            b('die_'+str(i),(x,y,z,x+5,y+5,z+5),'white')
            for j in range(i+1):b('pip_'+str(i)+'_'+str(j),(x+1+j,y+2,z-.2,x+1.6+j,y+2.6,z),'ink')
    elif slug=='duelist':
        f.human('navy','brown');b('helmet',(4,15,4,12,18,11),'silver')
        b('helmet_crest',(7,18,5,9,21,10),'red');b('sword',(14,4,5,15,21,6),'silver')
        b('guard',(12.5,5.5,4,16.5,6.5,7),'gold');b('shield',(0,6,3,4,13,5),'blue')
        b('shield_cross',(1.5,7,2.7,2.5,12,3),'gold')
    elif slug=='egg':
        b('feet_left',(3.5,0,5,6.5,2,10),'orange');b('feet_right',(9.5,0,5,12.5,2,10),'orange')
        b('egg_lower',(3,2,3,13,9,13),'white');b('egg_middle',(2,6,2,14,12,14),'white')
        b('egg_upper',(4,12,4,12,16,12),'cream');b('egg_top',(6,16,6,10,18,10),'white')
        f.eyes(9,1.7,5,10);b('crack',(7,3,2.7,8,5.5,3),'gold')
    elif slug=='flip-flop':
        b('sole',(2,0,3,14,2,13),'navy');b('upright_sandal',(3,2,7,13,17,10),'teal')
        b('heel',(4,2,6.5,12,6,10.5),'blue');b('strap_left',(3,9,5.5,8,11,7),'pink')
        b('strap_right',(8,9,5.5,13,11,7),'pink');b('toe_post',(7,6,5,9,10,7),'rose')
        f.eyes(13,6.7,5,10)
    elif slug=='genius':
        f.human('white','pink');b('brain_left',(2.5,15,3,8,20,11),'pink')
        b('brain_right',(8,15,3,13.5,20,11),'rose');b('brain_top',(5,20,5,11,21.5,9),'pink')
        b('glasses',(4.5,13,4.5,11.5,15,5),'navy');b('lenses',(5,13.4,4.3,11,14.5,4.6),'cyan')
        b('book',(1,5,2,6,10,4),'blue')
    elif slug=='gunk':
        b('puddle',(1,0,2,15,2,14),'darkgreen');b('lower_slime',(2,2,3,14,7,13),'green')
        b('slime',(4,7,4,13,12,12),'lime');b('slime_tower',(5,12,5,10,16,11),'green')
        b('drip',(12,5,2,15,10,5),'lime');b('antenna',(7,16,6,9,19,8),'lime')
        f.eyes(9,3.6,6,10);b('grin',(7,6,2.6,11,7,3.1),'darkgreen')
    elif slug=='hare':
        b('hind_feet',(1,0,3,15,2,12),'cream');b('haunch',(3,2,5,13,7,13),'white')
        b('body',(5,6,4,11,11,11),'white');b('head',(4,11,3,12,16,10),'white')
        b('left_ear',(4,16,5,6.5,23,8),'cream');b('right_ear',(9.5,16,5,12,22,8),'cream')
        b('ear_pink',(4.7,17,4.7,5.8,22,5),'pink');b('tail',(11,5,12,14,8,15),'white');f.eyes(13,2.7,5,10)
    elif slug=='heckler':
        f.human('red','black');b('backwards_cap',(4,16,4,12,18,12),'navy')
        b('megaphone_handle',(1,7,3,3,11,5),'ink');b('megaphone_neck',(1,10,2,4,13,5),'gold')
        b('megaphone_bell',(-2,8,0,1,15,7),'orange');b('megaphone_hole',(-2.2,9,.8,-1.8,14,6.2),'ink')
        b('waving_hand',(13,12,5,16,17,8),'skin')
    elif slug=='huge-baby':
        b('baby_feet',(2,0,3,14,2,12),'skin');b('diaper',(2,2,4,14,5,13),'white')
        b('baby_body',(3,5,4,13,10,12),'pink');b('huge_head',(1,10,2,15,19,14),'skin')
        b('curl',(7,19,7,10,21,9),'hair');f.eyes(15,1.7,4,11)
        b('pacifier',(6,11,1,10,13,2),'teal');b('baby_bottle',(14,5,4,17,11,7),'cyan')
    elif slug=='hypnotist':
        f.human('darkpurple','black');b('cape',(3,3,10,13,14,13),'purple')
        b('hat_brim',(3,16,3,13,17,12),'ink');b('top_hat',(5,17,5,11,22,10),'ink')
        b('chain',(13.5,7,4,14,15,4.5),'gold');b('pendulum',(12,4,3,15.5,8,5),'gold')
        b('pendulum_dot',(13,5,2.8,14.5,6.5,3),'white')
    elif slug=='inchworm':
        for i,(x,y) in enumerate(((1,0),(3,3),(5,6),(7,7),(9,5),(11,2))):
            b('segment_'+str(i),(x,y,5,x+3,y+4,11),'lime' if i%2 else 'green')
        b('head',(11,4,4,15,9,12),'yellow');b('antenna_left',(12,9,5,13,12,6),'darkgreen')
        b('antenna_right',(14,9,9,15,12,10),'darkgreen');f.eyes(7,3.7,12,14)
    elif slug=='lackey':
        f.human('gray','brown');b('hunched_back',(4,8,9,13,14,13),'navy')
        b('servant_cap',(4,16,4,12,18,10),'gray');b('towel',(2,5,4,4,10,9),'white')
        b('tray',(11,10,0,17,11,6),'silver');b('tea',(13,11,1,15,14,4),'gold')
        b('moustache',(6,12,4.6,10,13,5),'darkbrown')
    elif slug=='leaptoad':
        b('left_back_leg',(1,0,3,5,4,13),'darkgreen');b('right_back_leg',(11,0,3,15,4,13),'darkgreen')
        b('frog_belly',(4,2,4,12,8,12),'lime');b('frog_head',(2,7,3,14,11,13),'green')
        b('left_eye_mount',(2,11,3,6,15,7),'green');b('right_eye_mount',(10,11,3,14,15,7),'green')
        f.eyes(12,2.7,3.5,11.5);b('smile',(4,8,2.7,12,9,3),'darkgreen')
    elif slug=='legs':
        b('left_shoe',(2,0,2,7,2,10),'red');b('right_shoe',(9,0,2,14,2,10),'red')
        b('left_long_leg',(4,2,6,6.5,16,9),'blue');b('right_long_leg',(9.5,2,6,12,16,9),'blue')
        b('shorts',(3,15,5,13,19,10),'navy');b('tiny_face',(5,19,5,11,22,10),'cream');f.eyes(20,4.7,6,9)
    elif slug=='lovable-loser':
        b('flat_feet',(3,0,3,13,2,12),'navy');b('small_body',(5,2,5,11,7,11),'blue')
        b('sad_head',(3,7,3,13,15,12),'purple');b('left_floppy_ear',(1,9,5,4,15,9),'darkpurple')
        b('right_floppy_ear',(12,6,6,15,13,10),'darkpurple');f.eyes(11,2.7,5,10)
        b('tear',(10,8,2.5,11,10.5,3),'cyan');b('bandage',(4,13,2.7,8,14.5,3),'paper')
        b('broken_flower_stem',(1,2,2,2,9,3),'leaf');b('flower',(0,8,1,3,10,4),'pink')
    elif slug=='magician':
        f.human('navy','black');b('magician_cape',(2.5,3,10,13.5,14,13),'red')
        b('hat_brim',(2.5,16,3,13.5,17,12),'black');b('tall_hat',(5,17,5,11,22,10),'black')
        b('hat_band',(4.8,17.5,4.8,11.2,18.5,10.2),'rose');b('wand',(14,5,4,15,19,5),'cream')
        b('wand_tip',(13,18,3,16,21,6),'yellow');b('bow',(5,10,4.5,11,11,5),'red')
    elif slug=='mastermind':
        b('chair_base',(1,0,3,15,3,14),'darkpurple');b('chair_back',(2,3,11,14,16,15),'purple')
        b('chair_arms',(1,4,4,15,7,13),'darkpurple');b('body',(5,6,5,11,10,11),'ink')
        b('big_brain',(3,10,3,13,17,11),'rose');b('brain_ridge',(5,17,5,11,19,9),'pink')
        f.eyes(13,2.7,5,10);b('thinking_hand',(11,9,1,14,12,5),'skin')
    elif slug=='mouth':
        b('feet',(3,0,4,13,2,12),'rose');b('lower_lip',(1,2,2,15,5,12),'red')
        b('left_lip',(1,4,2,4,15,12),'rose');b('right_lip',(12,4,2,15,15,12),'rose')
        b('upper_lip',(3,13,2,13,16,12),'red');b('dark_throat',(4,5,9,12,13,11),'black')
        b('tongue',(5,4,1,11,6,9),'pink')
        for i in range(4):b('tooth_'+str(i),(4+i*2,11.5,2,5.4+i*2,14,5),'white')
    elif slug=='party-animal':
        b('animal_feet',(2,0,4,14,2,12),'teal');b('dino_body',(4,2,4,12,10,12),'teal')
        b('dino_head',(3,10,2,12,16,10),'green');b('snout',(3,10,0,12,13,3),'lime')
        b('tail',(11,4,11,16,7,15),'darkgreen');b('hat',(5,16,4,10,19,9),'pink')
        b('hat_top',(6,19,5,9,22,8),'gold');b('balloon_string',(0,5,5,.5,18,5.5),'ink')
        b('balloon',(0,17,4,3,22,8),'orange');f.eyes(13,1.7,5,9)
    elif slug=='rocket-scientist':
        b('flame',(5,0,5,11,4,11),'flame');b('booster',(4,3,4,12,6,12),'gray')
        b('rocket',(4,6,4,12,16,12),'white');b('nose',(5,16,5,11,19,11),'red')
        b('nose_tip',(7,19,7,9,22,9),'red')
        for i,(x,z) in enumerate(((1,6),(12,6),(6,12))):b('fin_'+str(i),(x,3,z,x+3,9,z+3),'red')
        b('goggles',(4,11,3.5,12,13.5,4),'navy');b('glass',(5,11.5,3.2,11,13,3.6),'cyan')
    elif slug=='romantic':
        b('left_foot',(3,0,5,6,2,10),'rose');b('right_foot',(10,0,5,13,2,10),'rose')
        b('heart_tip',(6,2,5,10,5,11),'red');b('heart_middle',(3,5,4,13,10,12),'red')
        b('left_lobe',(1,9,4,7.5,15,12),'pink');b('right_lobe',(8.5,9,4,15,15,12),'rose')
        f.eyes(9,3.7,5,10);b('rose_stem',(14,2,1,15,12,2),'leaf');b('rose',(12,11,0,17,15,4),'red')
    elif slug=='scoocher':
        b('scooter_deck',(1,1,3,15,3,13),'purple');b('wheel_left',(2,0,4,5,4,7),'ink')
        b('wheel_right',(11,0,10,14,4,13),'ink');b('crouched_body',(4,3,4,13,8,12),'orange')
        b('leaning_head',(1,8,3,10,14,11),'gold');b('reaching_arm',(0,5,1,7,7,4),'skin')
        b('push_foot',(12,2,12,16,4,16),'red');f.eyes(11,2.7,3,7)
    elif slug=='sisyphus':
        b('rock_lower',(6,0,4,15,4,13),'stone');b('boulder',(5,3,3,16,11,14),'lightstone')
        b('rock_top',(7,11,5,14,14,12),'stone');b('legs',(0,0,6,4,3,11),'brown')
        b('pushing_body',(0,3,6,4,10,11),'skin');b('head',(0,10,5,4,14,10),'skin')
        b('beard',(0,9,4,4,12,5),'darkbrown');b('arms',(2,6,4,7,8,7),'skin')
    elif slug=='skipper':
        b('boat_keel',(4,0,5,12,2,11),'darkbrown');b('hull',(1,2,3,15,5,13),'blue')
        b('deck',(2,5,4,14,6,12),'paper');b('captain',(4,6,5,8,11,9),'navy')
        b('head',(4,11,5,8,14,9),'skin');b('captain_hat',(3,14,4,9,16,10),'white')
        b('mast',(11,6,7,12,20,8),'brown');b('sail',(9,10,7,16,18,7.5),'white')
    elif slug=='stickler':
        b('left_foot',(3,0,4,6,2,11),'ink');b('right_foot',(10,0,4,13,2,11),'ink')
        b('ruler',(5,2,5,11,20,9),'gold')
        for i in range(7):b('tick_'+str(i),(5,3+i*2,4.7,7+(i%2),3.5+i*2,5),'brown')
        b('rule_book',(11,6,2,16,13,5),'navy');f.eyes(16,4.6,6,9)
    elif slug=='suckerfish':
        b('belly',(3,0,5,13,2,11),'teal');b('fish_body',(3,2,4,13,9,12),'blue')
        b('fish_head',(0,3,3,5,10,13),'teal');b('suction_mouth',(-1,4,5,0,9,11),'pink')
        b('tail',(13,2,2,16,10,14),'navy');b('dorsal_fin',(6,9,7,11,13,9),'teal')
        b('side_fin',(6,3,1,10,6,4),'cyan');f.eyes(7,2.7,1,3)
    elif slug=='third-wheel':
        for i,(x,z) in enumerate(((1,3),(10,3),(5.5,10))):
            b('wheel_'+str(i),(x,0,z,x+4.5,6,z+2),'ink')
            b('hub_'+str(i),(x+1.3,2,z-.2,x+3.2,4,z),'gold')
        b('axle',(3,3,4,13,4,12),'silver');b('fork',(7,4,8,9,11,10),'orange')
        b('handlebar',(3,11,7,13,12,9),'orange');b('smiling_head',(5,12,6,11,17,11),'yellow');f.eyes(14,5.7,6,9)
    elif slug=='twin':
        for i,x in enumerate((1,9)):
            color='teal' if i==0 else 'purple'
            b('feet_'+str(i),(x,0,5,x+5,2,11),'ink');b('body_'+str(i),(x,2,5,x+5,10,10),color)
            b('head_'+str(i),(x-.5,10,4,x+5.5,15,11),'skin');b('hair_'+str(i),(x-.5,15,4,x+5.5,17,11),color)
            b('eye_'+str(i),(x+1,12.5,3.7,x+2,13.5,4),'ink')
        b('joined_hands',(5,6,6,10,8,9),'skin')
    elif slug=='back':
        b('boots',(3,0,4,13,2,12),'ink');b('neutral_body',(4,2,5,12,10,11),'navy')
        b('neutral_head',(3,10,4,13,17,12),'darkpurple')
        for name,box in [('question_top',(5,14,3.6,11,15.5,4)),('question_side',(9.5,12,3.6,11,15,4)),('question_hook',(7,11,3.6,10,12.5,4)),('question_dot',(7,9,3.6,8.5,10.5,4))]:b(name,box,'gold')
    else:raise ValueError(slug)
    return f


def palette():
    image=Image.new('RGB',(16,16),'#000000');draw=ImageDraw.Draw(image)
    for index,color in enumerate(COLORS.values()):
        u=(index%8)*2;v=(index//8)*2;draw.rectangle((u,v,u+1,v+1),fill=color)
    export_texture(GAME,'figures/palette',image)
    (SOURCE/'textures/figures').mkdir(parents=True,exist_ok=True)
    image.save(SOURCE/'textures/figures/palette.png')


def build():
    palette();manifest=[]
    for entry in [*CHARS,{'slug':'back','id':-1,'name':'未公开选手'}]:
        slug=entry['slug'];figure=sculpt(slug);elements=figure.mesh()
        body={'credit':'Fimel Cards original voxel racer sculptures; character concepts from Magical Athlete',
              'gui_light':'front','textures':{'palette':'card:item/magical_athlete/figures/palette','particle':'card:item/magical_athlete/figures/palette'},
              'elements':elements,'display':DISPLAY}
        for kind in ('racer','token','hand'):
            export_model(GAME,kind+'/'+slug,body)
            source=SOURCE/f'models/{kind}/{slug}.bbmodel'
            editable=json.loads(source.read_text(encoding='utf-8'))
            editable['display']=DISPLAY;json_file(source,editable)
        if slug!='back':
            json_file(CARD/f'items/magical_athlete/hand/{slug}.json',{'model':{
                'type':'minecraft:select','property':'minecraft:display_context',
                'cases':[{'when':['gui','firstperson_righthand','firstperson_lefthand'],
                          'model':{'type':'minecraft:model','model':'card:item/magical_athlete/hand/'+slug}}],
                'fallback':{'type':'minecraft:model','model':'card:item/magical_athlete/hand/back'}}})
        mesh=[{'from':e['from'],'to':e['to']} for e in elements]
        manifest.append({'id':entry['id'],'slug':slug,'name':entry['name'],'design_parts':len(figure.parts),'cubes':len(elements),'base_y':8,
                         'geometry_sha256':hashlib.sha256(json.dumps(mesh,sort_keys=True).encode()).hexdigest()})
    json_file(SOURCE/'figures.json',{'style':'Original full-volume voxel miniatures','base_y':8,'geometry_cleanup':'Disjoint solid cuboids; later decoration owns intersections; all internal face regions clipped',
        'reference':'https://www.cmyk.games/products/magical-athlete','figures':manifest,'display':DISPLAY})
    preview()


def preview():
    """直接从实际模型方块绘制等距预览，不使用头像替代几何。"""
    size=210;sheet=Image.new('RGB',(size*6,250*6),'#e8e2d3');draw=ImageDraw.Draw(sheet)
    font=ImageFont.truetype('C:/Windows/Fonts/msyhbd.ttc',18)
    def project(point):
        x,y,z=point;x-=8;z-=8;y-=8
        return ((x+z)*.79,(x-z)*.34-y*.9)
    for index,entry in enumerate(CHARS):
        origin=(index%6*size+size/2,index//6*250+184)
        parts=sculpt(entry['slug']).mesh();faces=[]
        for part in parts:
            if not part['faces']:continue
            x0,y0,z0=part['from'];x1,y1,z1=part['to']
            uv=next(iter(part['faces'].values()))['uv']
            color_index=round(uv[1]/2)*8+round(uv[0]/2)
            rgb=tuple(int(list(COLORS.values())[color_index][i:i+2],16) for i in (1,3,5))
            for side,points,shade in (('up',[(x0,y1,z0),(x1,y1,z0),(x1,y1,z1),(x0,y1,z1)],1.04),
                                 ('east',[(x1,y0,z0),(x1,y0,z1),(x1,y1,z1),(x1,y1,z0)],.72),
                                 ('north',[(x0,y0,z0),(x1,y0,z0),(x1,y1,z0),(x0,y1,z0)],.88)):
                if side not in part['faces']:continue
                depth=sum(p[0]-p[2]+p[1]*(.68/.9) for p in points)/4
                polygon=[(origin[0]+project(p)[0]*7.3,origin[1]+project(p)[1]*7.3) for p in points]
                faces.append((depth,polygon,tuple(min(255,round(v*shade)) for v in rgb)))
        for _,polygon,color in sorted(faces,key=lambda item:item[0]):draw.polygon(polygon,fill=color)
        draw.text((origin[0],index//6*250+225),entry['name'],font=font,anchor='mm',fill='#273647')
    sheet.save(SOURCE/'figures-preview.png')


if __name__=='__main__':build()
