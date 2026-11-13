$execute if score #variant xq_ctx matches 1 run return run data modify storage xiangqi:engine history.key set value "$(key)$(piece):$(covered),"
$data modify storage xiangqi:engine history.key set value "$(key)$(piece),"
