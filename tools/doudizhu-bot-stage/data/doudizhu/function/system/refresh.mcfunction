function doudizhu:player/audience
execute as @a[tag=dd.audience] run function doudizhu:hand/show
tag @a[tag=dd.audience] remove dd.audience
tag @e[tag=dd.actors] remove dd.actors
