function avalon:name/resolve
execute if score @s av_seat = #leader av_ctx run data modify storage avalon:names leader set from storage avalon:name resolved
execute if score @s av_selected matches 1 run data modify storage avalon:names team append from storage avalon:name resolved
execute if score @s av_selected matches 1 run data modify storage avalon:names team append value {text:" "}
execute if score @s av_role matches 4..7 run data modify storage avalon:names evil append from storage avalon:name resolved
execute if score @s av_role matches 4..7 run data modify storage avalon:names evil append value {text:" "}
execute if score @s av_role matches 1 run data modify storage avalon:names pair append from storage avalon:name resolved
execute if score @s av_role matches 1 run data modify storage avalon:names pair append value {text:" "}
execute if score @s av_role matches 4 run data modify storage avalon:names pair append from storage avalon:name resolved
execute if score @s av_role matches 4 run data modify storage avalon:names pair append value {text:" "}
execute if score @s av_role matches 4..7 unless score @s av_role matches 6 run data modify storage avalon:names known append from storage avalon:name resolved
execute if score @s av_role matches 4..7 unless score @s av_role matches 6 run data modify storage avalon:names known append value {text:" "}
execute if score @s av_seat = #target av_ctx run data modify storage avalon:names target set from storage avalon:name resolved
