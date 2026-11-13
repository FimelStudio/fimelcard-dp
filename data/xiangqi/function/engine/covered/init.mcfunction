# 每方十五子独立不放回随机；将帅始终明置，不写入公共展示数据。
data modify storage xiangqi:private bag set value [1,1,1,1,1,2,2,3,3,4,4,5,5,7,7]
function xiangqi:engine/covered/draw {sq:0,max:14}
function xiangqi:engine/covered/draw {sq:1,max:13}
function xiangqi:engine/covered/draw {sq:2,max:12}
function xiangqi:engine/covered/draw {sq:3,max:11}
function xiangqi:engine/covered/draw {sq:5,max:10}
function xiangqi:engine/covered/draw {sq:6,max:9}
function xiangqi:engine/covered/draw {sq:7,max:8}
function xiangqi:engine/covered/draw {sq:8,max:7}
function xiangqi:engine/covered/draw {sq:19,max:6}
function xiangqi:engine/covered/draw {sq:25,max:5}
function xiangqi:engine/covered/draw {sq:27,max:4}
function xiangqi:engine/covered/draw {sq:29,max:3}
function xiangqi:engine/covered/draw {sq:31,max:2}
function xiangqi:engine/covered/draw {sq:33,max:1}
function xiangqi:engine/covered/draw {sq:35,max:0}
data modify storage xiangqi:private bag set value [-1,-1,-1,-1,-1,-2,-2,-3,-3,-4,-4,-5,-5,-7,-7]
function xiangqi:engine/covered/draw {sq:54,max:14}
function xiangqi:engine/covered/draw {sq:56,max:13}
function xiangqi:engine/covered/draw {sq:58,max:12}
function xiangqi:engine/covered/draw {sq:60,max:11}
function xiangqi:engine/covered/draw {sq:62,max:10}
function xiangqi:engine/covered/draw {sq:64,max:9}
function xiangqi:engine/covered/draw {sq:70,max:8}
function xiangqi:engine/covered/draw {sq:81,max:7}
function xiangqi:engine/covered/draw {sq:82,max:6}
function xiangqi:engine/covered/draw {sq:83,max:5}
function xiangqi:engine/covered/draw {sq:84,max:4}
function xiangqi:engine/covered/draw {sq:86,max:3}
function xiangqi:engine/covered/draw {sq:87,max:2}
function xiangqi:engine/covered/draw {sq:88,max:1}
function xiangqi:engine/covered/draw {sq:89,max:0}
data remove storage xiangqi:private bag
data remove storage xiangqi:private pick
