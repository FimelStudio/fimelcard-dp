scoreboard players set @s wq_state 4
function wenfei:round/new_epoch
function wenfei:player/mark_audience
clear @a[tag=wq.audience] *[minecraft:custom_data~{wenfei:{tool:"score"}}]
scoreboard players operation #gain wq_ctx = @s wq_gain
execute as @a[tag=wq.audience,scores={wq_guess=1}] run scoreboard players operation @s wq_score += #gain wq_ctx
data modify storage wenfei:io result set from entity @s data.wenfei
tellraw @a[tag=wq.audience] [{text:"正确问题：",color:"gold"},{nbt:"result.correct.text",storage:"wenfei:io"}]
tellraw @a[tag=wq.audience] [{text:"本轮排列：\n",color:"aqua"},{nbt:"result.placed[]",storage:"wenfei:io",interpret:true,separator:{text:""}}]
tellraw @a[tag=wq.audience] [{selector:"@a[tag=wq.audience,scores={wq_guess=1},limit=1]"},{text:" 本轮获得 "},{score:{name:"@s",objective:"wq_gain"}},{text:" 分。",color:"green"}]
execute as @a[tag=wq.audience] run tellraw @a[tag=wq.audience] [{selector:"@s"},{text:" 累计："},{score:{name:"@s",objective:"wq_score"}},{text:" 分"}]
function wenfei:log {text:"回合结算完成"}
function wenfei:hud/update
function wenfei:round/next
