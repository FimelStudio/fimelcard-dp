execute store result storage skull:ui bid.current int 1 run scoreboard players get @s sk_bid
execute store result storage skull:ui bid.total int 1 run scoreboard players get @s sk_total
function skull:ui/bid_info with storage skull:ui bid
function skull:ui/bid_button {number:1,choice:11}
function skull:ui/bid_button {number:2,choice:12}
function skull:ui/bid_button {number:3,choice:13}
function skull:ui/bid_button {number:4,choice:14}
function skull:ui/bid_button {number:5,choice:15}
function skull:ui/bid_button {number:6,choice:16}
function skull:ui/bid_button {number:7,choice:17}
function skull:ui/bid_button {number:8,choice:18}
function skull:ui/bid_button {number:9,choice:19}
function skull:ui/bid_button {number:10,choice:20}
function skull:ui/bid_button {number:11,choice:21}
function skull:ui/bid_button {number:12,choice:22}
function skull:ui/bid_button {number:13,choice:23}
function skull:ui/bid_button {number:14,choice:24}
function skull:ui/bid_button {number:15,choice:25}
function skull:ui/bid_button {number:16,choice:26}
function skull:ui/bid_button {number:17,choice:27}
function skull:ui/bid_button {number:18,choice:28}
function skull:ui/bid_button {number:19,choice:29}
function skull:ui/bid_button {number:20,choice:70}
function skull:ui/bid_button {number:21,choice:71}
function skull:ui/bid_button {number:22,choice:72}
function skull:ui/bid_button {number:23,choice:73}
function skull:ui/bid_button {number:24,choice:74}
execute if score @s sk_state matches 3 run function skull:ui/button {choice:30,label:"放弃竞标"}
