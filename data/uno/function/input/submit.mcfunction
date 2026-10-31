# 编码：当前 epoch × 1000 + 动作；旧对话框及选色页不能操作后续回合。
scoreboard players operation @s un_ui_tmp = @s un_action
scoreboard players set @s un_action 0
scoreboard players enable @s un_action
function uno:input/context
execute unless entity @s[tag=un.actor] run return run function uno:input/invalid
scoreboard players set #ui_1000 un_ctx 1000
scoreboard players operation #ui_epoch un_ctx = @s un_ui_tmp
scoreboard players operation #ui_epoch un_ctx /= #ui_1000 un_ctx
execute unless score #ui_epoch un_ctx = @s un_seen run return run function uno:input/invalid
execute unless score #ui_epoch un_ctx = @e[tag=un.current,limit=1] un_epoch run return run function uno:input/invalid
scoreboard players operation #ui_base un_ctx = @s un_seen
scoreboard players operation #ui_base un_ctx *= #ui_1000 un_ctx
scoreboard players operation #ui_action un_ctx = @s un_ui_tmp
scoreboard players operation #ui_action un_ctx %= #ui_1000 un_ctx
execute if score #ui_action un_ctx matches 200..203 unless score @s un_pick = @s un_colorpick run return run function uno:input/invalid
execute if score #ui_action un_ctx matches 210..213 unless score @s un_pick = @s un_colorpick run return run function uno:input/invalid
execute if score #ui_action un_ctx matches 200..203 unless score @s un_colorpick matches 52..53 run return run function uno:input/invalid
execute if score #ui_action un_ctx matches 210..213 unless score @s un_colorpick matches 52..53 run return run function uno:input/invalid
execute if score #ui_action un_ctx matches 100..153 run return run function uno:input/select
execute if score #ui_action un_ctx matches 1..2 if score @s un_pick matches 52..53 run return run function uno:ui/colors
scoreboard players set #say un_ctx 0
scoreboard players set #color un_ctx 0
execute if score #ui_action un_ctx matches 2 run scoreboard players set #say un_ctx 1
execute if score #ui_action un_ctx matches 200..203 run scoreboard players operation #color un_ctx = #ui_action un_ctx
execute if score #ui_action un_ctx matches 200..203 run scoreboard players remove #color un_ctx 200
execute if score #ui_action un_ctx matches 210..213 run scoreboard players operation #color un_ctx = #ui_action un_ctx
execute if score #ui_action un_ctx matches 210..213 run scoreboard players remove #color un_ctx 210
execute if score #ui_action un_ctx matches 210..213 run scoreboard players set #say un_ctx 1
# 核心只在真正提交牌后置1；出牌失败继续打开窗口修正选择。
scoreboard players set #ui_played un_ctx 0
execute if score #ui_action un_ctx matches 1..2 as @e[tag=un.current,limit=1] at @s run function uno:action/play
execute if score #ui_action un_ctx matches 200..203 if score @s un_pick matches 52..53 as @e[tag=un.current,limit=1] at @s run function uno:action/play
execute if score #ui_action un_ctx matches 210..213 if score @s un_pick matches 52..53 as @e[tag=un.current,limit=1] at @s run function uno:action/play
execute if score #ui_played un_ctx matches 1 run dialog clear @s
execute if score #ui_played un_ctx matches 1 run tag @a[tag=un.actor] remove un.actor
execute if score #ui_played un_ctx matches 1 run return 0
execute if score #ui_action un_ctx matches 3 as @e[tag=un.current,limit=1] at @s run function uno:action/draw
execute if score #ui_action un_ctx matches 4 as @e[tag=un.current,limit=1] at @s run function uno:action/pass
execute if score #ui_action un_ctx matches 5 as @e[tag=un.current,limit=1] at @s run function uno:action/call
execute if score #ui_action un_ctx matches 6 as @e[tag=un.current,limit=1] at @s run function uno:action/catch
execute if score #ui_action un_ctx matches 7 as @e[tag=un.current,limit=1] at @s run function uno:action/accept
execute if score #ui_action un_ctx matches 8 as @e[tag=un.current,limit=1] at @s run function uno:action/challenge
execute if entity @s[tag=un.player] run function uno:ui/open
tag @a[tag=un.actor] remove un.actor
