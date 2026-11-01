data modify storage love_letter:settings first_row set value {"text":"首轮先手\n","color":"white","extra":[]}
function love_letter:settings/choice {"key":"first","value":0,"code":1000,"label":"随机"}
function love_letter:settings/choice {"key":"first","value":1,"code":1001,"label":"最小座号"}
data modify storage love_letter:settings goal_row set value {"text":"获胜好感标记\n","color":"white","extra":[]}
function love_letter:settings/choice {"key":"goal","value":0,"code":2000,"label":"自动"}
function love_letter:settings/choice {"key":"goal","value":1,"code":2001,"label":"1"}
function love_letter:settings/choice {"key":"goal","value":2,"code":2002,"label":"2"}
function love_letter:settings/choice {"key":"goal","value":3,"code":2003,"label":"3"}
function love_letter:settings/choice {"key":"goal","value":4,"code":2004,"label":"4"}
function love_letter:settings/choice {"key":"goal","value":5,"code":2005,"label":"5"}
function love_letter:settings/choice {"key":"goal","value":6,"code":2006,"label":"6"}
function love_letter:settings/choice {"key":"goal","value":7,"code":2007,"label":"7"}
function love_letter:settings/choice {"key":"goal","value":8,"code":2008,"label":"8"}
function love_letter:settings/choice {"key":"goal","value":9,"code":2009,"label":"9"}
function love_letter:settings/choice {"key":"goal","value":10,"code":2010,"label":"10"}
data modify storage love_letter:settings discards_row set value {"text":"公开弃牌文字提示\n","color":"white","extra":[]}
function love_letter:settings/choice {"key":"discards","value":1,"code":3001,"label":"开启"}
function love_letter:settings/choice {"key":"discards","value":0,"code":3000,"label":"关闭"}
data modify storage love_letter:settings time_row set value {"text":"每步操作时限\n","color":"white","extra":[]}
function love_letter:settings/choice {"key":"time","value":0,"code":4000,"label":"无限制"}
function love_letter:settings/choice {"key":"time","value":30,"code":4030,"label":"30秒"}
function love_letter:settings/choice {"key":"time","value":60,"code":4060,"label":"60秒"}
function love_letter:settings/choice {"key":"time","value":90,"code":4090,"label":"90秒"}
function love_letter:settings/choice {"key":"time","value":120,"code":4120,"label":"120秒"}
function love_letter:settings/show with storage love_letter:settings
