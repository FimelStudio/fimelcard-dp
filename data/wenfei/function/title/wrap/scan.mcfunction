data modify storage wenfei:wrap character set string storage wenfei:wrap remaining 0 1
data modify storage wenfei:wrap remaining set string storage wenfei:wrap remaining 1
execute if data storage wenfei:wrap {character:"\n"} run data modify storage wenfei:wrap character set value " "
execute unless data storage wenfei:wrap {character:"\r"} run function wenfei:title/wrap/character
execute unless data storage wenfei:wrap {remaining:""} run function wenfei:title/wrap/scan
