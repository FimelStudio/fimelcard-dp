"""公共对局会话、断线暂停和跨局清理。只生成公共层，不改游戏规则。"""
from pathlib import Path
import json

PACK=Path(__file__).resolve().parents[1]
ROOT=PACK/'data/cardtable/function'
DIMS=('minecraft:overworld','minecraft:the_nether','minecraft:the_end')
GAMES=[('fast_card','fc'),('liars_holdem','lh'),('hanabi','hb'),('abraca','ab'),('bullshit','bw'),('decrypto','dc'),('critical_point','cp'),('wenfei','wq'),('skull','sk'),('doudizhu','dd'),('uno','un'),('chess','ch'),('xiangqi','xq'),('gomoku','gm'),('aeroplane_chess','ac'),('avalon','av'),('love_letter','ll'),('guandan','gd'),('ito','it'),('weiqi','go'),('catan','ca'),('splendor','sp'),('magical_athlete','ma')]

def put(name,lines):
    p=ROOT/(name+'.mcfunction');p.parent.mkdir(parents=True,exist_ok=True)
    p.write_bytes((('\n'.join(lines) if isinstance(lines,list) else lines).strip()+'\n').encode('utf-8'))

def hook(name,key,body,before=None,after=None):
    p=ROOT/(name+'.mcfunction');s=p.read_text(encoding='utf-8')
    begin='# BEGIN '+key;end='# END '+key
    block=begin+'\n'+body.strip()+'\n'+end+'\n'
    if begin in s:
        start=s.index(begin);stop=s.index(end,start)+len(end)
        s=s[:start]+block+s[stop:].lstrip('\n')
    elif before:
        assert before in s,(name,before);s=s.replace(before,block+before,1)
    elif after:
        assert after in s,(name,after);s=s.replace(after,after+'\n'+block,1)
    else:s=block+s
    p.write_bytes(s.replace('\r\n','\n').rstrip().encode('utf-8')+b'\n')

