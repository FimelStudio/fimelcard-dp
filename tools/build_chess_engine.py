"""生成国际象棋纯 mcfunction 规则核心。

棋格 a1=0..h8=63；棋子白正黑负：兵1、马2、象3、车4、后5、王6。
所有入口以本桌控制器执行。真实棋格 marker 与 ch.board 临时标签由公共适配层维护。
生成器只拥有 data/chess/function/engine/，不接触界面、视觉和生命周期。
"""
from pathlib import Path
import re
from textwrap import dedent

ROOT = Path(__file__).resolve().parents[1] / "data/chess/function/engine"


def put(name, text):
    target = ROOT / (name + ".mcfunction")
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text("\n".join(re.sub(r" {2,}", " ", line.strip()) for line in dedent(text).strip().splitlines()) + "\n", encoding="utf-8")


def sq(f, r):
    return r * 8 + f if 0 <= f < 8 and 0 <= r < 8 else None


def candidates(start, kind):
    f, r = start % 8, start // 8
    if kind == 1:
        return sorted({x for d in (-1, 1) for x in (sq(f, r+d), sq(f, r+2*d), sq(f-1, r+d), sq(f+1, r+d)) if x is not None})
    if kind in (2, 6):
        jumps = [(1, 2), (2, 1), (-1, 2), (-2, 1), (1, -2), (2, -1), (-1, -2), (-2, -1)] if kind == 2 else [(a, b) for a in (-1, 0, 1) for b in (-1, 0, 1) if a or b]
        result = [sq(f+a, r+b) for a, b in jumps if sq(f+a, r+b) is not None]
        if kind == 6 and start in (4, 60):
            result.extend((start-2, start+2))
        return sorted(result)
    dirs = []
    if kind in (3, 5):
        dirs += [(1, 1), (1, -1), (-1, 1), (-1, -1)]
    if kind in (4, 5):
        dirs += [(1, 0), (-1, 0), (0, 1), (0, -1)]
    return sorted({sq(f+df*d, r+dr*d) for df, dr in dirs for d in range(1, 8) if sq(f+df*d, r+dr*d) is not None})


def store_entity(path, score):
    return f"execute store result entity @s data.chess.last.{path} int 1 run scoreboard players get {score} ch_ctx"


put("cache", """
    # 单次同步64格；之后走法/受攻击判断只访问分数缓存，不反复搜索实体。
    scoreboard players operation #side ch_ctx = @s ch_turn
    scoreboard players operation #castle ch_ctx = @s ch_castle
    scoreboard players operation #ep ch_ctx = @s ch_ep
    scoreboard players set #wking ch_ctx -1
    scoreboard players set #bking ch_ctx -1
    scoreboard players set #cache_ok ch_ctx 1
    execute store result score #cache_size ch_ctx if entity @e[type=minecraft:marker,tag=ch.board]
    execute unless score #cache_size ch_ctx matches 64 run scoreboard players set #cache_ok ch_ctx 0
    execute as @e[type=minecraft:marker,tag=ch.board] unless score @s ch_piece matches -6..6 run scoreboard players set #cache_ok ch_ctx 0
    execute store result score #king_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_piece=6}]
    execute unless score #king_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
    execute store result score #king_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={ch_piece=-6}]
    execute unless score #king_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0
""" + "\n".join(
    f"scoreboard players set #b{i} ch_ctx 0\n"
    f"execute store result score #cell_count ch_ctx if entity @e[type=minecraft:marker,tag=ch.board,scores={{ch_sq={i}}}]\n"
    f"execute unless score #cell_count ch_ctx matches 1 run scoreboard players set #cache_ok ch_ctx 0\n"
    f"scoreboard players operation #b{i} ch_ctx = @e[type=minecraft:marker,tag=ch.board,scores={{ch_sq={i}}},limit=1] ch_piece\n"
    f"execute if score #b{i} ch_ctx matches 6 run scoreboard players set #wking ch_ctx {i}\n"
    f"execute if score #b{i} ch_ctx matches -6 run scoreboard players set #bking ch_ctx {i}"
    for i in range(64)
))

