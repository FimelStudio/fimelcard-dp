data modify storage doudizhu:hud shown_play set value {text:"尚未出牌",color:"gray"}
$execute if data entity @e[tag=dd.current,limit=1] data.doudizhu.hud_plays.s$(seat) run data modify storage doudizhu:hud shown_play set from entity @e[tag=dd.current,limit=1] data.doudizhu.hud_plays.s$(seat)
