execute store result score #passed ma_ctx run data get storage magical_athlete:engine job.before[0]
$execute if score #s0 ma_ctx matches 0 unless score #mover ma_ctx matches 0 if score #from ma_ctx < #passed ma_ctx if score #to ma_ctx > #passed ma_ctx run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":0,"amount":-2,"source":4,"author":$(reactor)}
execute store result score #passed ma_ctx run data get storage magical_athlete:engine job.before[1]
$execute if score #s1 ma_ctx matches 0 unless score #mover ma_ctx matches 1 if score #from ma_ctx < #passed ma_ctx if score #to ma_ctx > #passed ma_ctx run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":1,"amount":-2,"source":4,"author":$(reactor)}
execute store result score #passed ma_ctx run data get storage magical_athlete:engine job.before[2]
$execute if score #s2 ma_ctx matches 0 unless score #mover ma_ctx matches 2 if score #from ma_ctx < #passed ma_ctx if score #to ma_ctx > #passed ma_ctx run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":2,"amount":-2,"source":4,"author":$(reactor)}
execute store result score #passed ma_ctx run data get storage magical_athlete:engine job.before[3]
$execute if score #s3 ma_ctx matches 0 unless score #mover ma_ctx matches 3 if score #from ma_ctx < #passed ma_ctx if score #to ma_ctx > #passed ma_ctx run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":3,"amount":-2,"source":4,"author":$(reactor)}
execute store result score #passed ma_ctx run data get storage magical_athlete:engine job.before[4]
$execute if score #s4 ma_ctx matches 0 unless score #mover ma_ctx matches 4 if score #from ma_ctx < #passed ma_ctx if score #to ma_ctx > #passed ma_ctx run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":4,"amount":-2,"source":4,"author":$(reactor)}
execute store result score #passed ma_ctx run data get storage magical_athlete:engine job.before[5]
$execute if score #s5 ma_ctx matches 0 unless score #mover ma_ctx matches 5 if score #from ma_ctx < #passed ma_ctx if score #to ma_ctx > #passed ma_ctx run data modify storage magical_athlete:engine s.queue prepend value {"type":"move","pawn":5,"amount":-2,"source":4,"author":$(reactor)}