initial = [4, 2, 3, 5, 6, 3, 2, 4] + [1]*8 + [0]*32 + [-1]*8 + [-4, -2, -3, -5, -6, -3, -2, -4]
put("init_board", """
    # 既可供大厅预览，也可供正式开局：不改ch_state/计时/玩家归属。
    function chess:system/context
    scoreboard players set @s ch_turn 1
    scoreboard players set @s ch_castle 15
    scoreboard players set @s ch_ep -1
    scoreboard players set @s ch_half 0
    scoreboard players set @s ch_full 1
    scoreboard players set @s ch_result 0
    scoreboard players set @s ch_reason 0
    scoreboard players set @s ch_check 0
    scoreboard players set @s ch_repetition 0
    data modify entity @s data.chess.history set value []
    data remove entity @s data.chess.last
""" + "\n".join(f"scoreboard players set @e[type=minecraft:marker,tag=ch.board,scores={{ch_sq={i}}},limit=1] ch_piece {p}" for i, p in enumerate(initial)) + """
    function chess:engine/cache
    execute unless score #cache_ok ch_ctx matches 1 run return 0
    function chess:engine/history/record
""")

put("try_move", """
    # #from/#to=棋格，#promo=0等待升变或2马3象4车5后。非法绝不修改真实局面。
    function chess:system/context
    function chess:engine/cache
    scoreboard players set #legal ch_ctx 0
    execute unless score #cache_ok ch_ctx matches 1 run return 0
    execute unless score #from ch_ctx matches 0..63 run return 0
    execute unless score #to ch_ctx matches 0..63 run return 0
    execute unless score #promo ch_ctx matches 0..5 run return 0
    execute if score #promo ch_ctx matches 1 run return 0
    execute unless score @s ch_state matches 1..3 run return 0
    execute unless score @s ch_state matches 1 unless score @s ch_state matches 3 run return 0
    function chess:engine/check_move
    execute unless score #legal ch_ctx matches 1 run return 0
    execute if score #promotion ch_ctx matches 1 if score #promo ch_ctx matches 0 run return run function chess:engine/promotion_pending
    function chess:engine/commit
    return 1
""")
put("promotion_pending", """
    scoreboard players set #legal ch_ctx 2
    return 2
""")

put("check_move", """
    scoreboard players set #legal ch_ctx 0
    execute unless score #cache_ok ch_ctx matches 1 run return 0
    scoreboard players set #shape ch_ctx 0
    scoreboard players set #promotion ch_ctx 0
    scoreboard players set #capture_sq ch_ctx -1
    scoreboard players set #rook_from ch_ctx -1
    scoreboard players set #rook_to ch_ctx -1
    execute if score #from ch_ctx = #to ch_ctx run return 0
    execute store result storage chess:engine scratch.from int 1 run scoreboard players get #from ch_ctx
    execute store result storage chess:engine scratch.to int 1 run scoreboard players get #to ch_ctx
    function chess:engine/get_pieces with storage chess:engine scratch
    execute if score #side ch_ctx matches 1 unless score #piece ch_ctx matches 1..6 run return 0
    execute if score #side ch_ctx matches -1 unless score #piece ch_ctx matches -6..-1 run return 0
    execute if score #side ch_ctx matches 1 if score #target ch_ctx matches 1..6 run return 0
    execute if score #side ch_ctx matches -1 if score #target ch_ctx matches -6..-1 run return 0
    execute if score #target ch_ctx matches 6 run return 0
    execute if score #target ch_ctx matches -6 run return 0
    scoreboard players operation #kind ch_ctx = #piece ch_ctx
    execute if score #kind ch_ctx matches ..-1 run scoreboard players operation #kind ch_ctx *= #minus ch_ctx
    execute store result storage chess:engine scratch.kind int 1 run scoreboard players get #kind ch_ctx
    function chess:engine/dispatch_shape with storage chess:engine scratch
    execute unless score #shape ch_ctx matches 1 run return 0
    execute if score #kind ch_ctx matches 1 if score #to ch_ctx matches 0..7 run scoreboard players set #promotion ch_ctx 1
    execute if score #kind ch_ctx matches 1 if score #to ch_ctx matches 56..63 run scoreboard players set #promotion ch_ctx 1
    # 升变类型不会改变己王安全；待选时用后模拟，真实棋子保持不动。
    scoreboard players operation #placed ch_ctx = #piece ch_ctx
    execute if score #promotion ch_ctx matches 1 run scoreboard players set #placed ch_ctx 5
    execute if score #promotion ch_ctx matches 1 if score #promo ch_ctx matches 2..5 run scoreboard players operation #placed ch_ctx = #promo ch_ctx
    execute if score #promotion ch_ctx matches 1 run scoreboard players operation #placed ch_ctx *= #side ch_ctx
    execute if score #target ch_ctx matches ..-1 run scoreboard players operation #capture_sq ch_ctx = #to ch_ctx
    execute if score #target ch_ctx matches 1.. run scoreboard players operation #capture_sq ch_ctx = #to ch_ctx
    function chess:engine/simulate
    execute if score #attacked ch_ctx matches 0 run scoreboard players set #legal ch_ctx 1
    return run scoreboard players get #legal ch_ctx
""")
put("get_pieces", """
    $scoreboard players operation #piece ch_ctx = #b$(from) ch_ctx
    $scoreboard players operation #target ch_ctx = #b$(to) ch_ctx
""")
put("check", """
    # 对外非提交探测；与try_move使用相同规则但不要求游戏状态，也不改变真实局面。
    function chess:system/context
    function chess:engine/cache
    scoreboard players set #legal ch_ctx 0
    execute unless score #cache_ok ch_ctx matches 1 run return 0
    execute unless score #from ch_ctx matches 0..63 run return 0
    execute unless score #to ch_ctx matches 0..63 run return 0
    function chess:engine/check_move
    return run scoreboard players get #legal ch_ctx
""")
put("dispatch_shape", "$function chess:engine/shape/p$(kind)/s$(from)")

