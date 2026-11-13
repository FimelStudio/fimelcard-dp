"""只用公开动作快照生成情书操作日志，禁止读取留牌和私密技能结果。"""
import json
from build_love_letter_game import put


def append(text, color='white'):
    return 'data modify storage love_letter:chat message append value '+json.dumps({'text':text,'color':color},ensure_ascii=False,separators=(',',':'))


def build():
    put('game/announce', [
        'execute unless data entity @s data.love_letter.action.actor run return 0',
        'scoreboard players operation #log_table ll_ctx = @s ct_id',
        'data modify storage love_letter:chat event set from entity @s data.love_letter.action',
        'execute store result score #log_actor ll_ctx run data get storage love_letter:chat event.actor',
        'execute store result score #log_target ll_ctx run data get storage love_letter:chat event.target',
        'execute store result score #log_card ll_ctx run data get storage love_letter:chat event.card',
        'data modify storage love_letter:chat actor set value {text:"未知玩家"}',
        'data modify storage love_letter:chat target set value {text:"未知玩家"}',
        'execute as @e[tag=ll.board] if score @s ct_id = #log_table ll_ctx if score @s ll_seat = #log_actor ll_ctx run data modify storage love_letter:chat actor set from entity @s data.ll_name',
        'execute as @e[tag=ll.board] if score @s ct_id = #log_table ll_ctx if score @s ll_seat = #log_target ll_ctx run data modify storage love_letter:chat target set from entity @s data.ll_name',
        'data modify storage love_letter:chat message set value [{text:"[情书] ",color:"gold"}]',
        'data modify storage love_letter:chat message append from storage love_letter:chat actor',
        'execute if score #log_target ll_ctx matches 1..8 run function love_letter:game/chat/target',
        append(' 使用 '),
        'scoreboard players operation #public_role ll_ctx = #log_card ll_ctx',
        'function love_letter:game/role_name',
        'data modify storage love_letter:chat role set from storage love_letter:runtime role',
        'data modify storage love_letter:chat message append from storage love_letter:runtime role',
        *[f'execute if score #log_card ll_ctx matches {i} run function love_letter:game/chat/role_{i}' for i in range(10)],
        'execute if data storage love_letter:chat event.eliminated[0] run function love_letter:game/chat/eliminated',
        append('。'),
        'function love_letter:game/chat/send with storage love_letter:chat',
        'function love_letter:sound/play',
    ])
    put('game/chat/target', [append(' 对 '),'data modify storage love_letter:chat message append from storage love_letter:chat target'])
    effects={0:'，本轮已使用过间谍',2:'，查看了目标的手牌',3:'，比较双方手牌',
             4:'，保护自己直到下回合开始',6:'，摸牌后保留一张，其余按所选顺序放到牌堆底',
             7:'，交换了双方手牌',8:'，完成出牌',9:'，公主被打出'}
    for card,text in effects.items():
        body=[append(text)]
        if card in (2,3,7):
            body=['execute unless score #log_target ll_ctx matches 1..8 run return run function love_letter:game/chat/no_target']+body
        if card==3:
            body+=['execute unless data storage love_letter:chat event.eliminated[0] run '+append('，双方点数相同，无人出局')]
        put(f'game/chat/role_{card}',body)
    put('game/chat/no_target',append('，没有可选目标，本次效果不生效','gray'))
    put('game/chat/role_1', [
        'execute unless score #log_target ll_ctx matches 1..8 run return run function love_letter:game/chat/no_target',
        append('，猜测目标手牌为 '),
        'execute store result score #public_role ll_ctx run data get storage love_letter:chat event.guess',
        'function love_letter:game/role_name',
        'data modify storage love_letter:chat message append from storage love_letter:runtime role',
        'execute if data storage love_letter:chat event.eliminated[0] run '+append('，猜中了','green'),
        'execute unless data storage love_letter:chat event.eliminated[0] run '+append('，未猜中','gray'),
    ])
    put('game/chat/role_5', [
        'execute unless score #log_target ll_ctx matches 1..8 run return run function love_letter:game/chat/no_target',
        append('，令目标弃掉 '),
        'execute store result score #public_role ll_ctx run data get storage love_letter:chat event.forced',
        'function love_letter:game/role_name',
        'data modify storage love_letter:chat message append from storage love_letter:runtime role',
        'execute unless score #public_role ll_ctx matches 9 run '+append(' 并重新摸一张牌'),
    ])
    put('game/chat/eliminated', [
        'execute store result score #log_dead ll_ctx run data get storage love_letter:chat event.eliminated[0]',
        'data remove storage love_letter:chat event.eliminated[0]',
        'execute as @e[tag=ll.board] if score @s ct_id = #log_table ll_ctx if score @s ll_seat = #log_dead ll_ctx run function love_letter:game/chat/eliminated_player',
        'execute if data storage love_letter:chat event.eliminated[0] run function love_letter:game/chat/eliminated',
    ])
    put('game/chat/eliminated_player', [append('；'),'data modify storage love_letter:chat message append from entity @s data.ll_name',append(' 出局','red'),'function love_letter:game/chat/feedback'])
    put('game/chat/send','$tellraw @a[tag=ll.audience] $(message)')
    put('game/chat/feedback', [
        'scoreboard players operation #kill_seat ll_ctx = #log_actor ll_ctx',
        'execute if score #log_card ll_ctx matches 3 if score #log_dead ll_ctx = #log_actor ll_ctx run scoreboard players operation #kill_seat ll_ctx = #log_target ll_ctx',
        'data modify storage love_letter:chat feedback set value {killer:{text:"未知玩家"},victim:{text:"未知玩家"},role:{text:"卡牌"}}',
        'data modify storage love_letter:chat feedback.victim set from entity @s data.ll_name',
        'data modify storage love_letter:chat feedback.role set from storage love_letter:chat role',
        'execute as @e[tag=ll.board] if score @s ct_id = #log_table ll_ctx if score @s ll_seat = #kill_seat ll_ctx run data modify storage love_letter:chat feedback.killer set from entity @s data.ll_name',
        'execute as @a[tag=ll.audience] if score @s ct_id = #log_table ll_ctx if score @s ll_seat = #log_dead ll_ctx run function love_letter:game/chat/subtitle_victim with storage love_letter:chat feedback',
        'execute unless score #kill_seat ll_ctx = #log_dead ll_ctx as @a[tag=ll.audience] if score @s ct_id = #log_table ll_ctx if score @s ll_seat = #kill_seat ll_ctx run function love_letter:game/chat/subtitle_killer with storage love_letter:chat feedback',
    ])
    put('game/chat/subtitle_victim', [
        'title @s times 5 45 10',
        '$title @s subtitle {text:"你被 ",color:"red",extra:[$(killer),{text:" 使用的 "},$(role),{text:" 淘汰"}]}',
        '$execute if score #log_card ll_ctx matches 3 run title @s subtitle {text:"你在与 ",color:"red",extra:[$(killer),{text:" 的男爵比牌中被淘汰"}]}',
        'execute if score #kill_seat ll_ctx = #log_dead ll_ctx run title @s subtitle {text:"你打出或弃置公主，已出局",color:"red"}',
        'title @s title {text:""}',
    ])
    put('game/chat/subtitle_killer', [
        'title @s times 5 45 10',
        '$title @s subtitle {text:"你用 ",color:"gold",extra:[$(role),{text:" 淘汰了 "},$(victim)]}',
        '$execute if score #log_card ll_ctx matches 3 run title @s subtitle {text:"你在男爵比牌中淘汰了 ",color:"gold",extra:[$(victim)]}',
        'title @s title {text:""}',
    ])


if __name__=='__main__':
    build()
