execute if entity @e[tag=sp.current,scores={sp_state=2},limit=1] run function splendor:hud/notice {"text":{"text":"筹码超过十颗：右键宝石选择退回，左键取消，选够数量后自动退到十颗。","color":"yellow"}}
execute if entity @e[tag=sp.current,scores={sp_state=3},limit=1] run function splendor:hud/notice {"text":{"text":"多位贵族符合要求，请直接右键选择一位来访。","color":"yellow"}}
