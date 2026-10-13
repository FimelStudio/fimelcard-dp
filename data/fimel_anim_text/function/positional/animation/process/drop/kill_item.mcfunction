# tp实体

execute on vehicle run kill @s

execute unless entity @s[tag=fimel.anim_text.positional.animation.drop.billboard] run tp @s ~ ~ ~ ~ -88

tag @s add fimel.anim_text.positional.animation.drop.onground

function fimel_anim_text:positional/animation/process/fade/start