# 每个目标格独立生成受攻击判定：兵/马/王为跳点，象/车/后沿射线遇首子即止。
put("attack", """
    scoreboard players set #attacked ch_ctx 0
    execute unless score #attack_sq ch_ctx matches 0..63 run return 0
    execute store result storage chess:engine attack.sq int 1 run scoreboard players get #attack_sq ch_ctx
    function chess:engine/attack_dispatch with storage chess:engine attack
    return run scoreboard players get #attacked ch_ctx
""")
put("attack_dispatch", "$function chess:engine/attack/s$(sq)")
for t in range(64):
    f, r = t % 8, t // 8
    lines = []
    for side in (1, -1):
        for df in (-1, 1):
            s = sq(f+df, r-side)
            if s is not None:
                lines.append(f"execute if score #attacker ch_ctx matches {side} if score #b{s} ch_ctx matches {side} run scoreboard players set #attacked ch_ctx 1")
        for kind in (2, 6):
            for s in candidates(t, kind):
                if kind == 6 and abs(s-t) == 2:
                    continue
                lines.append(f"execute if score #attacker ch_ctx matches {side} if score #b{s} ch_ctx matches {side*kind} run scoreboard players set #attacked ch_ctx 1")
        for df, dr in [(1, 0), (-1, 0), (0, 1), (0, -1), (1, 1), (-1, 1), (1, -1), (-1, -1)]:
            path = []
            piece = side * (3 if df and dr else 4)
            for d in range(1, 8):
                s = sq(f+df*d, r+dr*d)
                if s is None:
                    break
                free = " ".join(f"if score #b{x} ch_ctx matches 0" for x in path)
                for p in (piece, side*5):
                    lines.append(f"execute if score #attacker ch_ctx matches {side} {free} if score #b{s} ch_ctx matches {p} run scoreboard players set #attacked ch_ctx 1")
                path.append(s)
    # 已发现攻击可立即返回；减少将军局面下的反复验证成本。
    put(f"attack/s{t}", "\n".join(lines))

for start in range(64):
    f, r = start % 8, start // 8
    for kind in range(1, 7):
        lines = []
        for to in candidates(start, kind):
            tf, tr = to % 8, to // 8
            cond = f"execute if score #to ch_ctx matches {to}"
            if kind == 1:
                for side in (1, -1):
                    prefix = cond + f" if score #side ch_ctx matches {side}"
                    if tf == f and tr-r == side:
                        lines.append(prefix + " if score #target ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1")
                    if tf == f and tr-r == 2*side and r == (1 if side == 1 else 6):
                        lines.append(prefix + f" if score #target ch_ctx matches 0 if score #b{start+side*8} ch_ctx matches 0 run scoreboard players set #shape ch_ctx 1")
                    if abs(tf-f) == 1 and tr-r == side:
                        opp = "-6..-1" if side == 1 else "1..6"
                        lines.append(prefix + f" if score #target ch_ctx matches {opp} run scoreboard players set #shape ch_ctx 1")
                        if r == (4 if side == 1 else 3):
                            lines.append(prefix + f" if score #target ch_ctx matches 0 if score #ep ch_ctx matches {to} if score #b{to-side*8} ch_ctx matches {-side} run function chess:engine/ep/s{to-side*8}")
            elif kind in (2, 6):
                if kind == 6 and start in (4, 60) and abs(to-start) == 2:
                    lines.append(cond + f" run function chess:engine/castle/s{start}_t{to}")
                else:
                    lines.append(cond + " run scoreboard players set #shape ch_ctx 1")
            else:
                df = (tf > f) - (tf < f)
                dr = (tr > r) - (tr < r)
                count = max(abs(tf-f), abs(tr-r))
                free = " ".join(f"if score #b{sq(f+df*d,r+dr*d)} ch_ctx matches 0" for d in range(1, count))
                lines.append(cond + " " + free + " run scoreboard players set #shape ch_ctx 1")
        put(f"shape/p{kind}/s{start}", "\n".join(lines) or "return 0")

