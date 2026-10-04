# 本轮提示与敌方笔记合成同一BetterTitle面板，由库持续绘制。
# 仅在提示公开时重建，不再每tick独立发送Actionbar覆盖左上角。
execute unless score @s dc_state matches 5..8 run return 0
execute unless data entity @s data.decrypto.active_clues run return 0
function decrypto:title/render_all
