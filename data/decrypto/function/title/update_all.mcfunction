# 阶段切换或新提示结算时从第一页开始，随后每5秒翻页。
scoreboard players set @s dc_page 0
scoreboard players set @s dc_page_tick 0
function decrypto:title/render_all
