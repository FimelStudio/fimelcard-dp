"""卡坦岛21号共享拓扑；只定义数据，导入不会生成或改写资源。

轴向地块按(r,q)排序，交点按(v,u)排序，边按端点ID排序。
交点世界坐标 x=sqrt(3)*R*u/2, z=R*v/2；资源0木1砖2羊3麦4矿5沙漠。
"""
from collections import Counter
from math import sqrt

HEX_AXIAL = [(q,r) for r in range(-2,3) for q in range(-2,3)
             if max(abs(q),abs(r),abs(q+r))<=2]
CORNERS = [(1,1),(0,2),(-1,1),(-1,-1),(0,-2),(1,-1)]
_hex_keys = [[(2*q+r+du,3*r+dv) for du,dv in CORNERS] for q,r in HEX_AXIAL]
VERTEX_KEYS = sorted({p for polygon in _hex_keys for p in polygon},key=lambda p:(p[1],p[0]))
_vertex_id = {p:i for i,p in enumerate(VERTEX_KEYS)}
HEX_VERTICES = [[_vertex_id[p] for p in polygon] for polygon in _hex_keys]
_edge_counts = Counter(tuple(sorted((polygon[k],polygon[(k+1)%6])))
                       for polygon in HEX_VERTICES for k in range(6))
EDGES = sorted(_edge_counts)
_edge_id = {edge:i for i,edge in enumerate(EDGES)}
HEX_EDGES = [[_edge_id[tuple(sorted((polygon[k],polygon[(k+1)%6])))] for k in range(6)]
             for polygon in HEX_VERTICES]
VERTEX_EDGES = [[i for i,(a,b) in enumerate(EDGES) if v in (a,b)] for v in range(54)]
VERTEX_NEIGHBORS = [[b if a==v else a for a,b in (EDGES[e] for e in VERTEX_EDGES[v])]
                    for v in range(54)]
VERTEX_HEXES = [[h for h,vertices in enumerate(HEX_VERTICES) if v in vertices] for v in range(54)]
COAST_EDGES = sorted(_edge_id[edge] for edge,n in _edge_counts.items() if n==1)
_coast_neighbors = {v:[] for v in range(54)}
for e in COAST_EDGES:
    a,b=EDGES[e];_coast_neighbors[a].append(b);_coast_neighbors[b].append(a)
_start=min((v for v,n in _coast_neighbors.items() if n),key=lambda v:(VERTEX_KEYS[v][1],VERTEX_KEYS[v][0]))
COAST_VERTICES=[_start]
_previous=None
_current=_start
while True:
    choices=[v for v in _coast_neighbors[_current] if v!=_previous]
    _next=min(choices,key=lambda v:VERTEX_KEYS[v][0]) if _previous is None else choices[0]
    if _next==_start:break
    COAST_VERTICES.append(_next);_previous,_current=_current,_next
COAST_CYCLE=[_edge_id[tuple(sorted((COAST_VERTICES[i],COAST_VERTICES[(i+1)%30])))] for i in range(30)]
PORT_COAST_INDICES=[0,3,6,10,13,16,20,23,26]
PORT_RESOURCES=[-1,4,3,-1,1,0,-1,2,-1]
PORTS=[{'id':i,'edge':COAST_CYCLE[k],'vertices':list(EDGES[COAST_CYCLE[k]]),'resource':PORT_RESOURCES[i]}
       for i,k in enumerate(PORT_COAST_INDICES)]

# 官方2025推荐地形/数字，从北向南的3/4/5/4/3排。
FIXED_TERRAIN=[5,3,2, 1,2,0,4, 0,3,1,0,2, 3,1,4,0, 4,3,2]
FIXED_NUMBERS=[0,8,11, 6,3,4,9, 10,5,12,11,5, 2,9,4,8, 6,3,10]
NUMBER_SEQUENCE=[5,2,6,3,8,10,9,12,11,4,8,10,9,4,5,6,3,11]
# 外圈从西北角开始逆时针，接内圈，最后中心；沙漠跳过数字。
SPIRAL_HEXES=[0,3,7,12,16,17,18,15,11,6,2,1,4,8,13,14,10,5,9]

HEXES=[{'id':i,'q':q,'r':r,'vertices':HEX_VERTICES[i],'edges':HEX_EDGES[i]}
       for i,(q,r) in enumerate(HEX_AXIAL)]
VERTICES=[{'id':i,'u':u,'v':v,'edges':VERTEX_EDGES[i],'neighbors':VERTEX_NEIGHBORS[i],'hexes':VERTEX_HEXES[i]}
          for i,(u,v) in enumerate(VERTEX_KEYS)]
TOPOLOGY={'hexes':HEXES,'vertices':VERTICES,
          'edges':[{'id':i,'a':a,'b':b} for i,(a,b) in enumerate(EDGES)],
          'coast_vertices':COAST_VERTICES,'coast_edges':COAST_CYCLE,'ports':PORTS}

def vertex_position(vertex,radius,orientation=0):
    u,v=VERTEX_KEYS[vertex];x,z=sqrt(3)*radius*u/2,radius*v/2
    return (-z,x) if orientation else (x,z)

def hex_position(hex_id,radius,orientation=0):
    q,r=HEX_AXIAL[hex_id];x,z=sqrt(3)*radius*(q+r/2),1.5*radius*r
    return (-z,x) if orientation else (x,z)

assert len(HEXES)==19 and len(VERTICES)==54 and len(EDGES)==72 and len(COAST_CYCLE)==30
assert len(PORTS)==9 and len({v for p in PORTS for v in p['vertices']})==18
assert Counter(FIXED_TERRAIN)==Counter({0:4,1:3,2:4,3:4,4:3,5:1})
