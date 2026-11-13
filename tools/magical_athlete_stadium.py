"""运动会昼／夜体育场：共享格心的赛道画面与低矮立体看台。"""
import math
from PIL import Image, ImageDraw, ImageFont
from boardgame_assets import cube

PALETTES={
    'mild':dict(bg='#122c43',rim='#ecd2a1',track='#b54737',track2='#ed7953',
                grass=('#235d55','#29695d'),panel='#fff0cf',ink='#172b42',accent='#ffcb55',
                blue='#6de2db',shadow='#10273b',seat=('#e6b35a','#d9634e','#76b3ac')),
    'wild':dict(bg='#201a3f',rim='#dcc0f0',track='#593688',track2='#b459ab',
                grass=('#253452','#2b3c5b'),panel='#f0e8ff',ink='#271f45',accent='#f7c95e',
                blue='#7ef2e6',shadow='#131c35',seat=('#bf77cc','#76c9d2','#e8b55c')),
}


def font(size,chinese=False):
    return ImageFont.truetype('C:/Windows/Fonts/'+('msyhbd.ttc' if chinese else 'arialbd.ttf'),size)


def star(draw,xy,r,fill):
    x,y=xy
    points=[]
    for i in range(10):
        a=-math.pi/2+i*math.pi/5;rr=r if i%2==0 else r*.44
        points.append((x+math.cos(a)*rr,y+math.sin(a)*rr))
    draw.polygon(points,fill=fill)


