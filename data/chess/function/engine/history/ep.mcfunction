# 吃过路只有确实存在合法走法时才影响重复局面的同一性（包括被钉住情形）。
scoreboard players set #promo ch_ctx 5
scoreboard players set #found ch_ctx 0
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches 1 if score #ep ch_ctx matches 40 if score #b33 ch_ctx matches 1 run function chess:engine/history/ep_probe {from:33,to:40}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches 1 if score #ep ch_ctx matches 41 if score #b32 ch_ctx matches 1 run function chess:engine/history/ep_probe {from:32,to:41}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches 1 if score #ep ch_ctx matches 41 if score #b34 ch_ctx matches 1 run function chess:engine/history/ep_probe {from:34,to:41}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches 1 if score #ep ch_ctx matches 42 if score #b33 ch_ctx matches 1 run function chess:engine/history/ep_probe {from:33,to:42}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches 1 if score #ep ch_ctx matches 42 if score #b35 ch_ctx matches 1 run function chess:engine/history/ep_probe {from:35,to:42}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches 1 if score #ep ch_ctx matches 43 if score #b34 ch_ctx matches 1 run function chess:engine/history/ep_probe {from:34,to:43}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches 1 if score #ep ch_ctx matches 43 if score #b36 ch_ctx matches 1 run function chess:engine/history/ep_probe {from:36,to:43}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches 1 if score #ep ch_ctx matches 44 if score #b35 ch_ctx matches 1 run function chess:engine/history/ep_probe {from:35,to:44}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches 1 if score #ep ch_ctx matches 44 if score #b37 ch_ctx matches 1 run function chess:engine/history/ep_probe {from:37,to:44}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches 1 if score #ep ch_ctx matches 45 if score #b36 ch_ctx matches 1 run function chess:engine/history/ep_probe {from:36,to:45}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches 1 if score #ep ch_ctx matches 45 if score #b38 ch_ctx matches 1 run function chess:engine/history/ep_probe {from:38,to:45}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches 1 if score #ep ch_ctx matches 46 if score #b37 ch_ctx matches 1 run function chess:engine/history/ep_probe {from:37,to:46}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches 1 if score #ep ch_ctx matches 46 if score #b39 ch_ctx matches 1 run function chess:engine/history/ep_probe {from:39,to:46}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches 1 if score #ep ch_ctx matches 47 if score #b38 ch_ctx matches 1 run function chess:engine/history/ep_probe {from:38,to:47}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches -1 if score #ep ch_ctx matches 16 if score #b25 ch_ctx matches -1 run function chess:engine/history/ep_probe {from:25,to:16}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches -1 if score #ep ch_ctx matches 17 if score #b24 ch_ctx matches -1 run function chess:engine/history/ep_probe {from:24,to:17}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches -1 if score #ep ch_ctx matches 17 if score #b26 ch_ctx matches -1 run function chess:engine/history/ep_probe {from:26,to:17}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches -1 if score #ep ch_ctx matches 18 if score #b25 ch_ctx matches -1 run function chess:engine/history/ep_probe {from:25,to:18}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches -1 if score #ep ch_ctx matches 18 if score #b27 ch_ctx matches -1 run function chess:engine/history/ep_probe {from:27,to:18}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches -1 if score #ep ch_ctx matches 19 if score #b26 ch_ctx matches -1 run function chess:engine/history/ep_probe {from:26,to:19}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches -1 if score #ep ch_ctx matches 19 if score #b28 ch_ctx matches -1 run function chess:engine/history/ep_probe {from:28,to:19}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches -1 if score #ep ch_ctx matches 20 if score #b27 ch_ctx matches -1 run function chess:engine/history/ep_probe {from:27,to:20}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches -1 if score #ep ch_ctx matches 20 if score #b29 ch_ctx matches -1 run function chess:engine/history/ep_probe {from:29,to:20}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches -1 if score #ep ch_ctx matches 21 if score #b28 ch_ctx matches -1 run function chess:engine/history/ep_probe {from:28,to:21}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches -1 if score #ep ch_ctx matches 21 if score #b30 ch_ctx matches -1 run function chess:engine/history/ep_probe {from:30,to:21}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches -1 if score #ep ch_ctx matches 22 if score #b29 ch_ctx matches -1 run function chess:engine/history/ep_probe {from:29,to:22}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches -1 if score #ep ch_ctx matches 22 if score #b31 ch_ctx matches -1 run function chess:engine/history/ep_probe {from:31,to:22}
execute if score #found ch_ctx matches 0 if score #side ch_ctx matches -1 if score #ep ch_ctx matches 23 if score #b30 ch_ctx matches -1 run function chess:engine/history/ep_probe {from:30,to:23}
execute if score #found ch_ctx matches 1 run scoreboard players operation #effective_ep ch_ctx = #ep ch_ctx
