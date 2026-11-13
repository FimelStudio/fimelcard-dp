$data modify storage splendor:inventory player set from storage splendor:inventory state.p$(owner)
scoreboard players set #inv_all sp_ctx 0
execute store result score #inv_all sp_ctx run clear @s *[minecraft:custom_data~{splendor:{asset:1b}}] 0
scoreboard players set #inv_own sp_ctx 0
$execute store result score #inv_own sp_ctx run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner)}}] 0
execute unless score #inv_all sp_ctx = #inv_own sp_ctx run clear @s *[minecraft:custom_data~{splendor:{asset:1b}}]
data modify storage splendor:inventory counts set value {}
data modify storage splendor:inventory work set from storage splendor:inventory player.cards
execute if data storage splendor:inventory work[0] run function splendor:inventory/count_card
data modify storage splendor:inventory ctx.count set from storage splendor:inventory player.tokens[0]
function splendor:inventory/gem/0 with storage splendor:inventory ctx
data modify storage splendor:inventory ctx.count set from storage splendor:inventory player.tokens[1]
function splendor:inventory/gem/1 with storage splendor:inventory ctx
data modify storage splendor:inventory ctx.count set from storage splendor:inventory player.tokens[2]
function splendor:inventory/gem/2 with storage splendor:inventory ctx
data modify storage splendor:inventory ctx.count set from storage splendor:inventory player.tokens[3]
function splendor:inventory/gem/3 with storage splendor:inventory ctx
data modify storage splendor:inventory ctx.count set from storage splendor:inventory player.tokens[4]
function splendor:inventory/gem/4 with storage splendor:inventory ctx
data modify storage splendor:inventory ctx.count set from storage splendor:inventory player.tokens[5]
function splendor:inventory/gem/5 with storage splendor:inventory ctx
execute unless data storage splendor:inventory player.reserve[0] run function splendor:inventory/reserve_clear {slot:0}
execute if data storage splendor:inventory player.reserve[0] run function splendor:inventory/reserve_prepare {slot:0}
execute unless data storage splendor:inventory player.reserve[1] run function splendor:inventory/reserve_clear {slot:1}
execute if data storage splendor:inventory player.reserve[1] run function splendor:inventory/reserve_prepare {slot:1}
execute unless data storage splendor:inventory player.reserve[2] run function splendor:inventory/reserve_clear {slot:2}
execute if data storage splendor:inventory player.reserve[2] run function splendor:inventory/reserve_prepare {slot:2}
execute if data storage splendor:inventory counts.c0 run function splendor:inventory/card/0 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c1 run function splendor:inventory/card/1 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c2 run function splendor:inventory/card/2 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c3 run function splendor:inventory/card/3 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c4 run function splendor:inventory/card/4 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c5 run function splendor:inventory/card/5 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c6 run function splendor:inventory/card/6 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c7 run function splendor:inventory/card/7 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c8 run function splendor:inventory/card/8 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c9 run function splendor:inventory/card/9 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c10 run function splendor:inventory/card/10 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c11 run function splendor:inventory/card/11 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c12 run function splendor:inventory/card/12 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c13 run function splendor:inventory/card/13 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c14 run function splendor:inventory/card/14 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c15 run function splendor:inventory/card/15 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c16 run function splendor:inventory/card/16 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c17 run function splendor:inventory/card/17 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c18 run function splendor:inventory/card/18 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c19 run function splendor:inventory/card/19 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c20 run function splendor:inventory/card/20 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c21 run function splendor:inventory/card/21 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c22 run function splendor:inventory/card/22 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c23 run function splendor:inventory/card/23 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c24 run function splendor:inventory/card/24 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c25 run function splendor:inventory/card/25 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c26 run function splendor:inventory/card/26 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c27 run function splendor:inventory/card/27 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c28 run function splendor:inventory/card/28 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c29 run function splendor:inventory/card/29 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c30 run function splendor:inventory/card/30 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c31 run function splendor:inventory/card/31 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c32 run function splendor:inventory/card/32 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c33 run function splendor:inventory/card/33 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c34 run function splendor:inventory/card/34 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c35 run function splendor:inventory/card/35 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c36 run function splendor:inventory/card/36 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c37 run function splendor:inventory/card/37 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c38 run function splendor:inventory/card/38 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c39 run function splendor:inventory/card/39 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c40 run function splendor:inventory/card/40 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c41 run function splendor:inventory/card/41 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c42 run function splendor:inventory/card/42 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c43 run function splendor:inventory/card/43 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c44 run function splendor:inventory/card/44 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c45 run function splendor:inventory/card/45 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c46 run function splendor:inventory/card/46 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c47 run function splendor:inventory/card/47 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c48 run function splendor:inventory/card/48 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c49 run function splendor:inventory/card/49 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c50 run function splendor:inventory/card/50 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c51 run function splendor:inventory/card/51 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c52 run function splendor:inventory/card/52 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c53 run function splendor:inventory/card/53 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c54 run function splendor:inventory/card/54 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c55 run function splendor:inventory/card/55 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c56 run function splendor:inventory/card/56 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c57 run function splendor:inventory/card/57 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c58 run function splendor:inventory/card/58 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c59 run function splendor:inventory/card/59 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c60 run function splendor:inventory/card/60 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c61 run function splendor:inventory/card/61 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c62 run function splendor:inventory/card/62 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c63 run function splendor:inventory/card/63 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c64 run function splendor:inventory/card/64 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c65 run function splendor:inventory/card/65 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c66 run function splendor:inventory/card/66 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c67 run function splendor:inventory/card/67 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c68 run function splendor:inventory/card/68 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c69 run function splendor:inventory/card/69 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c70 run function splendor:inventory/card/70 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c71 run function splendor:inventory/card/71 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c72 run function splendor:inventory/card/72 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c73 run function splendor:inventory/card/73 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c74 run function splendor:inventory/card/74 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c75 run function splendor:inventory/card/75 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c76 run function splendor:inventory/card/76 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c77 run function splendor:inventory/card/77 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c78 run function splendor:inventory/card/78 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c79 run function splendor:inventory/card/79 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c80 run function splendor:inventory/card/80 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c81 run function splendor:inventory/card/81 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c82 run function splendor:inventory/card/82 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c83 run function splendor:inventory/card/83 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c84 run function splendor:inventory/card/84 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c85 run function splendor:inventory/card/85 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c86 run function splendor:inventory/card/86 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c87 run function splendor:inventory/card/87 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c88 run function splendor:inventory/card/88 with storage splendor:inventory ctx
execute if data storage splendor:inventory counts.c89 run function splendor:inventory/card/89 with storage splendor:inventory ctx
data modify storage splendor:inventory work set from storage splendor:inventory player.nobles
execute if data storage splendor:inventory work[0] run function splendor:inventory/noble_next
$execute unless data storage splendor:inventory counts.c0 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:0}}]
$execute unless data storage splendor:inventory counts.c1 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:1}}]
$execute unless data storage splendor:inventory counts.c2 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:2}}]
$execute unless data storage splendor:inventory counts.c3 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:3}}]
$execute unless data storage splendor:inventory counts.c4 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:4}}]
$execute unless data storage splendor:inventory counts.c5 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:5}}]
$execute unless data storage splendor:inventory counts.c6 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:6}}]
$execute unless data storage splendor:inventory counts.c7 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:7}}]
$execute unless data storage splendor:inventory counts.c8 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:8}}]
$execute unless data storage splendor:inventory counts.c9 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:9}}]
$execute unless data storage splendor:inventory counts.c10 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:10}}]
$execute unless data storage splendor:inventory counts.c11 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:11}}]
$execute unless data storage splendor:inventory counts.c12 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:12}}]
$execute unless data storage splendor:inventory counts.c13 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:13}}]
$execute unless data storage splendor:inventory counts.c14 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:14}}]
$execute unless data storage splendor:inventory counts.c15 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:15}}]
$execute unless data storage splendor:inventory counts.c16 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:16}}]
$execute unless data storage splendor:inventory counts.c17 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:17}}]
$execute unless data storage splendor:inventory counts.c18 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:18}}]
$execute unless data storage splendor:inventory counts.c19 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:19}}]
$execute unless data storage splendor:inventory counts.c20 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:20}}]
$execute unless data storage splendor:inventory counts.c21 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:21}}]
$execute unless data storage splendor:inventory counts.c22 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:22}}]
$execute unless data storage splendor:inventory counts.c23 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:23}}]
$execute unless data storage splendor:inventory counts.c24 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:24}}]
$execute unless data storage splendor:inventory counts.c25 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:25}}]
$execute unless data storage splendor:inventory counts.c26 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:26}}]
$execute unless data storage splendor:inventory counts.c27 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:27}}]
$execute unless data storage splendor:inventory counts.c28 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:28}}]
$execute unless data storage splendor:inventory counts.c29 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:29}}]
$execute unless data storage splendor:inventory counts.c30 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:30}}]
$execute unless data storage splendor:inventory counts.c31 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:31}}]
$execute unless data storage splendor:inventory counts.c32 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:32}}]
$execute unless data storage splendor:inventory counts.c33 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:33}}]
$execute unless data storage splendor:inventory counts.c34 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:34}}]
$execute unless data storage splendor:inventory counts.c35 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:35}}]
$execute unless data storage splendor:inventory counts.c36 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:36}}]
$execute unless data storage splendor:inventory counts.c37 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:37}}]
$execute unless data storage splendor:inventory counts.c38 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:38}}]
$execute unless data storage splendor:inventory counts.c39 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:39}}]
$execute unless data storage splendor:inventory counts.c40 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:40}}]
$execute unless data storage splendor:inventory counts.c41 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:41}}]
$execute unless data storage splendor:inventory counts.c42 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:42}}]
$execute unless data storage splendor:inventory counts.c43 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:43}}]
$execute unless data storage splendor:inventory counts.c44 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:44}}]
$execute unless data storage splendor:inventory counts.c45 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:45}}]
$execute unless data storage splendor:inventory counts.c46 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:46}}]
$execute unless data storage splendor:inventory counts.c47 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:47}}]
$execute unless data storage splendor:inventory counts.c48 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:48}}]
$execute unless data storage splendor:inventory counts.c49 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:49}}]
$execute unless data storage splendor:inventory counts.c50 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:50}}]
$execute unless data storage splendor:inventory counts.c51 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:51}}]
$execute unless data storage splendor:inventory counts.c52 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:52}}]
$execute unless data storage splendor:inventory counts.c53 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:53}}]
$execute unless data storage splendor:inventory counts.c54 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:54}}]
$execute unless data storage splendor:inventory counts.c55 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:55}}]
$execute unless data storage splendor:inventory counts.c56 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:56}}]
$execute unless data storage splendor:inventory counts.c57 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:57}}]
$execute unless data storage splendor:inventory counts.c58 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:58}}]
$execute unless data storage splendor:inventory counts.c59 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:59}}]
$execute unless data storage splendor:inventory counts.c60 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:60}}]
$execute unless data storage splendor:inventory counts.c61 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:61}}]
$execute unless data storage splendor:inventory counts.c62 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:62}}]
$execute unless data storage splendor:inventory counts.c63 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:63}}]
$execute unless data storage splendor:inventory counts.c64 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:64}}]
$execute unless data storage splendor:inventory counts.c65 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:65}}]
$execute unless data storage splendor:inventory counts.c66 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:66}}]
$execute unless data storage splendor:inventory counts.c67 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:67}}]
$execute unless data storage splendor:inventory counts.c68 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:68}}]
$execute unless data storage splendor:inventory counts.c69 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:69}}]
$execute unless data storage splendor:inventory counts.c70 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:70}}]
$execute unless data storage splendor:inventory counts.c71 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:71}}]
$execute unless data storage splendor:inventory counts.c72 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:72}}]
$execute unless data storage splendor:inventory counts.c73 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:73}}]
$execute unless data storage splendor:inventory counts.c74 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:74}}]
$execute unless data storage splendor:inventory counts.c75 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:75}}]
$execute unless data storage splendor:inventory counts.c76 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:76}}]
$execute unless data storage splendor:inventory counts.c77 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:77}}]
$execute unless data storage splendor:inventory counts.c78 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:78}}]
$execute unless data storage splendor:inventory counts.c79 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:79}}]
$execute unless data storage splendor:inventory counts.c80 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:80}}]
$execute unless data storage splendor:inventory counts.c81 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:81}}]
$execute unless data storage splendor:inventory counts.c82 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:82}}]
$execute unless data storage splendor:inventory counts.c83 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:83}}]
$execute unless data storage splendor:inventory counts.c84 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:84}}]
$execute unless data storage splendor:inventory counts.c85 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:85}}]
$execute unless data storage splendor:inventory counts.c86 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:86}}]
$execute unless data storage splendor:inventory counts.c87 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:87}}]
$execute unless data storage splendor:inventory counts.c88 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:88}}]
$execute unless data storage splendor:inventory counts.c89 run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:1,card:89}}]
$execute unless data storage splendor:inventory player{nobles:[0]} run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:3,noble:0}}]
$execute unless data storage splendor:inventory player{nobles:[1]} run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:3,noble:1}}]
$execute unless data storage splendor:inventory player{nobles:[2]} run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:3,noble:2}}]
$execute unless data storage splendor:inventory player{nobles:[3]} run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:3,noble:3}}]
$execute unless data storage splendor:inventory player{nobles:[4]} run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:3,noble:4}}]
$execute unless data storage splendor:inventory player{nobles:[5]} run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:3,noble:5}}]
$execute unless data storage splendor:inventory player{nobles:[6]} run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:3,noble:6}}]
$execute unless data storage splendor:inventory player{nobles:[7]} run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:3,noble:7}}]
$execute unless data storage splendor:inventory player{nobles:[8]} run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:3,noble:8}}]
$execute unless data storage splendor:inventory player{nobles:[9]} run clear @s *[minecraft:custom_data~{splendor:{asset:1b,table:$(table),owner:$(owner),kind:3,noble:9}}]
