# 阶段切换时按桌号回收库存和地面上的类别工具。
scoreboard players operation #menu_table wq_ctx = @s wq_id
execute as @a[tag=wq.player] if score @s wq_id = #menu_table wq_ctx run clear @s *[minecraft:custom_data~{wenfei:{tool:"menu"}}]
execute store result storage wenfei:io menu_cleanup.table int 1 run scoreboard players get @s wq_id
function wenfei:input/clear_category_drops with storage wenfei:io menu_cleanup
