execute unless entity @e[tag=sp.current,scores={sp_state=3},limit=1] run return run function splendor:hud/notice {"text":{"text":"贵族满足发展卡要求后自动来访；同时符合多位时，每回合选择一位。","color":"yellow"}}
scoreboard players set #action_code sp_ctx 5
function splendor:direct/submit
