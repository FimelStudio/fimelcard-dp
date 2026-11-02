$execute if score #node_length ca_ctx matches 1.. unless score #vo$(vertex) ca_ctx matches 0 unless score #vo$(vertex) ca_ctx = #jp ca_ctx run return 0
execute if score #node_length ca_ctx matches 15.. run return 0
$function catan:engine/job/expand_v$(vertex)
