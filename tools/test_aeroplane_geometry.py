"""独立验证传统飞行棋几何；只读取生成物，不导入生产坐标函数。

标准锚点来自已确认的17单位棋盘合同。其余位置期望读取manifest后独立映射，
使纹理、原版实体、命中区测试共同对照声明数据，而非复用待测的point实现。
"""
from itertools import combinations, product
from pathlib import Path
import json
import math

PACK=Path(__file__).resolve().parents[1]
BASE_RING=((6.5,16),(16/3,47/3),(5,14.5),(5,13.5),(16/3,37/3),
           (14/3,35/3),(3.5,12),(2.5,12),(4/3,35/3),(1,10.5),
           (1,9.5),(1,8.5),(1,7.5))
BASE_HANGAR=((1.05,14.05),(2.95,14.05),(1.05,15.95),(2.95,15.95))
BASE_LAUNCH=(6.5,17.25)
TOL=1e-7


def manifest():
    return json.loads((PACK/'tools/aeroplane_path.json').read_text(encoding='utf-8'))


def standard(point, quarter=0):
    x,z=point
    for _ in range(quarter):x,z=17-z,x
    return (x*.8+.2,z*.8+.2)


def near(a,b,tolerance=TOL):
    return len(a)==len(b) and all(abs(x-y)<=tolerance for x,y in zip(a,b))


def signed_area(poly):
    return sum(a[0]*b[1]-b[0]*a[1] for a,b in zip(poly,poly[1:]+poly[:1]))/2


def contains(poly,point,tolerance=TOL):
    """包含边界的凸多边形测试，环格、内道与机场均为凸形。"""
    crosses=[(b[0]-a[0])*(point[1]-a[1])-(b[1]-a[1])*(point[0]-a[0])
             for a,b in zip(poly,poly[1:]+poly[:1])]
    return min(crosses)>=-tolerance or max(crosses)<=tolerance


def interior_overlap(a,b,tolerance=TOL):
    """分离轴法：共享边允许，面积重叠不允许。"""
    for poly in (a,b):
        for p,q in zip(poly,poly[1:]+poly[:1]):
            dx,dz=q[0]-p[0],q[1]-p[1];length=math.hypot(dx,dz)
            if length<tolerance:continue
            axis=(-dz/length,dx/length)
            aa=[x*axis[0]+z*axis[1] for x,z in a]
            bb=[x*axis[0]+z*axis[1] for x,z in b]
            if min(max(aa),max(bb))-max(min(aa),min(bb))<=tolerance:return False
    return True


def shared_edge(a,b):
    for p,q in zip(a,a[1:]+a[:1]):
        for r,s in zip(b,b[1:]+b[:1]):
            if near(p,r) and near(q,s) or near(p,s) and near(q,r):
                return math.dist(p,q)>TOL
    return False


def expected_point(data,color,number,position,footprint,orientation):
    info=data['colors'][color]
    if position<0:node=info['hangar'][number]
    elif position==0:node=info['launch']
    elif position<=51:node=data['ring'][(info['start']+position-1)%52]
    else:node=info['home'][position-52]
    dx=dz=0
    if position>=0:
        dx=(-.13,.13,-.13,.13)[number]
        dz=(-.13,-.13,.13,.13)[number]
    cx,cz=data['center'];step=footprint/data['grid']
    x,z=(node[0]+dx-cx)*step,(node[1]+dz-cz)*step
    if orientation:x,z=-z,x
    angle=-(color+orientation)*math.pi/2
    return {'x':x,'z':z,'qy':math.sin(angle/2),'qw':math.cos(angle/2)}


