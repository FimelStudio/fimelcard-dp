data modify storage magical_athlete:engine s.phase set value 3
data modify storage magical_athlete:engine s.queue set value []
data modify storage magical_athlete:engine s.finishers set value []
data modify storage magical_athlete:engine s.eliminated set value []
data modify storage magical_athlete:engine s.seen set value []
data modify storage magical_athlete:engine s.active set value -1
data modify storage magical_athlete:engine s.pawn set value -1
data modify storage magical_athlete:engine s.forced set value -1
data modify storage magical_athlete:engine s.next_override set value -1
data modify storage magical_athlete:engine s.extra set value -1
data modify storage magical_athlete:engine s.p1.race_points set value 0
data modify storage magical_athlete:engine s.p2.race_points set value 0
data modify storage magical_athlete:engine s.p3.race_points set value 0
data modify storage magical_athlete:engine s.p4.race_points set value 0
data modify storage magical_athlete:engine s.p5.race_points set value 0
data modify storage magical_athlete:engine s.p6.race_points set value 0
data modify storage magical_athlete:engine s.racers[0] set value {"owner":1,"char":-1,"power":-1,"copy":-1,"pos":0,"trip":0,"status":2,"first":1,"prediction":-1,"done":0}
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 1.. run data modify storage magical_athlete:engine s.racers[0].status set value 0
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 1.. run data modify storage magical_athlete:engine s.racers[0].char set from storage magical_athlete:engine s.p1.selected[0]
execute if score #n ma_ctx matches 2 run data modify storage magical_athlete:engine s.racers[0].owner set value 1
execute if score #n ma_ctx matches 2 run data modify storage magical_athlete:engine s.racers[0].status set value 0
execute if score #n ma_ctx matches 2 run data modify storage magical_athlete:engine s.racers[0].char set from storage magical_athlete:engine s.p1.selected[0]
data modify storage magical_athlete:engine s.racers[0].power set from storage magical_athlete:engine s.racers[0].char
data modify storage magical_athlete:engine s.queue append value {"type":"prerace","pawn":0}
data modify storage magical_athlete:engine s.racers[1] set value {"owner":2,"char":-1,"power":-1,"copy":-1,"pos":0,"trip":0,"status":2,"first":1,"prediction":-1,"done":0}
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 2.. run data modify storage magical_athlete:engine s.racers[1].status set value 0
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 2.. run data modify storage magical_athlete:engine s.racers[1].char set from storage magical_athlete:engine s.p2.selected[0]
execute if score #n ma_ctx matches 2 run data modify storage magical_athlete:engine s.racers[1].owner set value 1
execute if score #n ma_ctx matches 2 run data modify storage magical_athlete:engine s.racers[1].status set value 0
execute if score #n ma_ctx matches 2 run data modify storage magical_athlete:engine s.racers[1].char set from storage magical_athlete:engine s.p1.selected[1]
data modify storage magical_athlete:engine s.racers[1].power set from storage magical_athlete:engine s.racers[1].char
data modify storage magical_athlete:engine s.queue append value {"type":"prerace","pawn":1}
data modify storage magical_athlete:engine s.racers[2] set value {"owner":3,"char":-1,"power":-1,"copy":-1,"pos":0,"trip":0,"status":2,"first":1,"prediction":-1,"done":0}
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 3.. run data modify storage magical_athlete:engine s.racers[2].status set value 0
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 3.. run data modify storage magical_athlete:engine s.racers[2].char set from storage magical_athlete:engine s.p3.selected[0]
execute if score #n ma_ctx matches 2 run data modify storage magical_athlete:engine s.racers[2].owner set value 2
execute if score #n ma_ctx matches 2 run data modify storage magical_athlete:engine s.racers[2].status set value 0
execute if score #n ma_ctx matches 2 run data modify storage magical_athlete:engine s.racers[2].char set from storage magical_athlete:engine s.p2.selected[0]
data modify storage magical_athlete:engine s.racers[2].power set from storage magical_athlete:engine s.racers[2].char
data modify storage magical_athlete:engine s.queue append value {"type":"prerace","pawn":2}
data modify storage magical_athlete:engine s.racers[3] set value {"owner":4,"char":-1,"power":-1,"copy":-1,"pos":0,"trip":0,"status":2,"first":1,"prediction":-1,"done":0}
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 4.. run data modify storage magical_athlete:engine s.racers[3].status set value 0
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 4.. run data modify storage magical_athlete:engine s.racers[3].char set from storage magical_athlete:engine s.p4.selected[0]
execute if score #n ma_ctx matches 2 run data modify storage magical_athlete:engine s.racers[3].owner set value 2
execute if score #n ma_ctx matches 2 run data modify storage magical_athlete:engine s.racers[3].status set value 0
execute if score #n ma_ctx matches 2 run data modify storage magical_athlete:engine s.racers[3].char set from storage magical_athlete:engine s.p2.selected[1]
data modify storage magical_athlete:engine s.racers[3].power set from storage magical_athlete:engine s.racers[3].char
data modify storage magical_athlete:engine s.queue append value {"type":"prerace","pawn":3}
data modify storage magical_athlete:engine s.racers[4] set value {"owner":5,"char":-1,"power":-1,"copy":-1,"pos":0,"trip":0,"status":2,"first":1,"prediction":-1,"done":0}
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 5.. run data modify storage magical_athlete:engine s.racers[4].status set value 0
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 5.. run data modify storage magical_athlete:engine s.racers[4].char set from storage magical_athlete:engine s.p5.selected[0]
data modify storage magical_athlete:engine s.racers[4].power set from storage magical_athlete:engine s.racers[4].char
data modify storage magical_athlete:engine s.queue append value {"type":"prerace","pawn":4}
data modify storage magical_athlete:engine s.racers[5] set value {"owner":6,"char":-1,"power":-1,"copy":-1,"pos":0,"trip":0,"status":2,"first":1,"prediction":-1,"done":0}
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 6.. run data modify storage magical_athlete:engine s.racers[5].status set value 0
execute if score #n ma_ctx matches 3.. if score #n ma_ctx matches 6.. run data modify storage magical_athlete:engine s.racers[5].char set from storage magical_athlete:engine s.p6.selected[0]
data modify storage magical_athlete:engine s.racers[5].power set from storage magical_athlete:engine s.racers[5].char
data modify storage magical_athlete:engine s.queue append value {"type":"prerace","pawn":5}