for capture in list(range(24, 32)) + list(range(32, 40)):
    put(f"ep/s{capture}", f"scoreboard players set #capture_sq ch_ctx {capture}\nscoreboard players set #shape ch_ctx 1")

for start, to, rook_from, rook_to, bit, side, empty in [
    (4, 6, 7, 5, 1, 1, (5, 6)), (4, 2, 0, 3, 2, 1, (1, 2, 3)),
    (60, 62, 63, 61, 4, -1, (61, 62)), (60, 58, 56, 59, 8, -1, (57, 58, 59)),
]:
    divide = {1: "", 2: "scoreboard players operation #right ch_ctx /= #two ch_ctx\n", 4: "scoreboard players operation #right ch_ctx /= #four ch_ctx\n", 8: "scoreboard players operation #right ch_ctx /= #eight ch_ctx\n"}[bit]
    put(f"castle/s{start}_t{to}", f"""
        execute unless score #side ch_ctx matches {side} run return 0
        execute unless score #b{rook_from} ch_ctx matches {side*4} run return 0
        scoreboard players operation #right ch_ctx = #castle ch_ctx
        {divide}scoreboard players operation #right ch_ctx %= #two ch_ctx
        execute unless score #right ch_ctx matches 1 run return 0
    """ + "\n".join(f"execute unless score #b{x} ch_ctx matches 0 run return 0" for x in empty) + f"""
        scoreboard players set #attacker ch_ctx {-side}
        scoreboard players set #attack_sq ch_ctx {start}
        function chess:engine/attack
        execute if score #attacked ch_ctx matches 1 run return 0
        scoreboard players set #attack_sq ch_ctx {rook_to}
        function chess:engine/attack
        execute if score #attacked ch_ctx matches 1 run return 0
        scoreboard players set #rook_from ch_ctx {rook_from}
        scoreboard players set #rook_to ch_ctx {rook_to}
        scoreboard players set #shape ch_ctx 1
    """)

put("simulate", """
    execute store result storage chess:engine scratch.capture_sq int 1 run scoreboard players get #capture_sq ch_ctx
    execute store result storage chess:engine scratch.rook_from int 1 run scoreboard players get #rook_from ch_ctx
    execute store result storage chess:engine scratch.rook_to int 1 run scoreboard players get #rook_to ch_ctx
    function chess:engine/apply_cache with storage chess:engine scratch
    execute if score #capture_sq ch_ctx matches 0..63 unless score #capture_sq ch_ctx = #to ch_ctx run function chess:engine/ep_remove with storage chess:engine scratch
    execute if score #rook_from ch_ctx matches 0..63 run function chess:engine/rook_apply with storage chess:engine scratch
    scoreboard players operation #attack_sq ch_ctx = #wking ch_ctx
    execute if score #side ch_ctx matches -1 run scoreboard players operation #attack_sq ch_ctx = #bking ch_ctx
    execute if score #kind ch_ctx matches 6 run scoreboard players operation #attack_sq ch_ctx = #to ch_ctx
    scoreboard players operation #attacker ch_ctx = #side ch_ctx
    scoreboard players operation #attacker ch_ctx *= #minus ch_ctx
    function chess:engine/attack
    # 恢复模拟缓存；包括吃过路被吃兵与易位的车。
    function chess:engine/restore_cache with storage chess:engine scratch
    execute if score #capture_sq ch_ctx matches 0..63 unless score #capture_sq ch_ctx = #to ch_ctx run function chess:engine/ep_restore with storage chess:engine scratch
    execute if score #rook_from ch_ctx matches 0..63 run function chess:engine/rook_restore with storage chess:engine scratch
""")
put("apply_cache", "$scoreboard players set #b$(from) ch_ctx 0\n$scoreboard players operation #b$(to) ch_ctx = #placed ch_ctx")
put("restore_cache", "$scoreboard players operation #b$(from) ch_ctx = #piece ch_ctx\n$scoreboard players operation #b$(to) ch_ctx = #target ch_ctx")
put("ep_remove", "$scoreboard players set #b$(capture_sq) ch_ctx 0")
put("ep_restore", "$scoreboard players operation #b$(capture_sq) ch_ctx = #side ch_ctx\n$scoreboard players operation #b$(capture_sq) ch_ctx *= #minus ch_ctx")
put("rook_apply", "$scoreboard players set #b$(rook_from) ch_ctx 0\n$scoreboard players operation #b$(rook_to) ch_ctx = #side ch_ctx\n$scoreboard players operation #b$(rook_to) ch_ctx *= #four ch_ctx")
put("rook_restore", "$scoreboard players set #b$(rook_to) ch_ctx 0\n$scoreboard players operation #b$(rook_from) ch_ctx = #side ch_ctx\n$scoreboard players operation #b$(rook_from) ch_ctx *= #four ch_ctx")

