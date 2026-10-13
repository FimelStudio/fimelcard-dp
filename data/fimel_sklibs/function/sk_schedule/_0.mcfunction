
$data modify storage fimel_sklibs:runtime sk_sche.event[{time:$(target_time)}].cmd append from storage fimel_sklibs:runtime sk_sche.args1.cmd

$schedule function fimel_sklibs:sk_schedule/_1 $(delay_time)t append