function aeroplane_chess:system/context
kill @e[tag=ac.board]
kill @e[tag=ac.sides]
execute summon minecraft:marker run function aeroplane_chess:engine/side {color:0}
execute summon minecraft:marker run function aeroplane_chess:engine/side {color:1}
execute summon minecraft:marker run function aeroplane_chess:engine/side {color:2}
execute summon minecraft:marker run function aeroplane_chess:engine/side {color:3}
execute summon minecraft:marker run function aeroplane_chess:engine/plane {color:0,plane:0}
execute summon minecraft:marker run function aeroplane_chess:engine/plane {color:0,plane:1}
execute summon minecraft:marker run function aeroplane_chess:engine/plane {color:0,plane:2}
execute summon minecraft:marker run function aeroplane_chess:engine/plane {color:0,plane:3}
execute summon minecraft:marker run function aeroplane_chess:engine/plane {color:1,plane:0}
execute summon minecraft:marker run function aeroplane_chess:engine/plane {color:1,plane:1}
execute summon minecraft:marker run function aeroplane_chess:engine/plane {color:1,plane:2}
execute summon minecraft:marker run function aeroplane_chess:engine/plane {color:1,plane:3}
execute summon minecraft:marker run function aeroplane_chess:engine/plane {color:2,plane:0}
execute summon minecraft:marker run function aeroplane_chess:engine/plane {color:2,plane:1}
execute summon minecraft:marker run function aeroplane_chess:engine/plane {color:2,plane:2}
execute summon minecraft:marker run function aeroplane_chess:engine/plane {color:2,plane:3}
execute summon minecraft:marker run function aeroplane_chess:engine/plane {color:3,plane:0}
execute summon minecraft:marker run function aeroplane_chess:engine/plane {color:3,plane:1}
execute summon minecraft:marker run function aeroplane_chess:engine/plane {color:3,plane:2}
execute summon minecraft:marker run function aeroplane_chess:engine/plane {color:3,plane:3}
function aeroplane_chess:system/context
