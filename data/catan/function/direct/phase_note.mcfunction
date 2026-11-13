execute if entity @e[tag=ca.current,scores={ca_state=3},limit=1] run return run function catan:direct/roll_first
function catan:hud/notice {"text":{"text":"当前阶段不能建造或交易：请先完成初始布置、弃牌或强盗操作。","color":"red"}}
