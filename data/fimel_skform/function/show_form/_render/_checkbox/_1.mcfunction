
$data modify storage fimel_skform:runtime temp.i.text set from storage fimel_skform:runtime temp.i.values[$(index)]

$execute store result score fimel.skform.i_storage fcs_lib run data get storage fimel_skform:runtime temp.storage.$(key)[$(index)]


