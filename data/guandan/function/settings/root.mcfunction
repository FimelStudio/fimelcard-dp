data modify storage guandan:settings pair_row set value {"text":"搭档分配\n","color":"white","extra":[]}
function guandan:settings/choice {"key":"pair","value":0,"code":1000,"label":"按座位自选"}
function guandan:settings/choice {"key":"pair","value":1,"code":1001,"label":"随机分队"}
data modify storage guandan:settings startlevel_row set value {"text":"起始级牌\n","color":"white","extra":[]}
function guandan:settings/choice {"key":"startlevel","value":2,"code":2002,"label":"2"}
function guandan:settings/choice {"key":"startlevel","value":3,"code":2003,"label":"3"}
function guandan:settings/choice {"key":"startlevel","value":4,"code":2004,"label":"4"}
function guandan:settings/choice {"key":"startlevel","value":5,"code":2005,"label":"5"}
function guandan:settings/choice {"key":"startlevel","value":6,"code":2006,"label":"6"}
function guandan:settings/choice {"key":"startlevel","value":7,"code":2007,"label":"7"}
function guandan:settings/choice {"key":"startlevel","value":8,"code":2008,"label":"8"}
function guandan:settings/choice {"key":"startlevel","value":9,"code":2009,"label":"9"}
function guandan:settings/choice {"key":"startlevel","value":10,"code":2010,"label":"10"}
function guandan:settings/choice {"key":"startlevel","value":11,"code":2011,"label":"J"}
function guandan:settings/choice {"key":"startlevel","value":12,"code":2012,"label":"Q"}
function guandan:settings/choice {"key":"startlevel","value":13,"code":2013,"label":"K"}
function guandan:settings/choice {"key":"startlevel","value":14,"code":2014,"label":"A"}
data modify storage guandan:settings mode_row set value {"text":"比赛模式\n","color":"white","extra":[]}
function guandan:settings/choice {"key":"mode","value":0,"code":3000,"label":"完整升级赛"}
function guandan:settings/choice {"key":"mode","value":1,"code":3001,"label":"固定副数"}
data modify storage guandan:settings rounds_row set value {"text":"固定副数\n","color":"white","extra":[]}
function guandan:settings/choice {"key":"rounds","value":1,"code":4001,"label":"1副"}
function guandan:settings/choice {"key":"rounds","value":2,"code":4002,"label":"2副"}
function guandan:settings/choice {"key":"rounds","value":3,"code":4003,"label":"3副"}
function guandan:settings/choice {"key":"rounds","value":5,"code":4005,"label":"5副"}
function guandan:settings/choice {"key":"rounds","value":8,"code":4008,"label":"8副"}
function guandan:settings/choice {"key":"rounds","value":10,"code":4010,"label":"10副"}
function guandan:settings/choice {"key":"rounds","value":16,"code":4016,"label":"16副"}
function guandan:settings/choice {"key":"rounds","value":32,"code":4032,"label":"32副"}
data modify storage guandan:settings show_row set value {"text":"显示其他玩家余牌数\n","color":"white","extra":[]}
function guandan:settings/choice {"key":"show","value":1,"code":5001,"label":"开启"}
function guandan:settings/choice {"key":"show","value":0,"code":5000,"label":"关闭"}
data modify storage guandan:settings limit_row set value {"text":"每步操作时限\n","color":"white","extra":[]}
function guandan:settings/choice {"key":"limit","value":0,"code":6000,"label":"无限制"}
function guandan:settings/choice {"key":"limit","value":30,"code":6030,"label":"30秒"}
function guandan:settings/choice {"key":"limit","value":60,"code":6060,"label":"60秒"}
function guandan:settings/choice {"key":"limit","value":90,"code":6090,"label":"90秒"}
function guandan:settings/choice {"key":"limit","value":120,"code":6120,"label":"120秒"}
function guandan:settings/show with storage guandan:settings
