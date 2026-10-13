scoreboard players operation #positional.animation.amount.current_ fca_store = #positional.animation.amount fca_store

scoreboard players set #positional.animation.amount.current fca_store 0

execute if score #positional.animation.amount fca_store matches ..-1 run scoreboard players operation #positional.animation.amount.current fca_store -= #positional.animation.amount.current_ fca_store

execute if score #positional.animation.amount.odd fca_store matches 0 if score #positional.animation.amount fca_store matches ..-1 run scoreboard players remove #positional.animation.amount.current fca_store 1

execute unless score #positional.animation.amount fca_store matches ..-1 run scoreboard players operation #positional.animation.amount.current fca_store = #positional.animation.amount fca_store

scoreboard players add #positional.animation.amount.current fca_store 1

scoreboard players operation #positional.animation.amount.current fca_store *= #positional.animation.timer.step fca_store

scoreboard players remove #positional.animation.amount fca_store 1