put("commit", """
    # 最后一步元数据先落在控制器，后续局面历史探测不会破坏动画/聊天输入。
    data modify entity @s data.chess.last set value {from:0,to:0,piece:0,captured:0,capture_sq:-1,rook_from:-1,rook_to:-1,promotion:0}
    scoreboard players operation #captured ch_ctx = #target ch_ctx
    execute if score #capture_sq ch_ctx matches 0..63 unless score #capture_sq ch_ctx = #to ch_ctx run scoreboard players operation #captured ch_ctx = #side ch_ctx
    execute if score #capture_sq ch_ctx matches 0..63 unless score #capture_sq ch_ctx = #to ch_ctx run scoreboard players operation #captured ch_ctx *= #minus ch_ctx
""" + "\n".join(store_entity(path, score) for path, score in [
    ("from", "#from"), ("to", "#to"), ("piece", "#piece"), ("captured", "#captured"), ("capture_sq", "#capture_sq"), ("rook_from", "#rook_from"), ("rook_to", "#rook_to")
]) + """
    execute if score #promotion ch_ctx matches 1 store result entity @s data.chess.last.promotion int 1 run scoreboard players get #promo ch_ctx
    function chess:engine/apply_cache with storage chess:engine scratch
    execute if score #capture_sq ch_ctx matches 0..63 unless score #capture_sq ch_ctx = #to ch_ctx run function chess:engine/ep_remove with storage chess:engine scratch
    execute if score #rook_from ch_ctx matches 0..63 run function chess:engine/rook_apply with storage chess:engine scratch
    # 初始王/车移动、车在初始格被吃都会永久收回易位权。
    scoreboard players operation #old_castle ch_ctx = #castle ch_ctx
    function chess:engine/update_rights
    function chess:engine/history/prune
    scoreboard players set @s ch_ep -1
    scoreboard players set #ep ch_ctx -1
    scoreboard players operation #distance ch_ctx = #to ch_ctx
    scoreboard players operation #distance ch_ctx -= #from ch_ctx
    execute if score #kind ch_ctx matches 1 if score #distance ch_ctx matches 16 run function chess:engine/set_ep_white
    execute if score #kind ch_ctx matches 1 if score #distance ch_ctx matches -16 run function chess:engine/set_ep_black
    scoreboard players add @s ch_half 1
    execute if score #kind ch_ctx matches 1 run scoreboard players set @s ch_half 0
    execute unless score #captured ch_ctx matches 0 run scoreboard players set @s ch_half 0
    execute if score #side ch_ctx matches -1 run scoreboard players add @s ch_full 1
    scoreboard players operation @s ch_turn *= #minus ch_ctx
    scoreboard players operation #side ch_ctx = @s ch_turn
    # 只写本桌标记，缓存索引与ct_id隔离由context保证。
""" + "\n".join(f"scoreboard players operation @e[type=minecraft:marker,tag=ch.board,scores={{ch_sq={i}}},limit=1] ch_piece = #b{i} ch_ctx" for i in range(64)) + """
    function chess:engine/cache
    function chess:engine/history/record
    scoreboard players set #legal ch_ctx 1
    function chess:game/after_move
""")
put("set_ep_white", "scoreboard players operation #ep ch_ctx = #from ch_ctx\nscoreboard players add #ep ch_ctx 8\nscoreboard players operation @s ch_ep = #ep ch_ctx")
put("set_ep_black", "scoreboard players operation #ep ch_ctx = #from ch_ctx\nscoreboard players remove #ep ch_ctx 8\nscoreboard players operation @s ch_ep = #ep ch_ctx")

rights_lines = []
for bit in (1, 2, 4, 8):
    put(f"rights/remove{bit}", f"scoreboard players operation #right ch_ctx = #castle ch_ctx\n" + (f"scoreboard players operation #right ch_ctx /= #{ {2:'two',4:'four',8:'eight'}[bit]} ch_ctx\n" if bit > 1 else "") + f"scoreboard players operation #right ch_ctx %= #two ch_ctx\nexecute if score #right ch_ctx matches 1 run scoreboard players remove #castle ch_ctx {bit}")
