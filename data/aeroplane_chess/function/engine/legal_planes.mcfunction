function aeroplane_chess:system/context
scoreboard players operation #color ac_ctx = @s ac_turn
scoreboard players set @e[tag=ac.board] ac_legal 0
scoreboard players set #available ac_ctx 0
function aeroplane_chess:engine/legal_one {plane:0}
function aeroplane_chess:engine/legal_one {plane:1}
function aeroplane_chess:engine/legal_one {plane:2}
function aeroplane_chess:engine/legal_one {plane:3}
function aeroplane_chess:visual/select
