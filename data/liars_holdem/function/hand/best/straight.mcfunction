# 只改变最佳五张的展示顺序，不改变用于比较牌力的 lh_k1
# A 固定为14，因此所有有效顺子都可以安全地从“最高点数-4”开始
scoreboard players operation #pick_rank lh_ctx = @s lh_k1
scoreboard players remove #pick_rank lh_ctx 4
function liars_holdem:hand/best/pick_rank
scoreboard players add #pick_rank lh_ctx 1
function liars_holdem:hand/best/pick_rank
scoreboard players add #pick_rank lh_ctx 1
function liars_holdem:hand/best/pick_rank
scoreboard players add #pick_rank lh_ctx 1
function liars_holdem:hand/best/pick_rank
scoreboard players add #pick_rank lh_ctx 1
function liars_holdem:hand/best/pick_rank
