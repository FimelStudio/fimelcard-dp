data modify storage splendor:settings first_row set value {"text":"行动顺序：","color":"gray","extra":[]}
function splendor:settings/choice {"key":"first","value":0,"code":100,"label":"按座位"}
function splendor:settings/choice {"key":"first","value":1,"code":101,"label":"随机"}
data modify storage splendor:settings music_row set value {"text":"背景音乐：","color":"gray","extra":[]}
function splendor:settings/choice {"key":"music","value":0,"code":200,"label":"关闭"}
function splendor:settings/choice {"key":"music","value":1,"code":201,"label":"开启"}
function splendor:settings/root_show with storage splendor:settings
