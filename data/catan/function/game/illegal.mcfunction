data modify storage catan:runtime error set value "当前操作不可用，请重新打开菜单查看下一步。"
scoreboard players set #illegal_code ca_ctx 0
execute store result score #illegal_code ca_ctx run data get storage catan:action input.code
execute if score #error ca_ctx matches 1 run data modify storage catan:runtime error set value "对局状态不可用，请等待恢复或结束本局。"
execute if score #error ca_ctx matches 2 run data modify storage catan:runtime error set value "你不在本局的参与名单中。"
execute if score #error ca_ctx matches 3 run data modify storage catan:runtime error set value "这个窗口已经过期，请从第9格 Q 菜单重新操作。"
execute if score #error ca_ctx matches 4 run data modify storage catan:runtime error set value "当前不是执行该操作的阶段或轮次，请看菜单顶部的个人提示。"
execute if score #error ca_ctx matches 5 run data modify storage catan:runtime error set value "目标位置不合法，请重新瞄准交点、边或另一块地块。"
execute if score #error ca_ctx matches 6 run data modify storage catan:runtime error set value "本次支付或领取所需的资源不足。请检查自己的资源、银行库存或交易报价。"
execute if score #error ca_ctx matches 7 run data modify storage catan:runtime error set value "所需棋子或开发牌不足。"
execute if score #error ca_ctx matches 8 run data modify storage catan:runtime error set value "资源数量不符合要求：弃牌须恰好选满，交易须双方均有给出且不含相同种类。"
execute if score #error ca_ctx matches 10 run data modify storage catan:runtime error set value "开发牌不可使用：须有旧牌、每回合至多一张；新买牌下回合才能用。"
execute if score #error ca_ctx matches 11 run data modify storage catan:runtime error set value "该请求已完成或不属于你，请重新查看当前请求。"
execute if score #error ca_ctx matches 12 run data modify storage catan:runtime error set value "正在计算或结算，请稍候。"
execute if score #error ca_ctx matches 5 if score #illegal_code ca_ctx matches 1 run data modify storage catan:runtime error set value "村庄须放在空交点，且与已有村庄／城市至少隔一个空交点。"
execute if score #error ca_ctx matches 5 if score #illegal_code ca_ctx matches 2 run data modify storage catan:runtime error set value "初始道路须放在刚放村庄紧邻的空边中段。"
execute if score #error ca_ctx matches 5 if score #illegal_code ca_ctx matches 20 run data modify storage catan:runtime error set value "道路须选空边，并接到己方道路或建筑；不能穿过对手建筑。"
execute if score #error ca_ctx matches 5 if score #illegal_code ca_ctx matches 21 run data modify storage catan:runtime error set value "村庄须接己方道路，交点未占用，且与其他建筑至少隔一个空交点。"
execute if score #error ca_ctx matches 5 if score #illegal_code ca_ctx matches 22 run data modify storage catan:runtime error set value "城市只能升级己方已有村庄，请瞄准该村庄交点。"
execute if score #error ca_ctx matches 5 if score #illegal_code ca_ctx matches 12 run data modify storage catan:runtime error set value "强盗须移动到另一块六边形地块，不能仍留在原格。"
function catan:game/illegal_message with storage catan:runtime
function catan:sound/illegal
execute as @a[tag=ca.actor] run function catan:ui/open
