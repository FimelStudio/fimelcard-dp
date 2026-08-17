# 冻结本局，按最新总分逐行展示积分排行榜
function fast_card:log {text:"本局结算完成，开始播放积分排行榜变化"}
scoreboard players set @s fc_state 4
scoreboard players set @s fc_phase 0
scoreboard players set @s fc_timer 0
scoreboard players set @s fc_rank 0
scoreboard players operation #ctx_id fc_ctx = @s fc_id
function fast_card:table/clear_button

# 清理桌面和玩家手中的本局牌
execute as @e[type=minecraft:item,distance=..6] run function fast_card:util/kill_if_card
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run function fast_card:util/clear_cards
execute as @a[tag=fc.turn] if score @s fc_id = #ctx_id fc_ctx run tag @s remove fc.turn

# fc_delta在开局时保存旧分数，此处改写为本小局实际分差
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run scoreboard players operation @s fc_aux = @s fc_score
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run scoreboard players operation @s fc_aux -= @s fc_delta
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run scoreboard players operation @s fc_delta = @s fc_aux
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tag @s remove fc.ranked

# 清除可能残留的小局标题，然后显示结算标题
function fast_card:transition/cleanup
function fast_card:transition/ranking_header

# 仍保留个人聊天提示，中央排行榜负责展示四人的整体变化
execute as @a[tag=fc.player] if score @s fc_id = #ctx_id fc_ctx run tellraw @s [{text:'[Fast Card] ',color:'gold'},{text:'你当前的总分：',color:'gray'},{score:{name:'@s',objective:'fc_score'},color:'yellow'},{text:'（本局变化：',color:'dark_gray'},{score:{name:'@s',objective:'fc_delta'},color:'aqua'},{text:'）',color:'dark_gray'}]
