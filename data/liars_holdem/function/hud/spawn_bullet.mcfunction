# 直接让刚生成的实体成为执行者，避免用全局limit=1反查时误选其他牌桌或旧版残留实体
$execute positioned ~ ~1.10 ~ summon minecraft:item_display run function liars_holdem:hud/init_bullet {x:$(x),z:$(z),rot:$(rot),seat:$(seat)}