def audit_manifest(data,check):
    check(data['grid']==15 and near(data['center'],[7,7]),'traditional grid center')
    check(abs(data['unit_step']-.8)<TOL,'17-unit template scale')
    check(len(data['ring'])==len(data['ring_cells'])==52,'52 ring centers and polygons')
    check(len(set(map(tuple,data['ring'])))==52,'52 unique ring centers')
    unit=data['unit_step']
    for i,(node,cell) in enumerate(zip(data['ring'],data['ring_cells'])):
        check(near(node,standard(BASE_RING[i%13],i//13)),f'ring {i} independent standard anchor')
        check(contains(cell,node),f'ring {i} center inside own polygon')
        check(abs(abs(signed_area(cell))-2*unit*unit)<TOL,f'ring {i} equal tile area')
        check(shared_edge(cell,data['ring_cells'][(i+1)%52]),f'ring {i} connected next edge')
        check(near(data['ring'][(i+13)%52],[14-node[1],node[0]]),f'ring {i} quarter turn')
    check(signed_area(data['ring'])>0,'clockwise outer route in texture coordinates')
    for a,b in combinations(range(52),2):
        check(not interior_overlap(data['ring_cells'][a],data['ring_cells'][b]),f'ring cells {a}/{b} do not overlap')
    for c,info in enumerate(data['colors']):
        check(info['id']==c and info['name']==('red','blue','green','yellow')[c] and info['start']==c*13,f'color {c} logical order')
        check(near(info['launch'],standard(BASE_LAUNCH,c)),f'color {c} external launch anchor')
        for p,node in enumerate(info['hangar']):
            check(near(node,standard(BASE_HANGAR[p],c)),f'color {c} hangar {p} standard anchor')
            check(contains(info['airport'],node),f'color {c} hangar {p} inside airport')
        check(len(info['home'])==6,f'color {c} six home steps')
        for i,node in enumerate(info['home']):
            check(near(node,standard((8.5,14.5-i),c)),f'color {c} home {i} standard anchor')
            shape=info['home_cells'][i] if i<5 else info['terminal']
            check(contains(shape,node),f'color {c} home {i} inside tile')
        final_outer=data['ring'][(info['start']+50)%52]
        check(abs(math.dist(final_outer,info['home'][0])-1.5*unit)<TOL,f'color {c} enters home across outer half-cell')
        for a,b in zip(info['home'],info['home'][1:]):
            check(abs(math.dist(a,b)-unit)<TOL,f'color {c} continuous home')
        for p in data['jump_positions']:
            check((info['start']+p-1+2)%4==c,f'color {c} jump {p} uses own painted cell')
        start=data['ring'][(info['start']+18)%52];end=data['ring'][(info['start']+30)%52]
        check(abs(start[0]-end[0])<TOL or abs(start[1]-end[1])<TOL,f'color {c} straight flight lane')
        check((info['start']+18+2)%4==(info['start']+30+2)%4==c,f'color {c} flight endpoints match own color')


def model_bounds(model,pose,scale,y):
    """Java item模型中心为8，right_rotation已抵消item_display的隐含Y半圈。"""
    vertices=[];qy,qw=pose.get('qy',0),pose.get('qw',1)
    cosine,sine=1-2*qy*qy,2*qy*qw
    for element in model['elements']:
        assert 'rotation' not in element,'add native element rotation support before changing piece geometry'
        for point in product(*[(a,b) for a,b in zip(element['from'],element['to'])]):
            x,h,z=[(v-8)/16*scale for v in point]
            vertices.append((pose.get('x',0)+cosine*x+sine*z,y+h,
                             pose.get('z',0)-sine*x+cosine*z))
    return tuple(min(v[axis] for v in vertices) for axis in range(3)),tuple(max(v[axis] for v in vertices) for axis in range(3))


def audit_terminal_clearance(data,card,check):
    die=json.loads((card/'models/item/aeroplane_chess/dice.json').read_text(encoding='utf-8'))
    closest=float('inf')
    for cap,foot in ((4,2.7),(8,3.6)):
        step=foot/data['grid'];die_scale=step*.8
        low,high=model_bounds(die,{},die_scale,die_scale*7/16+.012)
        for orient,color,number in product(range(2),range(4),range(4)):
            piece=json.loads((card/f'models/item/aeroplane_chess/plane/classic_{data["colors"][color]["name"]}.json').read_text(encoding='utf-8'))
            pose=expected_point(data,color,number,57,foot,orient)
            a,b=model_bounds(piece,pose,step*.72,step*.72*.5+.012)
            clearance=max(low[i]-b[i] for i in range(3))
            clearance=max(clearance,max(a[i]-high[i] for i in range(3)))
            closest=min(closest,clearance)
            check(clearance>TOL,f'cap {cap} orient {orient} color {color} terminal plane {number} clear of actual dice AABB')
    return closest


if __name__=='__main__':
    from boardgame_assets import CARD
    checks=[]
    def check(value,label):
        assert value,label
        checks.append(label)
    data=manifest();audit_manifest(data,check)
    clearance=audit_terminal_clearance(data,CARD,check)
    print(f'PASS: {len(checks)} independent geometry assertions; minimum terminal/die clearance {clearance:.6f} blocks.')
