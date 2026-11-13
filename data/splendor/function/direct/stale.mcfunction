function splendor:direct/reset
execute as @e[tag=sp.current,limit=1] at @s run function splendor:visual/selection
function splendor:hud/notice {"text":{"text":"局面已更新，请重新选择。","color":"yellow"}}
