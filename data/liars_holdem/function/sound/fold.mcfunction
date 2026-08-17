# 弃牌声保持短促，随后由左轮演出接管声音焦点
scoreboard players operation #ctx_id lh_ctx = @s lh_id
execute as @a[tag=lh.action_actor] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:block.candle.extinguish player @s ~ ~ ~ 0.62 0.80
execute as @a[tag=lh.action_actor] if score @s lh_id = #ctx_id lh_ctx at @s as @a[tag=lh.player] if score @s lh_id = #ctx_id lh_ctx run playsound minecraft:item.book.page_turn player @s ~ ~ ~ 0.28 0.65
