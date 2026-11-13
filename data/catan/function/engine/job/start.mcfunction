data modify storage catan:engine state.job set value {player:1,best:0,bits:[],stack:[],resume:4}
execute store result storage catan:engine state.job.resume int 1 run scoreboard players get #resume ca_ctx
data modify storage catan:engine state.phase set value 10
function catan:engine/cache
function catan:engine/job/prepare
