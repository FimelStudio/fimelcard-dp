"""CPU preview of the actual Catan model cuboids, alpha masks and UVs."""
import json
import math
import numpy as np
from PIL import Image, ImageDraw, ImageFont
from boardgame_assets import RP, CARD, cube
from catan_topology import HEXES, VERTICES, PORTS, FIXED_TERRAIN, FIXED_NUMBERS


def render_preview(layout,output=None,label=None):
    image=Image.new('RGBA',(1560,1260),'#ece5d8');draw=ImageDraw.Draw(image)
    capacity=4 if layout['geom']['radius']<.3 else 8
    font=lambda size:ImageFont.truetype('C:/Windows/Fonts/arial.ttf',size)
    draw.text((90,56),'CATAN',font=font(34),fill='#493b2d')
    draw.text((90,104),'Native models + CC0 terrain textures | '+(label or f'{capacity}-seat table'),font=font(18),fill='#7a6a56')
    draw.text((90,1198),'Asset preview only. Demonstration pieces are not an opening position.',font=font(17),fill='#7a6a56')
    faces=[];cache={};camera=(3,5,4)
    unit=lambda v:tuple(x/math.sqrt(sum(n*n for n in v)) for x in v)
    dot=lambda a,b:sum(x*y for x,y in zip(a,b))
    view=unit(camera);right=unit((camera[2],0,-camera[0]))
    up=(view[1]*right[2],view[2]*right[0]-view[0]*right[2],-view[1]*right[0])
    zoom=339 if capacity==4 else 254
    project=lambda v:(780+dot(v,right)*zoom,700-dot(v,up)*zoom)
    def rotate(v,q):
        # q v q^-1, expanded without any third-party scene or rendering dependencies.
        xyz=q[:3];w=q[3]
        cross=lambda a,b:(a[1]*b[2]-a[2]*b[1],a[2]*b[0]-a[0]*b[2],a[0]*b[1]-a[1]*b[0])
        first=cross(xyz,v);second=cross(xyz,first)
        return tuple(v[i]+2*(w*first[i]+second[i]) for i in range(3))
    def append(name,point,override=None):
        native=override or json.loads((CARD/'models/item/catan'/(name+'.json')).read_text(encoding='utf-8'))
        q=tuple(point[k] for k in ('qx','qy','qz','qw'))
        scale=point['scale'];translation=(point['x'],point['y'],point['z'])
        for element in native.get('elements',[]):
            x,y,z=element['from'];X,Y,Z=element['to']
            corners={'up':[(x,Y,z),(X,Y,z),(X,Y,Z),(x,Y,Z)],
                     'down':[(x,y,Z),(X,y,Z),(X,y,z),(x,y,z)],
                     'north':[(X,Y,z),(x,Y,z),(x,y,z),(X,y,z)],
                     'south':[(x,Y,Z),(X,Y,Z),(X,y,Z),(x,y,Z)],
                     'west':[(x,Y,z),(x,Y,Z),(x,y,Z),(x,y,z)],
                     'east':[(X,Y,Z),(X,Y,z),(X,y,z),(X,y,Z)]}
            normals={'up':(0,1,0),'down':(0,-1,0),'north':(0,0,-1),'south':(0,0,1),'west':(-1,0,0),'east':(1,0,0)}
            rotation=element.get('rotation');eq=(0,0,0,1)
            if rotation:
                angle=math.radians(rotation['angle'])/2
                eq=tuple(math.sin(angle) if a==rotation['axis'] else 0 for a in 'xyz')+(math.cos(angle),)
            def world(v):
                if rotation:
                    origin=rotation['origin'];v=tuple(a-b for a,b in zip(v,origin));v=rotate(v,eq);v=tuple(a+b for a,b in zip(v,origin))
                v=rotate(tuple((n-8)*scale/16 for n in v),q)
                return tuple(a+b for a,b in zip(v,translation))
            for side,face in element.get('faces',{}).items():
                normal=rotate(rotate(normals[side],eq),q)
                if dot(normal,view)<=1e-7:continue
                points=[world(v) for v in corners[side]]
                texture=native['textures'][face['texture'].lstrip('#')]
                while texture.startswith('#'):texture=native['textures'][texture[1:]]
                if texture not in cache:
                    namespace,resource=texture.split(':');cache[texture]=Image.open(RP/f'assets/{namespace}/textures/{resource}.png').convert('RGBA')
                faces.append(([dot(v,view) for v in points],[project(v) for v in points],texture,face.get('uv',[0,0,16,16]),normal))
    table={'textures':{'all':'card:item/catan/wood_edge'},'elements':[cube([0,-.6,0],[16,0,16])]}
    table_scale=3 if capacity==4 else 4
    append('',{'x':0,'y':table_scale/2-.12,'z':0,'scale':table_scale,'qx':0,'qy':0,'qz':0,'qw':1},table)
    append('board/sea',layout['sea'])
    for h in HEXES:
        p=layout['hexes'][h['id']]
        append('tile/'+('forest','hills','pasture','fields','mountains','desert')[FIXED_TERRAIN[h['id']]],p)
        value=FIXED_NUMBERS[h['id']]
        scale=layout['geom']['token_scale']
        if value:append('number/'+str(value),{**p,'scale':scale,'y':scale/2+.026})
    for port,p in zip(PORTS,layout['ports']):
        append('port/dock',p['dock'])
        key={-1:'generic',0:'wood',1:'brick',2:'wool',3:'grain',4:'ore'}[port['resource']]
        append('port/'+key,p['token'])
    for vertex,color,kind in ((8,'red','settlement'),(19,'blue','city'),(32,'white','settlement'),(45,'orange','settlement')):
        append(kind+'/'+color,layout['vertices'][vertex])
        for edge in VERTICES[vertex]['edges'][:2]:append('road/'+color,layout['edges'][edge])
    scale=layout['geom']['robber_scale']
    p=layout['hexes'][0];append('robber',{**p,'scale':scale,'y':scale/2+.024})
    append('dice/ivory',layout['die1']['r3'][0]);append('dice/red',layout['die2']['r5'][0])
    # A depth buffer is essential: the sea and table are much larger than each
    # terrain face, so painter-sorting face centres hides half the board.
    canvas=np.array(image)
    depth_buffer=np.full((image.height,image.width),-np.inf)
    for depths,quad,texture,uv,normal in faces:
        x0=max(0,math.floor(min(p[0] for p in quad)));y0=max(0,math.floor(min(p[1] for p in quad)))
        x1=min(image.width,math.ceil(max(p[0] for p in quad)));y1=min(image.height,math.ceil(max(p[1] for p in quad)))
        if x1<=x0 or y1<=y0:continue
        p,a,b=quad[0],(quad[1][0]-quad[0][0],quad[1][1]-quad[0][1]),(quad[3][0]-quad[0][0],quad[3][1]-quad[0][1])
        det=a[0]*b[1]-a[1]*b[0]
        if abs(det)<1e-10:continue
        bitmap=cache[texture];sx,sy=bitmap.width/16,bitmap.height/16
        py,px=np.mgrid[y0:y1,x0:x1];px=px+.5-p[0];py=py+.5-p[1]
        s=(b[1]*px-b[0]*py)/det;t=(-a[1]*px+a[0]*py)/det
        inside=(s>=0)&(s<=1)&(t>=0)&(t<=1)
        tx=np.clip(((uv[0]+(uv[2]-uv[0])*s)*sx).astype(int),0,bitmap.width-1)
        ty=np.clip(((uv[1]+(uv[3]-uv[1])*t)*sy).astype(int),0,bitmap.height-1)
        pixels=np.array(bitmap)[ty,tx]
        depth=depths[0]+s*(depths[1]-depths[0])+t*(depths[3]-depths[0])
        visible=inside&(pixels[:,:,3]>0)&(depth>depth_buffer[y0:y1,x0:x1]+1e-9)
        shade=.78+.22*max(0,dot(normal,unit((1,3,2))))
        pixels=pixels.copy();pixels[:,:,:3]=(pixels[:,:,:3]*shade).astype('uint8')
        canvas[y0:y1,x0:x1][visible]=pixels[visible]
        depth_buffer[y0:y1,x0:x1][visible]=depth[visible]
    Image.fromarray(canvas).convert('RGB').save(output or RP/'.source/catan/board_preview.png')
