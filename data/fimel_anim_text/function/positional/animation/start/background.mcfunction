data modify storage fimel_anim_text:runtime positional.animation.background append value "\u3000"

scoreboard players remove #positional.animation.amount fca_store 1

execute unless score #positional.animation.amount fca_store matches 0 run function fimel_anim_text:positional/animation/start/background