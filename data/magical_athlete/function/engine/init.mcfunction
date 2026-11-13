execute unless score #players ma_ctx matches 2..6 run return run function magical_athlete:engine/error {id:2}
data modify storage magical_athlete:engine s set value {"version":1,"n":0,"phase":1,"epoch":1,"round":1,"track":0,"turn":1,"pawn":-1,"active":-1,"start_pos":0,"next_override":-1,"extra":-1,"forced":-1,"dice":0,"rerolls":0,"merchant":0,"prediction":0,"bomb":0,"skip":0,"pre_done":0,"draft_mode":0,"track_mode":0,"draft_batch":1,"draft_at":0,"draft_first":1,"draft_order":[],"pool":[],"deck":[],"racers":[{"owner":0,"char":-1,"power":-1,"copy":-1,"pos":0,"trip":0,"status":2,"first":1,"prediction":-1,"done":0},{"owner":0,"char":-1,"power":-1,"copy":-1,"pos":0,"trip":0,"status":2,"first":1,"prediction":-1,"done":0},{"owner":0,"char":-1,"power":-1,"copy":-1,"pos":0,"trip":0,"status":2,"first":1,"prediction":-1,"done":0},{"owner":0,"char":-1,"power":-1,"copy":-1,"pos":0,"trip":0,"status":2,"first":1,"prediction":-1,"done":0},{"owner":0,"char":-1,"power":-1,"copy":-1,"pos":0,"trip":0,"status":2,"first":1,"prediction":-1,"done":0},{"owner":0,"char":-1,"power":-1,"copy":-1,"pos":0,"trip":0,"status":2,"first":1,"prediction":-1,"done":0}],"pending":{"kind":"","owner":0,"pawn":-1,"options":[]},"queue":[],"events":[],"seen":[],"finishers":[],"history":[],"eliminated":[],"winners":[],"ticks":0,"loop":0,"copy_locks":[0,0,0,0,0,0],"p1":{"hand":[],"selected":[],"points":0,"race_points":0},"p2":{"hand":[],"selected":[],"points":0,"race_points":0},"p3":{"hand":[],"selected":[],"points":0,"race_points":0},"p4":{"hand":[],"selected":[],"points":0,"race_points":0},"p5":{"hand":[],"selected":[],"points":0,"race_points":0},"p6":{"hand":[],"selected":[],"points":0,"race_points":0}}
execute store result storage magical_athlete:engine s.n int 1 run scoreboard players get #players ma_ctx
scoreboard players set #draft ma_ctx 0
scoreboard players set #track ma_ctx 0
execute store result score #draft ma_ctx run scoreboard players get @s ma_draft
execute store result score #track ma_ctx run scoreboard players get @s ma_track
execute store result storage magical_athlete:engine s.draft_mode int 1 run scoreboard players get #draft ma_ctx
execute store result storage magical_athlete:engine s.track_mode int 1 run scoreboard players get #track ma_ctx
function magical_athlete:engine/shuffle
function magical_athlete:engine/rolloff
execute store result storage magical_athlete:engine s.draft_first int 1 run scoreboard players get #winner ma_ctx
function magical_athlete:engine/draft/init
function magical_athlete:engine/commit
execute if data storage magical_athlete:engine s{track_mode:2} run data modify entity @s data.magical_athlete.track set value 1
