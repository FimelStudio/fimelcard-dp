$data modify storage liars_holdem:showdown line set value [{selector:"@a[tag=lh.player,scores={lh_id=$(table),lh_seat=$(seat)}]",color:"yellow",bold:true},{text:"　"}]
$data modify storage liars_holdem:showdown chat set value [{selector:"@a[tag=lh.player,scores={lh_id=$(table),lh_seat=$(seat)}]",color:"gold",bold:true},{text:"：",color:"gray"}]
