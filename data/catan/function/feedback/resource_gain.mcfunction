$data modify storage catan:feedback gain set value {owner:$(owner),amount:$(amount),resource:$(resource),label:"资源"}
execute if data storage catan:feedback gain{resource:0} run data modify storage catan:feedback gain.label set value "木材"
execute if data storage catan:feedback gain{resource:1} run data modify storage catan:feedback gain.label set value "砖块"
execute if data storage catan:feedback gain{resource:2} run data modify storage catan:feedback gain.label set value "羊毛"
execute if data storage catan:feedback gain{resource:3} run data modify storage catan:feedback gain.label set value "粮食"
execute if data storage catan:feedback gain{resource:4} run data modify storage catan:feedback gain.label set value "矿石"
function catan:feedback/gain_message with storage catan:feedback gain
