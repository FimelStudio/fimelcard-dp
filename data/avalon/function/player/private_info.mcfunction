# Called with av.audience already scoped to the current table. Only the executing player receives the title.
tag @a[tag=av.info_viewer] remove av.info_viewer
tag @s add av.info_viewer
tag @a[tag=av.info_oberon] remove av.info_oberon
tag @a[tag=av.audience,scores={av_role=6}] add av.info_oberon
tag @a[tag=av.info_pair] remove av.info_pair
tag @a[tag=av.audience,scores={av_role=1}] add av.info_pair
tag @a[tag=av.audience,scores={av_role=4}] add av.info_pair
execute if score @s av_role matches 1 run title @s actionbar [{text:"梅林｜坏人：",color:"aqua"},{selector:"@a[tag=av.audience,scores={av_role=4..7}]",separator:{text:"、"},color:"red"}]
execute if score @s av_role matches 2 run title @s actionbar [{text:"派西维尔｜梅林 / 莫甘娜：",color:"aqua"},{selector:"@a[tag=av.audience,tag=av.info_pair]",separator:{text:"、"},color:"yellow"},{text:"（无法区分）",color:"gray"}]
execute if score @s av_role matches 3 run title @s actionbar {text:"忠臣｜好人阵营 · 无额外身份情报",color:"green"}
execute if score @s av_role matches 4 run title @s actionbar [{text:"莫甘娜｜队友：",color:"red"},{selector:"@a[tag=av.audience,tag=!av.info_viewer,scores={av_role=4..7},tag=!av.info_oberon]",separator:{text:"、"},color:"gold"}]
execute if score @s av_role matches 5 run title @s actionbar [{text:"刺客｜队友：",color:"red"},{selector:"@a[tag=av.audience,tag=!av.info_viewer,scores={av_role=4..7},tag=!av.info_oberon]",separator:{text:"、"},color:"gold"}]
execute if score @s av_role matches 6 run title @s actionbar {text:"奥伯伦｜坏人阵营 · 与其他坏人互不相认",color:"red"}
execute if score @s av_role matches 7 run title @s actionbar [{text:"爪牙｜队友：",color:"red"},{selector:"@a[tag=av.audience,tag=!av.info_viewer,scores={av_role=4..7},tag=!av.info_oberon]",separator:{text:"、"},color:"gold"}]
tag @s remove av.info_viewer
tag @a[tag=av.info_pair] remove av.info_pair

tag @a[tag=av.info_oberon] remove av.info_oberon
