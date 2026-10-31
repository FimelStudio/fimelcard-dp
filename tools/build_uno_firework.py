"""生成 UNO 胜者烟花；使用已合并 SK Firework 的公开接口。"""

from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
DEST = ROOT / "data/uno/function/firework"


def write(name, content):
    path = DEST / f"{name}.mcfunction"
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content.strip() + "\n", encoding="utf-8")


def main():
    write("winner", """
# 由确认获胜的 UNO 控制器调用；不在出完末张但仍待质疑时调用。
# 使用通用真实座椅定位，因此四座、八座和稀疏入座均无需复制坐标。
execute unless entity @s[type=minecraft:marker,tag=un.controller] run return 0
execute unless score @s un_winner matches 1..8 run return 0
scoreboard players operation #u_fw_table un_ctx = @s ct_id
scoreboard players operation #u_fw_seat un_ctx = @s un_winner
scoreboard players set #u_fw_done un_ctx 0
execute as @e[type=minecraft:interaction,tag=ct.seat] if score @s ct_id = #u_fw_table un_ctx if score @s ct_seat = #u_fw_seat un_ctx at @s run function uno:firework/launch
# 兼容缺失座椅的测试环境或修复中的牌桌；不使用 nearest 认定胜者。
execute if score #u_fw_done un_ctx matches 0 as @e[tag=un.player] if score @s ct_id = #u_fw_table un_ctx if score @s un_table = #u_fw_table un_ctx if score @s un_seat = #u_fw_seat un_ctx at @s run function uno:firework/launch
return run scoreboard players get #u_fw_done un_ctx
""")
    write("launch", """
# 执行位置为赢家真实座椅或赢家本人；每次入口至多发射一次。
execute unless score #u_fw_done un_ctx matches 0 run return 0
scoreboard players set #u_fw_done un_ctx 1
# 直接使用 SK Firework 公开接口；四色球升空后爆炸，不复制库的实现。
# 标签与桌号属于本桌，烟花自然结束，无需按距离删除任何其他特效。
tag @e[type=minecraft:firework_rocket,tag=un.firework.new] remove un.firework.new
playsound minecraft:entity.firework_rocket.launch master @a[distance=..32] ~ ~1 ~ 0.9 1.1
execute positioned ~ ~1 ~ run function fimel_sklibs:skfirework/fx/firework {config:{life:20,shape:1,colors:{from:[I;16733525,16777045,5635925,5592575],to:[I;16777215]},n:1,trail:true,twinkle:true,tags:["un.firework","un.firework.new"]}}
scoreboard players operation @e[type=minecraft:firework_rocket,tag=un.firework.new] ct_id = #u_fw_table un_ctx
scoreboard players operation @e[type=minecraft:firework_rocket,tag=un.firework.new] un_seat = #u_fw_seat un_ctx
tag @e[type=minecraft:firework_rocket,tag=un.firework.new] remove un.firework.new
return 1
""")


if __name__ == "__main__":
    main()
