# Explosion visual and sound only; no TNT, damage or block changes.
particle minecraft:explosion ~ ~1.55 ~ 0 0 0 0 1 force @a[distance=..32]
playsound minecraft:entity.generic.explode master @a[distance=..32] ~ ~1.55 ~ 0.55 1.25
