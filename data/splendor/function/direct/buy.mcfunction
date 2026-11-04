execute unless entity @e[tag=sp.current,scores={sp_state=1},limit=1] run return 0
function splendor:ui/begin
function splendor:ui/read_target
execute unless score #card sp_ctx matches 0..89 run return 0
function splendor:ui/autopay
function splendor:ui/submit_buy