def artwork(kind,track):
    p=PALETTES[kind];size=1536;s=size/16
    image=Image.new('RGB',(size,size),p['bg']);d=ImageDraw.Draw(image)
    # Broad framing and angular corners read as an arena even at table scale.
    d.rounded_rectangle((5,5,size-6,size-6),radius=66,fill=p['shadow'],outline=p['rim'],width=12)
    d.rounded_rectangle((29,29,size-30,size-30),radius=46,outline=p['accent'],width=4)
    d.rounded_rectangle((77,77,size-78,size-78),radius=36,fill=p['track'],outline=p['rim'],width=4)
    d.rounded_rectangle((101,101,size-102,size-102),radius=29,outline=p['track2'],width=20)
    for inset in (.04,.14,.25):
        pad=(.96+inset)*s
        d.rounded_rectangle((pad,pad,size-pad,size-pad),radius=24,outline=p['rim'],width=2)
    # Individual stands are drawn below the raised seating geometry, with aisles.
    for edge in range(4):
        for col in range(28):
            c=p['seat'][(col//3+edge)%3]
            for row in range(3):
                x=120+col*46;y=40+row*12
                box=(x,y,x+30,y+8)
                if edge==0:d.rectangle(box,fill=c)
                elif edge==1:d.rectangle((y,x,y+8,x+30),fill=c)
                elif edge==2:d.rectangle((x,size-y-8,x+30,size-y),fill=c)
                else:d.rectangle((size-y-8,x,size-y,x+30),fill=c)
    # Centre field: bright diagonal energy, clearly subordinate to the tiles.
    d.rounded_rectangle((3*s,3*s,13*s,13*s),radius=58,fill=p['grass'][0],outline=p['rim'],width=5)
    mask=Image.new('L',image.size);md=ImageDraw.Draw(mask)
    md.rounded_rectangle((3.08*s,3.08*s,12.92*s,12.92*s),radius=50,fill=255)
    stripes=Image.new('RGB',image.size,p['grass'][0]);sd=ImageDraw.Draw(stripes)
    for i in range(-6,14):
        x=i*144
        sd.polygon([(x,280),(x+70,280),(x+1020,1260),(x+950,1260)],fill=p['grass'][1])
    image.paste(stripes,(0,0),mask);d=ImageDraw.Draw(image)
    d.rounded_rectangle((3.32*s,3.32*s,12.68*s,12.68*s),radius=46,outline='#71a28e' if kind=='mild' else '#617699',width=3)
    d.line((3.35*s,8*s,12.65*s,8*s),fill='#68988a' if kind=='mild' else '#556b8b',width=3)
    for r in (1.1,1.45):
        d.ellipse(((8-r)*s,(8-r)*s,(8+r)*s,(8+r)*s),outline='#71a28e' if kind=='mild' else '#617699',width=3)
    # Direction chevrons point along the open 0 -> 30 path; never imply 30 -> 0.
    points=[(x*s,z*s) for x,z in track['layout']['positions']]
    for i,(a,b) in enumerate(zip(points,points[1:])):
        mx,my=(a[0]+b[0])/2,(a[1]+b[1])/2
        dx,dy=b[0]-a[0],b[1]-a[1];length=math.hypot(dx,dy)
        dx,dy=dx/length,dy/length;nx,ny=-dy,dx
        d.polygon([(mx+dx*12,my+dy*12),(mx-dx*6+nx*9,my-dy*6+ny*9),(mx-dx*6-nx*9,my-dy*6-ny*9)],fill=p['accent'])
    wild=track['wild'] if kind=='wild' else {}
    for number,(x,z) in enumerate(track['layout']['positions']):
        cx,cy=x*s,z*s;r=.64*s;effect=wild.get(str(number),{})
        fill=p['panel'];accent=p['ink']
        if 'points' in effect:fill='#ffe094';accent='#7b4c1c'
        if 'trip' in effect:fill='#f5b09c';accent='#922f38'
        if 'move' in effect:
            fill='#a4e6dc' if effect['move']>0 else '#d0b4ec'
            accent='#135f62' if effect['move']>0 else '#663991'
        if number==0:fill='#90d1ba'
        if number==30:fill='#ffe4a1'
        # Offset shadow plus a bright leading edge makes the flat squares tactile.
        d.rounded_rectangle((cx-r+5,cy-r+9,cx+r+5,cy+r+9),radius=17,fill=p['shadow'])
        d.rounded_rectangle((cx-r,cy-r,cx+r,cy+r),radius=17,fill=fill,outline=p['ink'],width=4)
        d.line((cx-r+17,cy-r+9,cx+r-17,cy-r+9),fill='#ffffff',width=4)
        d.rounded_rectangle((cx-r+9,cy-r+9,cx+r-9,cy+r-9),radius=10,outline=p['rim'] if not effect else accent,width=2)
        if number in (0,30):
            name='起点' if number==0 else '终点'
            d.text((cx,cy+.22*s),name,font=font(28,True),fill=p['ink'],anchor='mm')
            if number==0:
                d.polygon([(cx-24,cy-38),(cx+28,cy-10),(cx-24,cy+6)],fill=p['ink'])
            else:
                for row in range(3):
                    for col in range(6):
                        if (row+col)%2==0:
                            xx=cx-36+col*12;yy=cy-42+row*12
                            d.rectangle((xx,yy,xx+11,yy+11),fill=p['ink'])
        else:
            d.text((cx,cy-25 if effect else cy),str(number),font=font(38),fill=p['ink'],anchor='mm')
            if 'points' in effect:star(d,(cx,cy+23),25,p['accent']);d.text((cx,cy+24),'+1',font=font(19),fill=accent,anchor='mm')
            elif 'trip' in effect:
                # A fall pictogram is distinct from the backwards arrow.
                d.ellipse((cx+4,cy+4,cx+17,cy+17),fill=accent)
                d.line((cx+8,cy+18,cx-8,cy+28,cx-25,cy+21),fill=accent,width=6)
                d.line((cx-8,cy+28,cx+10,cy+42,cx+26,cy+38),fill=accent,width=6)
                d.line((cx-8,cy+28,cx-22,cy+44),fill=accent,width=6)
            elif 'move' in effect:
                value=effect['move'];sign=1 if value>0 else -1
                d.text((cx-9,cy+24),f'{value:+d}',font=font(30),fill=accent,anchor='mm')
                xx=cx+35
                d.polygon([(xx+sign*9,cy+24),(xx-sign*5,cy+15),(xx-sign*5,cy+33)],fill=accent)
    # Angular title panel and speed streaks leave the middle clear for dice/skills.
    d.polygon([(3.8*s,4.15*s),(11.9*s,4.15*s),(12.25*s,5.28*s),(11.7*s,6.15*s),(3.7*s,6.15*s),(4.05*s,5.1*s)],fill=p['shadow'])
    d.polygon([(4.13*s,4.32*s),(11.55*s,4.32*s),(11.85*s,5.25*s),(11.4*s,5.96*s),(4.03*s,5.96*s),(4.33*s,5.1*s)],outline=p['accent'],width=4)
    d.text((8*s,5.02*s),'胡闹运动会',font=font(74,True),fill='#fff1d7',anchor='mm',stroke_width=1)
    d.text((8*s,5.65*s),'MAGICAL  ATHLETE',font=font(27),fill=p['blue'],anchor='mm')
    d.text((8*s,10.68*s),'普通赛道  /  DAY STADIUM' if kind=='mild' else '狂野赛道  /  NIGHT STADIUM',font=font(29,True),fill=p['panel'],anchor='mm')
    for i in range(5):
        x=(5.8+i*.9)*s
        d.polygon([(x,11.48*s),(x+.28*s,11.26*s),(x+.48*s,11.26*s),(x+.2*s,11.48*s)],fill=p['accent'] if i%2==0 else p['blue'])
    if kind=='wild':
        d.text((8*s,12.12*s),'★ +1    × 绊倒    → 前进    ← 后退',font=font(21,True),fill=p['panel'],anchor='mm')
    return image


def geometry(kind):
    p=PALETTES[kind]
    textures={'all':f'card:item/magical_athlete/board/{kind}'}
    textures.update({key:f'card:item/magical_athlete/stadium/{kind}_{key}' for key in ('frame','steel','seat','light','accent')})
    # The playing surface retains the original 8..8.06 datum. All extra height
    # stays inside the outer 1.05 model units, outside every legal racing cell.
    board=cube([0,8,0],[16,8.06,16],name='board')
    board['faces']={k:v for k,v in board['faces'].items() if k in ('up','down')}
    elements=[board,cube([0,7.63,0],[16,7.99,16],'frame','arena_base')]
    for side in range(4):
        def part(x0,z0,x1,z1,y0,y1,tex,name):
            def turn(x,z):
                for _ in range(side):x,z=16-z,x
                return x,z
            pts=[turn(x,z) for x,z in ((x0,z0),(x1,z1))]
            elements.append(cube([min(v[0] for v in pts),y0,min(v[1] for v in pts)],
                                 [max(v[0] for v in pts),y1,max(v[1] for v in pts)],tex,name+f'_{side}'))
        for row in range(3):
            lo=.17+row*.24;hi=lo+.22;top=8.52-row*.15
            part(1.23,lo,14.77,hi,8.06,top,'steel',f'grandstand_{row}')
            for bay in range(14):
                x=1.38+bay*.95
                part(x,lo+.03,x+.65,hi-.03,top+.005,top+.055,'seat',f'seat_{row}_{bay}')
        part(1.16,.91,14.84,1.025,8.06,8.14,'accent','track_rail')
    for i,(x,z) in enumerate(((.7,.7),(15.3,.7),(15.3,15.3),(.7,15.3))):
        elements.append(cube([x-.22,8.06,z-.22],[x+.22,8.22,z+.22],'frame',f'light_base_{i}'))
        elements.append(cube([x-.065,8.22,z-.065],[x+.065,9.55,z+.065],'steel',f'light_mast_{i}'))
        elements.append(cube([x-.34,9.55,z-.15],[x+.34,9.88,z+.15],'steel',f'light_housing_{i}'))
        # Front and rear diffuse faces: useful from every seated direction.
        for sign in (-1,1):
            zz=z+sign*.151
            face=cube([x-.27,9.61,zz],[x+.27,9.82,zz],'light',f'light_face_{i}_{sign}')
            face['faces']={('north' if sign<0 else 'south'):{'texture':'#light','uv':[0,0,16,16]}}
            elements.append(face)
    return {'textures':textures,'elements':elements},dict(frame=p['shadow'],steel=p['rim'],seat=p['seat'][1],light='#fff6cb' if kind=='mild' else '#adfff3',accent=p['accent'])
