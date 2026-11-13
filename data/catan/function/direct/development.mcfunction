execute store result score #wanted ca_ctx run data get storage catan:direct hand.dev[0]
execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx
function catan:direct/dev_inventory {id:0,fresh:0,name:"骑士",effect:"移动强盗并偷取资源",model:"card:catan/hand/dev/knight"}
execute store result score #wanted ca_ctx run data get storage catan:direct hand.fresh[0]
execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx
function catan:direct/dev_inventory {id:0,fresh:1,name:"骑士",effect:"移动强盗并偷取资源",model:"card:catan/hand/dev/knight"}
execute store result score #wanted ca_ctx run data get storage catan:direct hand.dev[1]
execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx
function catan:direct/dev_inventory {id:1,fresh:0,name:"修路",effect:"免费建造至多两条道路",model:"card:catan/hand/dev/road_building"}
execute store result score #wanted ca_ctx run data get storage catan:direct hand.fresh[1]
execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx
function catan:direct/dev_inventory {id:1,fresh:1,name:"修路",effect:"免费建造至多两条道路",model:"card:catan/hand/dev/road_building"}
execute store result score #wanted ca_ctx run data get storage catan:direct hand.dev[2]
execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx
function catan:direct/dev_inventory {id:2,fresh:0,name:"垄断",effect:"收取所有对手的一种资源",model:"card:catan/hand/dev/monopoly"}
execute store result score #wanted ca_ctx run data get storage catan:direct hand.fresh[2]
execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx
function catan:direct/dev_inventory {id:2,fresh:1,name:"垄断",effect:"收取所有对手的一种资源",model:"card:catan/hand/dev/monopoly"}
execute store result score #wanted ca_ctx run data get storage catan:direct hand.dev[3]
execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx
function catan:direct/dev_inventory {id:3,fresh:0,name:"丰收",effect:"从银行领取任意两张资源",model:"card:catan/hand/dev/plenty"}
execute store result score #wanted ca_ctx run data get storage catan:direct hand.fresh[3]
execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx
function catan:direct/dev_inventory {id:3,fresh:1,name:"丰收",effect:"从银行领取任意两张资源",model:"card:catan/hand/dev/plenty"}
execute store result score #wanted ca_ctx run data get storage catan:direct hand.dev[4]
execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx
function catan:direct/dev_inventory {id:4,fresh:0,name:"胜利点",effect:"秘密计入1胜利点",model:"card:catan/hand/dev/victory_point"}
execute store result score #wanted ca_ctx run data get storage catan:direct hand.fresh[4]
execute store result storage catan:direct count int 1 run scoreboard players get #wanted ca_ctx
function catan:direct/dev_inventory {id:4,fresh:1,name:"胜利点",effect:"秘密计入1胜利点",model:"card:catan/hand/dev/victory_point"}
