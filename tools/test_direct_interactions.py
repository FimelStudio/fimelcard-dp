"""Isolated production-function smoke tests for direct tabletop interactions."""
from test_catan_engine import Suite,run
s=Suite()
lines=['function splendor:load','scoreboard players set #vis_table sp_ctx 101','summon minecraft:marker 8 64 8 {Tags:["sp.current","ce.fixture"],data:{splendor:{bank:[4,4,4,4,4,5]}}}','scoreboard players set @e[tag=sp.current,limit=1] sp_epoch 7','data modify storage splendor:direct hit set value {table:101,epoch:7,kind:4,id:0}','execute positioned 8 65 8 summon minecraft:interaction run function splendor:direct/hit_init with storage splendor:direct hit']
lines+=s.check('entity @e[type=minecraft:interaction,tag=sp.hit,scores={ct_id=101},nbt={data:{hit:{epoch:7,kind:4,id:0}}}]','gem_hit_metadata')
lines+=s.check('entity @e[type=minecraft:text_display,tag=sp.visual,scores={ct_id=101}]','bank_count_spawned')
lines+=['scoreboard players set #vis_table sp_ctx 202','data modify storage splendor:direct hit.table set value 202','execute positioned 10 65 8 summon minecraft:interaction run function splendor:direct/hit_init with storage splendor:direct hit','scoreboard players set @e[tag=sp.current,limit=1] ct_id 101','execute as @e[tag=sp.current,limit=1] run function splendor:visual/clear']
lines+=s.check('entity @e[tag=sp.hit,scores={ct_id=202}]','other_table_survives')
lines+=['scoreboard players set #remaining ce 0','execute as @e[tag=sp.hit,scores={ct_id=101}] run scoreboard players add #remaining ce 1']
lines+=s.score('#remaining','ce',0,'clicked_table_cleared')
s.case('direct',lines);s.finish()
raise SystemExit(run(s,full=True,prefix='fimel-direct-',setup_ticks=80))