for side, king, bits in ((1, 6, (1, 2)), (-1, -6, (4, 8))):
    for bit in bits:
        rights_lines.append(f"execute if score #piece ch_ctx matches {king} run function chess:engine/rights/remove{bit}")
for home, p, bit in ((0, 4, 2), (7, 4, 1), (56, -4, 8), (63, -4, 4)):
    rights_lines += [f"execute if score #from ch_ctx matches {home} if score #piece ch_ctx matches {p} run function chess:engine/rights/remove{bit}", f"execute if score #to ch_ctx matches {home} if score #target ch_ctx matches {p} run function chess:engine/rights/remove{bit}"]
put("update_rights", "\n".join(rights_lines) + "\nscoreboard players operation @s ch_castle = #castle ch_ctx")

# 无合法着搜索：几何候选远小于64×64；找到首着立刻终止。
put("has_move", "scoreboard players set #found ch_ctx 0\nscoreboard players set #promo ch_ctx 5\n" + "\n".join(
    f"execute if score #found ch_ctx matches 0 if score #side ch_ctx matches 1 if score #b{i} ch_ctx matches 1..6 run function chess:engine/search/s{i}\n"
    f"execute if score #found ch_ctx matches 0 if score #side ch_ctx matches -1 if score #b{i} ch_ctx matches -6..-1 run function chess:engine/search/s{i}"
    for i in range(64)
) + "\nreturn run scoreboard players get #found ch_ctx")
for start in range(64):
    put(f"search/s{start}", f"scoreboard players set #from ch_ctx {start}\n" + "\n".join(
        f"execute if score #found ch_ctx matches 0 if score #b{start} ch_ctx matches {p} run function chess:engine/search/p{abs(p)}/s{start}"
        for p in [1, 2, 3, 4, 5, 6, -1, -2, -3, -4, -5, -6]
    ))
    for kind in range(1, 7):
        # 先尝试较近格，提高拥挤盘面/残局首着命中率。
        to_list = sorted(candidates(start, kind), key=lambda t: max(abs(t % 8-start % 8), abs(t//8-start//8)))
        put(f"search/p{kind}/s{start}", "\n".join(f"execute if score #found ch_ctx matches 0 run function chess:engine/probe {{to:{to}}}" for to in to_list) or "return 0")
put("probe", """
    $scoreboard players set #to ch_ctx $(to)
    function chess:engine/check_move
    execute if score #legal ch_ctx matches 1 run scoreboard players set #found ch_ctx 1
""")

put("evaluate", """
    # 将死优先于第75回合和重复。不会改真实棋格、行棋方、历史或时钟。
    function chess:system/context
    function chess:engine/cache
    scoreboard players set @s ch_result 0
    scoreboard players set @s ch_reason 0
    execute unless score #cache_ok ch_ctx matches 1 run return run function chess:engine/invalid_board
    scoreboard players operation #attack_sq ch_ctx = #wking ch_ctx
    execute if score #side ch_ctx matches -1 run scoreboard players operation #attack_sq ch_ctx = #bking ch_ctx
    scoreboard players operation #attacker ch_ctx = #side ch_ctx
    scoreboard players operation #attacker ch_ctx *= #minus ch_ctx
    function chess:engine/attack
    scoreboard players operation @s ch_check = #attacked ch_ctx
    function chess:engine/has_move
    execute if score #found ch_ctx matches 0 if score @s ch_check matches 1 run function chess:engine/mate
    execute if score #found ch_ctx matches 0 if score @s ch_check matches 0 run function chess:engine/draw {reason:2}
    execute unless score @s ch_result matches 0 run return 1
    function chess:engine/material
    execute if score #dead ch_ctx matches 1 run function chess:engine/draw {reason:3}
    execute unless score @s ch_result matches 0 run return 1
    execute if score @s ch_repetition matches 5.. run function chess:engine/draw {reason:4}
    execute unless score @s ch_result matches 0 run return 1
    execute if score @s ch_half matches 150.. run function chess:engine/draw {reason:5}
    return run scoreboard players get @s ch_result
""")
put("mate", "scoreboard players set @s ch_reason 1\nexecute if score #side ch_ctx matches 1 run scoreboard players set @s ch_result 2\nexecute if score #side ch_ctx matches -1 run scoreboard players set @s ch_result 1")
put("invalid_board", """
    # 数据受损时隔离本桌；禁止沿用上一桌缓存继续下棋。
    scoreboard players set @s ch_result 3
    scoreboard players set @s ch_reason 11
    scoreboard players set @s ch_check 0
    return 3
""")
put("draw", "scoreboard players set @s ch_result 3\n$scoreboard players set @s ch_reason $(reason)")

# FIDE的死局包括封闭兵阵等任意不可达将死局面，纯材料检查不能穷尽。
# 这里精确涵盖王对王、王单马对王、全部象在同色格且无其他子三类。
put("material", """
    scoreboard players set #dead ch_ctx 0
    scoreboard players set #heavy ch_ctx 0
    scoreboard players set #knights ch_ctx 0
    scoreboard players set #bishops_light ch_ctx 0
    scoreboard players set #bishops_dark ch_ctx 0
""" + "\n".join(
    f"execute if score #b{i} ch_ctx matches 1 run scoreboard players add #heavy ch_ctx 1\n"
    f"execute if score #b{i} ch_ctx matches -1 run scoreboard players add #heavy ch_ctx 1\n"
    f"execute if score #b{i} ch_ctx matches 4..5 run scoreboard players add #heavy ch_ctx 1\n"
    f"execute if score #b{i} ch_ctx matches -5..-4 run scoreboard players add #heavy ch_ctx 1\n"
    f"execute if score #b{i} ch_ctx matches 2 run scoreboard players add #knights ch_ctx 1\n"
    f"execute if score #b{i} ch_ctx matches -2 run scoreboard players add #knights ch_ctx 1\n"
    f"execute if score #b{i} ch_ctx matches 3 run scoreboard players add #bishops_{'dark' if (i%8+i//8)%2==0 else 'light'} ch_ctx 1\n"
    f"execute if score #b{i} ch_ctx matches -3 run scoreboard players add #bishops_{'dark' if (i%8+i//8)%2==0 else 'light'} ch_ctx 1"
    for i in range(64)
) + """
    execute unless score #heavy ch_ctx matches 0 run return 0
    execute if score #bishops_light ch_ctx matches 0 if score #bishops_dark ch_ctx matches 0 if score #knights ch_ctx matches ..1 run scoreboard players set #dead ch_ctx 1
    execute if score #knights ch_ctx matches 0 if score #bishops_light ch_ctx matches 0 run scoreboard players set #dead ch_ctx 1
    execute if score #knights ch_ctx matches 0 if score #bishops_dark ch_ctx matches 0 run scoreboard players set #dead ch_ctx 1
    return run scoreboard players get #dead ch_ctx
""")

put("can_mate", """
    # #side指定被检查一方。仅材料能够确定不可能将死时返回0，其余返回1。
    scoreboard players operation #mate_side ch_ctx = #side ch_ctx
    function chess:system/context
    function chess:engine/cache
    scoreboard players operation #side ch_ctx = #mate_side ch_ctx
    scoreboard players set #can_mate ch_ctx 1
    execute unless score #cache_ok ch_ctx matches 1 run return 1
    function chess:engine/material
    scoreboard players set #can_mate ch_ctx 1
    execute if score #dead ch_ctx matches 1 run scoreboard players set #can_mate ch_ctx 0
    scoreboard players set #own_minor ch_ctx 0
    scoreboard players set #own_heavy ch_ctx 0
    scoreboard players set #own_knights ch_ctx 0
    scoreboard players set #opp_support ch_ctx 0
    scoreboard players set #pawns ch_ctx 0
""" + "\n".join(
    f"execute if score #side ch_ctx matches {side} if score #b{i} ch_ctx matches {side} run scoreboard players add #own_heavy ch_ctx 1\n"
    f"execute if score #side ch_ctx matches {side} if score #b{i} ch_ctx matches {('4..5' if side==1 else '-5..-4')} run scoreboard players add #own_heavy ch_ctx 1\n"
    f"execute if score #side ch_ctx matches {side} if score #b{i} ch_ctx matches {('2..3' if side==1 else '-3..-2')} run scoreboard players add #own_minor ch_ctx 1\n"
    f"execute if score #side ch_ctx matches {side} if score #b{i} ch_ctx matches {side*2} run scoreboard players add #own_knights ch_ctx 1\n"
    f"execute if score #side ch_ctx matches {side} if score #b{i} ch_ctx matches {('-4..-1' if side==1 else '1..4')} run scoreboard players add #opp_support ch_ctx 1\n"
    f"execute if score #b{i} ch_ctx matches {side} run scoreboard players add #pawns ch_ctx 1"
    for i in range(64) for side in (1, -1)
) + """
    execute if score #own_minor ch_ctx matches 0 if score #own_heavy ch_ctx matches 0 run scoreboard players set #can_mate ch_ctx 0
    # 对方的后不能帮助单马完成合作将死；兵/马/象/车则可能帮助封死逃格。
    execute if score #own_heavy ch_ctx matches 0 if score #own_minor ch_ctx matches 1 if score #own_knights ch_ctx matches 1 if score #opp_support ch_ctx matches 0 run scoreboard players set #can_mate ch_ctx 0
    # 单色格象（可有多枚）对仅王/车/后/同色格象也无法将死。
    execute if score #own_heavy ch_ctx matches 0 if score #own_knights ch_ctx matches 0 if score #pawns ch_ctx matches 0 if score #knights ch_ctx matches 0 if score #bishops_light ch_ctx matches 0 run scoreboard players set #can_mate ch_ctx 0
    execute if score #own_heavy ch_ctx matches 0 if score #own_knights ch_ctx matches 0 if score #pawns ch_ctx matches 0 if score #knights ch_ctx matches 0 if score #bishops_dark ch_ctx matches 0 run scoreboard players set #can_mate ch_ctx 0
    return run scoreboard players get #can_mate ch_ctx
""")

# 历史键完整包含64格、轮到谁、易位权和实际合法可用的吃过路目标；不使用概率哈希。
put("history/prune", """
    # 动兵、吃子、失去易位权均不可逆；此前局面不可能重现，避免长局NBT无限增长。
    # 走子前的完整历史已由game/snapshot保存在悔棋快照，本函数不修改该快照。
    scoreboard players set #irreversible ch_ctx 0
    execute if score #kind ch_ctx matches 1 run scoreboard players set #irreversible ch_ctx 1
    execute unless score #captured ch_ctx matches 0 run scoreboard players set #irreversible ch_ctx 1
    execute unless score #castle ch_ctx = #old_castle ch_ctx run scoreboard players set #irreversible ch_ctx 1
    execute if score #irreversible ch_ctx matches 1 run data modify entity @s data.chess.history set value []
""")
put("history/record", """
    scoreboard players set #effective_ep ch_ctx -1
    execute if score #ep ch_ctx matches 0..63 run function chess:engine/history/ep
    data modify storage chess:engine history set value {key:"",piece:0,turn:1,castle:0,ep:-1}
""" + "\n".join(f"execute store result storage chess:engine history.piece int 1 run scoreboard players get #b{i} ch_ctx\nfunction chess:engine/history/append with storage chess:engine history" for i in range(64)) + """
    execute store result storage chess:engine history.turn int 1 run scoreboard players get #side ch_ctx
    execute store result storage chess:engine history.castle int 1 run scoreboard players get #castle ch_ctx
    execute store result storage chess:engine history.ep int 1 run scoreboard players get #effective_ep ch_ctx
    function chess:engine/history/key with storage chess:engine history
    function chess:engine/history/count with storage chess:engine history
""")
put("history/append", '$data modify storage chess:engine history.key set value "$(key)$(piece),"')
put("history/key", '$data modify storage chess:engine history.key set value "$(key)/$(turn)/$(castle)/$(ep)"')
put("history/count", """
    scoreboard players set #rep ch_ctx 0
    $execute if data entity @s data.chess.history[{key:"$(key)"}] store result score #rep ch_ctx run data get entity @s data.chess.history[{key:"$(key)"}].count
    scoreboard players add #rep ch_ctx 1
    $execute unless data entity @s data.chess.history[{key:"$(key)"}] run data modify entity @s data.chess.history append value {key:"$(key)",count:0}
    $execute store result entity @s data.chess.history[{key:"$(key)"}].count int 1 run scoreboard players get #rep ch_ctx
    scoreboard players operation @s ch_repetition = #rep ch_ctx
""")
put("history/ep", """
    # 吃过路只有确实存在合法走法时才影响重复局面的同一性（包括被钉住情形）。
    scoreboard players set #promo ch_ctx 5
    scoreboard players set #found ch_ctx 0
""" + "\n".join(
    f"execute if score #found ch_ctx matches 0 if score #side ch_ctx matches {side} if score #ep ch_ctx matches {to} if score #b{start} ch_ctx matches {side} run function chess:engine/history/ep_probe {{from:{start},to:{to}}}"
    for side in (1, -1) for to in (range(40, 48) if side == 1 else range(16, 24))
    for start in (to-side*8-1, to-side*8+1)
    if 0 <= start < 64 and abs(start%8-to%8) == 1
) + "\nexecute if score #found ch_ctx matches 1 run scoreboard players operation #effective_ep ch_ctx = #ep ch_ctx")
put("history/ep_probe", """
    $scoreboard players set #from ch_ctx $(from)
    $scoreboard players set #to ch_ctx $(to)
    function chess:engine/check_move
    execute if score #legal ch_ctx matches 1 run scoreboard players set #found ch_ctx 1
""")

print(f"Generated {len(list(ROOT.rglob('*.mcfunction')))} chess engine functions.")
