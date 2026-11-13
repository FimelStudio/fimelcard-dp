scoreboard players set #valid ca_ctx 0
execute unless data storage catan:engine state.trade run return 0
execute store result score #trade_id ca_ctx run data get storage catan:engine state.trade.id
execute store result score #trade_from ca_ctx run data get storage catan:engine state.trade.from
execute store result score #trade_to ca_ctx run data get storage catan:engine state.trade.to
execute unless score #target ca_ctx = #trade_id ca_ctx run return 0
data modify storage catan:engine state.last.from set from storage catan:engine state.trade.from
data modify storage catan:engine state.last.to set from storage catan:engine state.trade.to
execute store result score #offer0 ca_ctx run data get storage catan:engine state.trade.offer[0]
execute store result score #want0 ca_ctx run data get storage catan:engine state.trade.want[0]
execute store result score #offer1 ca_ctx run data get storage catan:engine state.trade.offer[1]
execute store result score #want1 ca_ctx run data get storage catan:engine state.trade.want[1]
execute store result score #offer2 ca_ctx run data get storage catan:engine state.trade.offer[2]
execute store result score #want2 ca_ctx run data get storage catan:engine state.trade.want[2]
execute store result score #offer3 ca_ctx run data get storage catan:engine state.trade.offer[3]
execute store result score #want3 ca_ctx run data get storage catan:engine state.trade.want[3]
execute store result score #offer4 ca_ctx run data get storage catan:engine state.trade.offer[4]
execute store result score #want4 ca_ctx run data get storage catan:engine state.trade.want[4]
scoreboard players set #valid ca_ctx 1
