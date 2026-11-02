"""卡坦岛单点击面：仅操作时求视线，精确区分六角地块、顶点和边。"""
import math
from catan_topology import HEXES, VERTICES, EDGES, hex_position, vertex_position
from build_catan_game import put, PACK

OBJECTIVES = {n:'dummy' for n in ['ca_mode','ca_pick','ca_x','ca_z']}


def main():
    put('input/context','''
tag @a[tag=ca.actor] remove ca.actor
tag @e[tag=ca.current] remove ca.current
execute unless entity @s[tag=ct.player,tag=ca.player] run return 0
execute unless score @s ca_table = @s ct_id run return 0
scoreboard players operation #input_table ca_ctx = @s ca_table
execute as @e[type=minecraft:marker,tag=ct.controller,tag=ca.controller,scores={ct_game=21,ct_state=1}] if score @s ct_id = #input_table ca_ctx run tag @s add ca.current
execute unless entity @e[tag=ca.current,limit=1] run return 0
tag @s add ca.actor
execute as @e[tag=ca.current,limit=1] at @s run function catan:system/context
''')
    put('input/clear_surface','''
scoreboard players operation #input_table ca_ctx = @s ct_id
execute as @e[type=minecraft:interaction,tag=ca.surface] if score @s ct_id = #input_table ca_ctx run kill @s
''')
    put('input/clear_pending','execute as @e[type=minecraft:interaction,tag=ca.surface] if score @s ct_id = #table ca_ctx run data remove entity @s interaction')
    put('input/create_surface','''
function catan:input/clear_surface
execute if score @s ct_capacity matches 4 positioned ~ ~1.025 ~ summon minecraft:interaction run function catan:input/surface {width:2.70f}
execute if score @s ct_capacity matches 8 positioned ~ ~1.025 ~ summon minecraft:interaction run function catan:input/surface {width:3.60f}
''')
    put('input/surface','''
tag @s add ca.surface
scoreboard players operation @s ct_id = #input_table ca_ctx
$data merge entity @s {width:$(width),height:0.035f,response:1b}
''')
    put('input/cell','''
scoreboard players operation #click_table ca_ctx = @s ct_id
execute on target if entity @s[type=minecraft:player] if score @s ca_table = #click_table ca_ctx run function catan:input/aim
data remove entity @s interaction
''')
    put('input/aim','''
function catan:input/context
execute unless entity @s[tag=ca.actor] run return 0
execute unless score @s ca_side = @e[tag=ca.current,limit=1] ca_turn run return 0
execute unless entity @e[tag=ca.current,scores={ca_anim=0},limit=1] run return 0
execute if entity @e[tag=ca.current,scores={ca_vtimer=1..},limit=1] run return 0
scoreboard players set #aim ca_ctx 0
execute if entity @e[tag=ca.current,scores={ca_state=1..2},limit=1] run scoreboard players set #aim ca_ctx 1
execute if entity @e[tag=ca.current,scores={ca_state=4},limit=1] run scoreboard players set #aim ca_ctx 1
execute if entity @e[tag=ca.current,scores={ca_state=6},limit=1] run scoreboard players set #aim ca_ctx 1
execute if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run scoreboard players set #aim ca_ctx 1
execute unless score #aim ca_ctx matches 1 run return run function catan:ui/open
execute if entity @e[tag=ca.current,scores={ca_state=1},limit=1] run scoreboard players set @s ca_mode 2
execute if entity @e[tag=ca.current,scores={ca_state=2},limit=1] run scoreboard players set @s ca_mode 3
execute if entity @e[tag=ca.current,scores={ca_state=6},limit=1] run scoreboard players set @s ca_mode 1
execute if entity @e[tag=ca.current,scores={ca_state=8},limit=1] run scoreboard players set @s ca_mode 3
execute unless score @s ca_mode matches 1..4 run return run function catan:ui/open
function catan:input/ray
execute unless score #ray_ok ca_ctx matches 1 run return 0
scoreboard players operation @s ca_pick = #target ca_ctx
execute as @e[tag=ca.current,limit=1] at @s run function catan:input/preview
function catan:ui/confirm
''')
    put('input/preview','''
data modify entity @s data.catan.preview set value {type:1,target:0,building:1}
execute store result entity @s data.catan.preview.target int 1 run scoreboard players get @a[tag=ca.actor,limit=1] ca_pick
execute if score @a[tag=ca.actor,limit=1] ca_mode matches 2 run data modify entity @s data.catan.preview.type set value 2
execute if score @a[tag=ca.actor,limit=1] ca_mode matches 3 run data modify entity @s data.catan.preview.type set value 3
execute if score @a[tag=ca.actor,limit=1] ca_mode matches 4 run data modify entity @s data.catan.preview.type set value 2
execute if score @a[tag=ca.actor,limit=1] ca_mode matches 4 run data modify entity @s data.catan.preview.building set value 2
function catan:visual/select
''')
    # 使用其他棋类相同的 13 次有界二分，绝对世界坐标不转int。
    source=(PACK/'data/gomoku/function/input').joinpath('ray.mcfunction').read_text(encoding='utf-8').replace('gomoku:','catan:').replace('gm.','ca.').replace('gm_ctx','ca_ctx')
    source=source.replace('execute at @e[type=minecraft:marker,tag=ca.ray,limit=1] run function catan:input/ray_target','function catan:input/ray_target')
    put('input/ray',source)
    for name in ('ray_probe','ray_position','ray_bisect','ray_clear'):
        put('input/'+name,(PACK/f'data/gomoku/function/input/{name}.mcfunction').read_text(encoding='utf-8').replace('gomoku:','catan:').replace('gm.','ca.').replace('gm_ctx','ca_ctx'))
    target=['scoreboard players set #ray_low ca_ctx 0','scoreboard players set #ray_high ca_ctx 32768','scoreboard players set #ray_count ca_ctx 14','function catan:input/x_bisect','scoreboard players operation #x ca_ctx = #ray_low ca_ctx','scoreboard players remove #x ca_ctx 16384','scoreboard players set #ray_low ca_ctx 0','scoreboard players set #ray_high ca_ctx 32768','scoreboard players set #ray_count ca_ctx 14','function catan:input/z_bisect','scoreboard players operation #z ca_ctx = #ray_low ca_ctx','scoreboard players remove #z ca_ctx 16384','execute if entity @e[tag=ca.current,scores={ca_orient=1},limit=1] run function catan:input/unrotate','scoreboard players set #target ca_ctx -1','scoreboard players set #best ca_ctx 2147483647','scoreboard players operation #mode ca_ctx = @s ca_mode','execute if entity @e[tag=ca.current,scores={ct_capacity=4},limit=1] run function catan:input/pick4','execute if entity @e[tag=ca.current,scores={ct_capacity=8},limit=1] run function catan:input/pick8','execute if score #target ca_ctx matches 0.. run scoreboard players set #ray_ok ca_ctx 1']
    put('input/ray_target',target)
    put('input/unrotate',['scoreboard players operation #swap ca_ctx = #x ca_ctx','scoreboard players operation #x ca_ctx = #z ca_ctx','scoreboard players operation #z ca_ctx = #swap ca_ctx','scoreboard players operation #z ca_ctx *= #minus ca_ctx'])
    for axis in ('x','z'):
        pos='~$(offset) ~-8 ~-4' if axis=='x' else '~-4 ~-8 ~$(offset)'
        put(f'input/{axis}_probe',f'$execute at @e[tag=ca.current,limit=1] positioned {pos} if entity @e[type=minecraft:marker,tag=ca.ray,dx=7,dy=15,dz=7,limit=1] run scoreboard players set #greater ca_ctx 1')
        put(f'input/{axis}_bisect',f'''
scoreboard players operation #ray_mid ca_ctx = #ray_low ca_ctx
scoreboard players operation #ray_mid ca_ctx += #ray_high ca_ctx
scoreboard players operation #ray_mid ca_ctx /= #two ca_ctx
scoreboard players operation #offset ca_ctx = #ray_mid ca_ctx
scoreboard players remove #offset ca_ctx 16384
execute store result storage catan:ray offset double 0.000244140625 run scoreboard players get #offset ca_ctx
scoreboard players set #greater ca_ctx 0
function catan:input/{axis}_probe with storage catan:ray
execute if score #greater ca_ctx matches 1 run scoreboard players operation #ray_low ca_ctx = #ray_mid ca_ctx
execute if score #greater ca_ctx matches 0 run scoreboard players operation #ray_high ca_ctx = #ray_mid ca_ctx
scoreboard players remove #ray_count ca_ctx 1
execute if score #ray_count ca_ctx matches 1.. run function catan:input/{axis}_bisect
''')
    for cap,r in ((4,.25),(8,.35)):
        lines=[]
        for h in HEXES:
            x,z=hex_position(h['id'],r);xu,zu=round(x*4096),round(z*4096)
            lines += [f'execute if score #mode ca_ctx matches 1 run function catan:input/hex {{id:{h["id"]},x:{xu},z:{zu},rx:{round(math.sqrt(3)/2*r*4096)},rz:{round(r*4096)},bound:{round(math.sqrt(3)*r*4096*1000)}}}']
        for v in VERTICES:
            x,z=vertex_position(v['id'],r)
            lines += [f'execute if score #mode ca_ctx matches 2 run function catan:input/vertex {{id:{v["id"]},x:{round(x*4096)},z:{round(z*4096)},limit:{round(r*.40*4096)**2}}}',f'execute if score #mode ca_ctx matches 4 run function catan:input/vertex {{id:{v["id"]},x:{round(x*4096)},z:{round(z*4096)},limit:{round(r*.40*4096)**2}}}']
        for i,(a,b) in enumerate(EDGES):
            ax,az=vertex_position(a,r);bx,bz=vertex_position(b,r)
            ux,uz=round((bx-ax)*4096),round((bz-az)*4096);l2=ux*ux+uz*uz
            lines += [f'execute if score #mode ca_ctx matches 3 run function catan:input/edge {{id:{i},x:{round(ax*4096)},z:{round(az*4096)},ux:{ux},uz:{uz},dotmin:{round(l2*.12)},dotmax:{round(l2*.88)},crossmax:{round(r*4096*r*.22*4096)}}}']
        put(f'input/pick{cap}',lines)
    # 删除首轮生成器已废弃的宏转发，保留以下自包含的几何函数。
    obsolete=PACK/'data/catan/function/input/delta.mcfunction'
    if obsolete.exists():obsolete.unlink()
    delta=['scoreboard players operation #dx ca_ctx = #x ca_ctx','scoreboard players operation #dz ca_ctx = #z ca_ctx','$scoreboard players set #coord ca_ctx $(x)','scoreboard players operation #dx ca_ctx -= #coord ca_ctx','$scoreboard players set #coord ca_ctx $(z)','scoreboard players operation #dz ca_ctx -= #coord ca_ctx']
    put('input/hex',delta+['execute if score #dx ca_ctx matches ..-1 run scoreboard players operation #dx ca_ctx *= #minus ca_ctx','execute if score #dz ca_ctx matches ..-1 run scoreboard players operation #dz ca_ctx *= #minus ca_ctx','$execute unless score #dx ca_ctx matches 0..$(rx) run return 0','$execute unless score #dz ca_ctx matches 0..$(rz) run return 0','scoreboard players set #k ca_ctx 1000','scoreboard players operation #dx ca_ctx *= #k ca_ctx','scoreboard players set #k ca_ctx 1732','scoreboard players operation #dz ca_ctx *= #k ca_ctx','scoreboard players operation #dx ca_ctx += #dz ca_ctx','$execute if score #dx ca_ctx matches ..$(bound) run scoreboard players set #target ca_ctx $(id)'])
    put('input/vertex',delta+['scoreboard players operation #dx ca_ctx *= #dx ca_ctx','scoreboard players operation #dz ca_ctx *= #dz ca_ctx','scoreboard players operation #dx ca_ctx += #dz ca_ctx','$execute unless score #dx ca_ctx matches ..$(limit) run return 0','execute unless score #dx ca_ctx < #best ca_ctx run return 0','scoreboard players operation #best ca_ctx = #dx ca_ctx','$scoreboard players set #target ca_ctx $(id)'])
    put('input/edge',delta+['$scoreboard players set #ux ca_ctx $(ux)','$scoreboard players set #uz ca_ctx $(uz)','scoreboard players operation #dot ca_ctx = #dx ca_ctx','scoreboard players operation #dot ca_ctx *= #ux ca_ctx','scoreboard players operation #temp ca_ctx = #dz ca_ctx','scoreboard players operation #temp ca_ctx *= #uz ca_ctx','scoreboard players operation #dot ca_ctx += #temp ca_ctx','$execute unless score #dot ca_ctx matches $(dotmin)..$(dotmax) run return 0','scoreboard players operation #cross ca_ctx = #dx ca_ctx','scoreboard players operation #cross ca_ctx *= #uz ca_ctx','scoreboard players operation #temp ca_ctx = #dz ca_ctx','scoreboard players operation #temp ca_ctx *= #ux ca_ctx','scoreboard players operation #cross ca_ctx -= #temp ca_ctx','execute if score #cross ca_ctx matches ..-1 run scoreboard players operation #cross ca_ctx *= #minus ca_ctx','$execute unless score #cross ca_ctx matches ..$(crossmax) run return 0','execute unless score #cross ca_ctx < #best ca_ctx run return 0','scoreboard players operation #best ca_ctx = #cross ca_ctx','$scoreboard players set #target ca_ctx $(id)'])
    put('input/give','''
execute unless entity @s[tag=ca.player,tag=ct.player] run return 0
execute store result storage catan:input table int 1 run scoreboard players get @s ca_table
execute unless items entity @s hotbar.8 minecraft:paper[minecraft:custom_data~{catan:{tool:1b,action:0}}] run function catan:input/menu_tool with storage catan:input
scoreboard players set #aim ca_ctx 0
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=1..2,ca_anim=0},limit=1] run scoreboard players set #aim ca_ctx 1
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=4,ca_anim=0},limit=1] run scoreboard players set #aim ca_ctx 1
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=6,ca_anim=0},limit=1] run scoreboard players set #aim ca_ctx 1
execute if score @s ca_side = @e[tag=ca.current,limit=1] ca_turn if entity @e[tag=ca.current,scores={ca_state=8,ca_anim=0},limit=1] run scoreboard players set #aim ca_ctx 1
execute if entity @e[tag=ca.current,scores={ca_vtimer=1..},limit=1] run scoreboard players set #aim ca_ctx 0
execute if score #aim ca_ctx matches 1 unless items entity @s hotbar.0 minecraft:paper[minecraft:custom_data~{catan:{tool:1b,action:1}}] run function catan:input/aim_tool with storage catan:input
execute if score #aim ca_ctx matches 0 if items entity @s hotbar.0 minecraft:paper[minecraft:custom_data~{catan:{tool:1b,action:1}}] run item replace entity @s hotbar.0 with minecraft:air
''')
    for action,slot,label,model in [(0,8,'卡坦岛 · 菜单','minecraft:book'),(1,0,'卡坦岛 · 瞄准建造','minecraft:spyglass')]:
        put('input/'+('menu_tool' if action==0 else 'aim_tool'),f'$item replace entity @s hotbar.{slot} with minecraft:paper[minecraft:custom_name={{text:"{label}",color:"gold",italic:false}},minecraft:item_model="{model}",minecraft:custom_data={{catan:{{tool:1b,action:{action},table:$(table)}}}},minecraft:lore=[{{text:"按 Q 使用",color:"gray",italic:false}}]]')
    put('input/drop','''
scoreboard players set @s ca_drop 0
tag @a[tag=ca.dropper] remove ca.dropper
tag @s add ca.dropper
execute as @e[type=minecraft:item,distance=..4] if items entity @s contents minecraft:paper[minecraft:custom_data~{catan:{tool:1b}}] run function catan:input/check_drop
tag @s remove ca.dropper
''')
    put('input/check_drop','''
scoreboard players set #owner ca_ctx 0
execute on origin if entity @s[tag=ca.dropper] run scoreboard players set #owner ca_ctx 1
execute unless score #owner ca_ctx matches 1 run return 0
data modify storage catan:input drop set from entity @s Item.components."minecraft:custom_data".catan
function catan:input/use_drop with storage catan:input drop
kill @s
''')
    put('input/use_drop','''
$execute unless score @a[tag=ca.dropper,limit=1] ca_table matches $(table) run return 0
$execute if predicate {condition:"minecraft:value_check",value:$(action),range:0} as @a[tag=ca.dropper,limit=1] run function catan:ui/open
$execute if predicate {condition:"minecraft:value_check",value:$(action),range:1} as @a[tag=ca.dropper,limit=1] run function catan:input/aim
execute as @a[tag=ca.dropper,limit=1] run function catan:input/give
''')
    print('Catan single-surface input generated')


if __name__=='__main__': main()
