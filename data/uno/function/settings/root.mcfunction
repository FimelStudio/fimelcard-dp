data modify storage uno:settings mode_row set value {"text":"比赛模式\n","color":"white","extra":[]}
function uno:settings/choice {"key":"mode","row":"mode_row","value":0,"code":1000,"label":"单局"}
function uno:settings/choice {"key":"mode","row":"mode_row","value":1,"code":1001,"label":"固定局数"}
function uno:settings/choice {"key":"mode","row":"mode_row","value":2,"code":1002,"label":"目标积分"}
data modify storage uno:settings rounds_row set value {"text":"固定局数（固定局数积分赛）\n","color":"white","extra":[]}
function uno:settings/step {"key":"rounds","row":"rounds_row","offset":2000,"delta":-5,"min":1,"max":32,"label":"−5"}
function uno:settings/step {"key":"rounds","row":"rounds_row","offset":2000,"delta":-1,"min":1,"max":32,"label":"−1"}
$data modify storage uno:settings rounds_row.extra append value {"text":"  $(rounds) 局  ","color":"gold","bold":true}
function uno:settings/step {"key":"rounds","row":"rounds_row","offset":2000,"delta":1,"min":1,"max":32,"label":"+1"}
function uno:settings/step {"key":"rounds","row":"rounds_row","offset":2000,"delta":5,"min":1,"max":32,"label":"+5"}
data modify storage uno:settings target_row set value {"text":"目标积分（目标积分赛）\n","color":"white","extra":[]}
function uno:settings/step {"key":"target_hundreds","row":"target_row","offset":3000,"delta":-5,"min":1,"max":10,"label":"−500"}
function uno:settings/step {"key":"target_hundreds","row":"target_row","offset":3000,"delta":-1,"min":1,"max":10,"label":"−100"}
$data modify storage uno:settings target_row.extra append value {"text":"  $(target) 分  ","color":"gold","bold":true}
function uno:settings/step {"key":"target_hundreds","row":"target_row","offset":3000,"delta":1,"min":1,"max":10,"label":"+100"}
function uno:settings/step {"key":"target_hundreds","row":"target_row","offset":3000,"delta":5,"min":1,"max":10,"label":"+500"}
data modify storage uno:settings auto_row set value {"text":"自动喊 UNO\n","color":"white","extra":[]}
function uno:settings/choice {"key":"auto","row":"auto_row","value":0,"code":4000,"label":"手动喊"}
function uno:settings/choice {"key":"auto","row":"auto_row","value":1,"code":4001,"label":"自动喊"}
data modify storage uno:settings challenge_row set value {"text":"+4 质疑\n","color":"white","extra":[]}
function uno:settings/choice {"key":"challenge","row":"challenge_row","value":1,"code":5001,"label":"允许质疑"}
function uno:settings/choice {"key":"challenge","row":"challenge_row","value":0,"code":5000,"label":"禁止违规 +4"}
data modify storage uno:settings window_row set value {"text":"抓 UNO 时长（手动喊 UNO）\n","color":"white","extra":[]}
function uno:settings/step {"key":"seconds","row":"window_row","offset":6000,"delta":-1,"min":1,"max":5,"label":"−1"}
$data modify storage uno:settings window_row.extra append value {"text":"  $(seconds) 秒  ","color":"gold","bold":true}
function uno:settings/step {"key":"seconds","row":"window_row","offset":6000,"delta":1,"min":1,"max":5,"label":"+1"}
function uno:settings/root_show with storage uno:settings
