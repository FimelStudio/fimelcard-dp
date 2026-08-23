# 法术效果结束后立刻检查；不等待当前施法者主动结束回合。
scoreboard players operation #ctx ab_ctx = @s ab_id
tag @a[tag=ab.this_knocked] remove ab.this_knocked
tag @a[tag=ab.this_effect_caster] remove ab.this_effect_caster
execute as @a[tag=ab.player] if score @s ab_id = #ctx ab_ctx if score @s ab_hp matches ..0 run tag @s add ab.knocked
execute as @a[tag=ab.knocked] if score @s ab_id = #ctx ab_ctx run tag @s add ab.this_knocked
execute as @a[tag=ab.effect_caster] if score @s ab_id = #ctx ab_ctx run tag @s add ab.this_effect_caster
# 只有成功咒语造成其他玩家倒下时，才会产生“击倒胜者”；施法失败自损不会误判为胜利。
execute if entity @a[tag=ab.this_knocked,tag=!ab.this_effect_caster] run tag @a[tag=ab.this_effect_caster] add ab.round_winner
execute if entity @a[tag=ab.this_knocked] run function abraca:game/round_finish
execute as @a[tag=ab.knocked] if score @s ab_id = #ctx ab_ctx run tag @s remove ab.knocked
tag @a[tag=ab.this_knocked] remove ab.this_knocked
tag @a[tag=ab.this_effect_caster] remove ab.this_effect_caster
