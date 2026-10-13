
data modify storage fimel_sklibs:arrays temp.ioDatatype set value []
$data modify storage fimel_sklibs:arrays temp.ioDatatype append value $(format)
$execute store success score $(output) run data modify storage fimel_sklibs:arrays temp.ioDatatype append from $(input)