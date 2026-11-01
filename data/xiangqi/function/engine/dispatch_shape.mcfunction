$execute if score #variant xq_ctx matches 1 if score #covered xq_ctx matches 0 if score #kind xq_ctx matches 3 run return run function xiangqi:engine/revealed/side$(side)/p3/s$(from)
$execute if score #variant xq_ctx matches 1 if score #covered xq_ctx matches 0 if score #kind xq_ctx matches 7 run return run function xiangqi:engine/revealed/side$(side)/p7/s$(from)
$function xiangqi:engine/shape/side$(side)/p$(kind)/s$(from)
