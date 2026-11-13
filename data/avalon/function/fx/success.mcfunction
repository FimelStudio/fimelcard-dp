# Small green/gold firework burst at the table centre; particles cannot damage players or the table.
particle minecraft:firework ~ ~2.3 ~ 0.12 0.12 0.12 0.10 36 force @a[distance=..32]
particle minecraft:dust{color:[0.25,1.0,0.35],scale:0.7} ~ ~2.3 ~ 0.35 0.3 0.35 0 20 force @a[distance=..32]
particle minecraft:dust{color:[1.0,0.8,0.2],scale:0.6} ~ ~2.3 ~ 0.25 0.25 0.25 0 12 force @a[distance=..32]
playsound minecraft:entity.firework_rocket.blast master @a[distance=..32] ~ ~2.3 ~ 0.55 1.3
