function doudizhu:player/audience
execute as @a[tag=dd.audience] run function doudizhu:hand/show
tag @a[tag=dd.audience] remove dd.audience