def build():
    put('session/load',[
        '# 会话编号持久递增，重载不重置；离线玩家的旧编号留待重新上线核验。',
        *[f'scoreboard objectives add {o} dummy' for o in ('ct_session','ct_expected','ct_paused','ct_rejoin','ct_wait')],
        'execute unless score #session ct_ctx matches 0.. run scoreboard players set #session ct_ctx 0',
        *[f'execute in {d} as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={{ct_state=1}}] at @s unless score @s ct_session matches 1.. run function cardtable:session/migrate' for d in DIMS],
        *[f'execute in {d} as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={{ct_state=1,ct_session=1..}}] run function cardtable:session/mark_active' for d in DIMS]])
    put('session/start',[
        '# 仅在具体游戏开局成功、玩家换座完成后调用，真人与机器人分开计数。',
        'scoreboard players add #session ct_ctx 1',
        'scoreboard players operation @s ct_session = #session ct_ctx',
        'function cardtable:session/mark_active',
        'scoreboard players set @s ct_expected 0','scoreboard players set @s ct_paused 0','scoreboard players set @s ct_wait 0',
        'scoreboard players operation #session_table ct_ctx = @s ct_id',
        'scoreboard players operation #session_id ct_ctx = @s ct_session',
        'data remove entity @s data.cardtable.session_legacy',
        'data modify entity @s data.cardtable.members set value []',
        'tag @s add ct.session_build',
        'execute as @a[tag=ct.player] if score @s ct_id = #session_table ct_ctx run function cardtable:session/register_player',
        'tag @s remove ct.session_build',
        'scoreboard players add @s ct_ch_epoch 1'])
    put('session/register_player',[
        'scoreboard players operation @s ct_session = #session_id ct_ctx',
        'scoreboard players set @s ct_paused 0','scoreboard players set @s ct_rejoin 0',
        'scoreboard players set @s ct_online 1','tag @s remove ct.rejoining',
        'function cardtable:settings/clear_session',
        'function cardtable:chairs/settings/clear_session',
        'scoreboard players add @e[tag=ct.session_build,limit=1] ct_expected 1',
        'data modify storage cardtable:session member set value {}',
        'data modify storage cardtable:session member.uuid set from entity @s UUID',
        'execute store result storage cardtable:session member.seat int 1 run scoreboard players get @s ct_seat',
        'data modify entity @e[tag=ct.session_build,limit=1] data.cardtable.members append from storage cardtable:session member'])
    put('session/migrate',[
        '# 为升级前已经开局的桌建立快照，尽量保留旧joined记录中的离线席位。',
        'scoreboard players operation #legacy_joined ct_ctx = @s ct_joined',
        'function cardtable:session/start',
        'execute if score #legacy_joined ct_ctx > @s ct_expected run scoreboard players operation @s ct_expected = #legacy_joined ct_ctx',
        'data modify entity @s data.cardtable.session_legacy set value 1b'])
    put('session/end',[
        '# 先使会话失效；离线成员上线时只清理自己，绝不再触发旧游戏abort。',
        'scoreboard players operation #session_table ct_ctx = @s ct_id',
        'execute as @a[tag=ct.player] if score @s ct_id = #session_table ct_ctx run function cardtable:session/end_player',
        'execute if score @s ct_session matches 1.. run function cardtable:session/mark_ended',
        'scoreboard players set @s ct_session 0','scoreboard players set @s ct_expected 0',
        'scoreboard players set @s ct_paused 0','scoreboard players set @s ct_wait 0',
        'scoreboard players add @s ct_ch_epoch 1',
        'data remove entity @s data.cardtable.members','data remove entity @s data.cardtable.session_legacy',
        'execute as @e[tag=ct.part] if score @s ct_id = #session_table ct_ctx run scoreboard players set @s ct_paused 0'])
    put('session/drop_member',[
        '# 规则淘汰真正释放座位时注销该成员；离线本身绝不调用本函数。',
        'execute unless score @s ct_session matches 1.. run return 0',
        'scoreboard players operation #depart_table ct_ctx = @s ct_id',
        'scoreboard players operation #depart_session ct_ctx = @s ct_session',
        'execute store result storage cardtable:session departed.seat int 1 run scoreboard players get @s ct_seat',
        *[f'execute in {d} as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={{ct_state=1}}] if score @s ct_id = #depart_table ct_ctx if score @s ct_session = #depart_session ct_ctx run function cardtable:session/drop_at_table' for d in DIMS]])
    put('session/drop_at_table',[
        'execute if score @s ct_expected matches 1.. run scoreboard players remove @s ct_expected 1',
        'function cardtable:session/drop_roster with storage cardtable:session departed'])
    put('session/drop_roster',['$data remove entity @s data.cardtable.members[{seat:$(seat)}]'])
    put('session/end_player',[
        'execute if score @s ct_paused matches 1 run title @s actionbar {text:""}',
        'scoreboard players reset @s ct_session','scoreboard players set @s ct_paused 0',
        'scoreboard players reset @s ct_rejoin','tag @s remove ct.rejoining',
        'function cardtable:settings/clear_session',
        'function cardtable:chairs/settings/clear_session'])
    put('session/pre_tick',[
        '# 必须早于游戏tick与通用调度库；本刻掉线立刻暂停，不让计时多走一刻。',
        *[f'execute in {d} as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={{ct_state=1}}] at @s unless score @s ct_session matches 1.. run function cardtable:session/migrate' for d in DIMS],
        'execute as @a[tag=ct.player,tag=!ct.rejoining] unless score @s ct_online matches 1 run function cardtable:session/begin_rejoin',
        'execute as @a[tag=ct.player,tag=ct.rejoining] at @s run function cardtable:session/reconcile_player',
        *[f'execute in {d} as @e[type=minecraft:marker,tag=ct.controller,distance=0..,scores={{ct_state=1}}] at @s run function cardtable:session/check_table' for d in DIMS],
        'scoreboard players set * ct_online 0','scoreboard players set @a[tag=ct.player] ct_online 1'])
    put('session/begin_rejoin',[
        'tag @s add ct.rejoining','scoreboard players set @s ct_rejoin 0','scoreboard players set @s ct_paused 1'])
    put('session/reconcile_player',[
        'scoreboard players operation #rejoin_table ct_ctx = @s ct_id',
        'scoreboard players set #rejoin_found ct_ctx 0','scoreboard players set #rejoin_valid ct_ctx 0',
        'tag @s add ct.reconnect_actor',
        *[f'execute in {d} as @e[type=minecraft:marker,tag=ct.controller,distance=0..] at @s if score @s ct_id = #rejoin_table ct_ctx run function cardtable:session/reconcile_at_table' for d in DIMS],
        'tag @s remove ct.reconnect_actor',
        'execute if score #rejoin_valid ct_ctx matches 1 run return 1',
        'execute if score #rejoin_found ct_ctx matches 1 run return run function cardtable:game/remove_offline_player',
        '# 会话注册表独立于实体区块；桌暂未载入时绝不误清仍在进行的局。',
        'execute if score @s ct_session matches 1.. run return run function cardtable:session/reconcile_unloaded',
        '# 升级前没有会话号的旧成员使用短暂载入宽限。',
        'scoreboard players add @s ct_rejoin 1',
        'execute if score @s ct_rejoin matches 40.. run function cardtable:game/remove_offline_player'])
    put('session/mark_active',[
        'execute store result storage cardtable:session round int 1 run scoreboard players get @s ct_session',
        'function cardtable:session/registry_active with storage cardtable:session'])
    put('session/mark_ended',[
        'execute store result storage cardtable:session round int 1 run scoreboard players get @s ct_session',
        'function cardtable:session/registry_ended with storage cardtable:session'])
    put('session/registry_active',['$scoreboard players set #round.$(round) ct_session 1'])
    put('session/registry_ended',['$scoreboard players reset #round.$(round) ct_session'])
    put('session/reconcile_unloaded',[
        'scoreboard players set #round_active ct_ctx 0',
        'execute store result storage cardtable:session round int 1 run scoreboard players get @s ct_session',
        'function cardtable:session/registry_check with storage cardtable:session',
        'execute unless score #round_active ct_ctx matches 1 run function cardtable:game/remove_offline_player'])
    put('session/registry_check',['$execute if score #round.$(round) ct_session matches 1 run scoreboard players set #round_active ct_ctx 1'])
    put('session/reconcile_at_table',[
        'scoreboard players set #rejoin_found ct_ctx 1',
        'execute unless score @s ct_state matches 1 run return 0',
        'execute unless score @s ct_session matches 1.. run return 0',
        'execute if score @a[tag=ct.reconnect_actor,limit=1] ct_session = @s ct_session run scoreboard players set #rejoin_valid ct_ctx 1',
        '# 仅允许尚未分配会话号的老版本成员加入迁移中的旧局。',
        'execute if data entity @s data.cardtable{session_legacy:1b} unless score @a[tag=ct.reconnect_actor,limit=1] ct_session matches 1.. run function cardtable:session/legacy_member',
        'execute unless score #rejoin_valid ct_ctx matches 1 run return 0',
        'function cardtable:table/ensure_seats',
        'scoreboard players operation #rejoin_session ct_ctx = @s ct_session',
        'execute as @a[tag=ct.reconnect_actor,limit=1] run function cardtable:session/reattach_player'])
    put('session/legacy_member',[
        *[f'execute if score @s ct_game matches {i} if entity @a[tag=ct.reconnect_actor,tag={pre}.player,limit=1] run scoreboard players set #rejoin_valid ct_ctx 1' for i,(_,pre) in enumerate(GAMES,1)]])
    put('session/reattach_player',[
        'scoreboard players operation @s ct_session = #rejoin_session ct_ctx',
        'scoreboard players set @s ct_online 1','scoreboard players set @s ct_rejoin 0',
        'tag @s remove ct.rejoining','function cardtable:seat/mount'])
    put('session/check_table',[
        'scoreboard players operation #session_table ct_ctx = @s ct_id',
        'scoreboard players operation #session_id ct_ctx = @s ct_session',
        'scoreboard players set #session_online ct_ctx 0',
        'execute as @a[tag=ct.player,tag=!ct.rejoining] if score @s ct_id = #session_table ct_ctx if score @s ct_session = #session_id ct_ctx run scoreboard players add #session_online ct_ctx 1',
        'scoreboard players operation #was_paused ct_ctx = @s ct_paused',
        'scoreboard players set @s ct_paused 0',
        'execute if score #session_online ct_ctx < @s ct_expected run scoreboard players set @s ct_paused 1',
        'scoreboard players operation #is_paused ct_ctx = @s ct_paused',
        '# 恢复第一刻再清一次暂停末尾输入，随后才解锁玩家。',
        'execute if score #is_paused ct_ctx matches 0 if score #was_paused ct_ctx matches 1 run function cardtable:session/discard_paused_inputs',
        'execute as @a[tag=ct.player] if score @s ct_id = #session_table ct_ctx run scoreboard players operation @s ct_paused = #is_paused ct_ctx',
        'execute unless score #was_paused ct_ctx = #is_paused ct_ctx as @e[tag=ct.part] if score @s ct_id = #session_table ct_ctx run scoreboard players operation @s ct_paused = #is_paused ct_ctx',
        'execute if score @s ct_paused matches 1 unless score #was_paused ct_ctx matches 1 run function cardtable:session/pause',
        'execute if score @s ct_paused matches 0 if score #was_paused ct_ctx matches 1 run function cardtable:session/resume',
        'execute if score @s ct_paused matches 1 run function cardtable:session/wait'])
    put('session/pause',[
        'scoreboard players set @s ct_wait 0',
        'execute if score @s ct_game matches 18 run function guandan:music/pause',
        'execute if score @s ct_game matches 22 run function splendor:sound/pause',
        'execute if score @s ct_game matches 23 run function magical_athlete:sound/pause',
        'execute as @a[tag=ct.player] if score @s ct_id = #session_table ct_ctx run dialog clear @s',
        'execute as @a[tag=ct.player] if score @s ct_id = #session_table ct_ctx run tellraw @s {text:"[牌桌] 有玩家离线，对局已暂停；全部玩家回来后继续，也可投票结束游戏。",color:"yellow"}'])
    put('session/wait',[
        'function cardtable:session/discard_paused_inputs',
        'scoreboard players add @s ct_wait 1',
        'scoreboard players operation #missing ct_ctx = @s ct_expected',
        'scoreboard players operation #missing ct_ctx -= #session_online ct_ctx',
        'execute if score @s ct_wait matches 1 as @a[tag=ct.player] if score @s ct_id = #session_table ct_ctx run title @s actionbar [{text:"对局暂停 · 等待 ",color:"yellow"},{score:{name:"#missing",objective:"ct_ctx"}},{text:" 位玩家重连 · 可投票结束",color:"gray"}]',
        'execute if score @s ct_wait matches 20.. run scoreboard players set @s ct_wait 0'])
    put('session/resume',[
        'scoreboard players set @s ct_wait 0',
        'execute if score @s ct_game matches 23 run function magical_athlete:sound/resume',
        'execute as @a[tag=ct.player] if score @s ct_id = #session_table ct_ctx run title @s actionbar {text:""}',
        'execute as @a[tag=ct.player] if score @s ct_id = #session_table ct_ctx run tellraw @s {text:"[牌桌] 玩家已全部返回，对局继续。",color:"green"}',
        'function cardtable:session/refresh_ui'])
    from build_session_refresh import build as build_refresh
    build_refresh(GAMES)
    put('session/deal_tick',[
        '# 冻结在途实体，避免暂停时仍拾取/超时消失；恢复后使用原有补发路径。',
        'scoreboard players operation #flight_table ct_ctx = @s ct_id',
        'scoreboard players set #flight_paused ct_ctx 0',
        'execute as @e[type=minecraft:marker,tag=ct.controller,scores={ct_paused=1}] if score @s ct_id = #flight_table ct_ctx run scoreboard players set #flight_paused ct_ctx 1',
        'execute if score #flight_paused ct_ctx matches 1 run return run function cardtable:session/freeze_deal',
        'execute if entity @s[tag=ct.deal_frozen] run return run function cardtable:session/thaw_deal',
        'function cardtable:animation/deal/flying_tick'])
    put('session/freeze_deal',[
        'tag @s add ct.deal_frozen',
        'data merge entity @s {NoGravity:1b,Motion:[0.0d,0.0d,0.0d],PickupDelay:32767s,Age:0s}'])
    put('session/thaw_deal',[
        'tag @s remove ct.deal_frozen',
        'data merge entity @s {NoGravity:0b}',
        'function cardtable:animation/deal/ensure_delivery'])

    hook('load','public session load','function cardtable:settings/load\nfunction cardtable:chairs/settings/load\nfunction cardtable:session/load',before='# 重载后旧选择窗口失效')
    hook('game/start','public session start','function cardtable:session/start',after='scoreboard players set @s ct_state 1')
    # 上局结束后新开局前不要沿用暂停位，具体game/start内也会调用输入刷新。
    hook('game/start','public pause reset','scoreboard players set @s ct_paused 0',before='scoreboard players set @s ct_start 0')
    hook('game/return_lobby','public session end','function cardtable:session/end',before='scoreboard players set @s ct_state 0')
    hook('table/remove','public session end','function cardtable:session/end',before='scoreboard players operation #ctx_id ct_ctx = @s ct_id')
    for name in ('seat/leave','seat/remove_player'):
        hook(name,'public session player reset','function cardtable:session/end_player')
    hook('seat/remove_player','public session member departure','function cardtable:session/drop_member',before='# BEGIN public session player reset')
    p=ROOT/'game/remove_offline_player.mcfunction';s=p.read_text(encoding='utf-8')
    s=s.replace('function critical_point:game/player_left','function critical_point:player/clear_state')
    s=s.replace('# 离线即视为离开牌桌；保持静默，不发送入座或离座提示','# 仅用于旧局已经结束/桌被移除的重连者；仍在进行的同局交给session恢复。')
    p.write_bytes(s.replace('\r\n','\n').rstrip().encode('utf-8')+b'\n')
    p=ROOT/'tick.mcfunction';s=p.read_text(encoding='utf-8')
    s=s.replace('# 上一刻不在线却仍保留牌桌身份，说明该玩家离线后刚刚返回\n# 先通过游戏分派清除其旧游戏状态，再释放旧座位\nexecute as @a[tag=ct.player] unless score @s ct_online matches 1 run function cardtable:game/remove_offline_player\n','')
    s=s.replace('run function cardtable:animation/deal/flying_tick','run function cardtable:session/deal_tick')
    s=s.replace('# 牌桌人数以当前在线且仍持有牌桌身份的玩家为准，离线后座位立即变为空闲','# 在线人数用于大厅与结束投票；局内断线席位由独立ct_expected快照保留。')
    s=s.replace('# 每刻末尾更新在线心跳；离线玩家的记分会保持为0\nscoreboard players set * ct_online 0\nscoreboard players set @a[tag=ct.player] ct_online 1\n','')
    p.write_bytes(s.replace('\r\n','\n').rstrip().encode('utf-8')+b'\n')
    hook('tick','public chair settings tick','execute as @a[scores={ct_chair_pick=1..}] at @s run function cardtable:chairs/settings/handle')
    hook('tick','public game settings tick','execute as @a[scores={ct_setting=1..}] at @s run function cardtable:settings/handle')
    p=PACK/'data/minecraft/tags/function/tick.json';tag=json.loads(p.read_text(encoding='utf-8'))
    tag['values']=[v for v in tag['values'] if v!='cardtable:session/pre_tick'];tag['values'].insert(0,'cardtable:session/pre_tick')
    p.write_text(json.dumps(tag,ensure_ascii=False,indent=2)+'\n',encoding='utf-8')

if __name__=='__main__':build()
