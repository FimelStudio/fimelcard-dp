const fs=require('fs'),assert=require('assert/strict');
const read=n=>fs.readFileSync('data/abraca/function/'+n+'.mcfunction','utf8');
function run(name,w){for(const line of read(name).split(/\r?\n/)){if(!line||line.startsWith('#'))continue;
if(line==='execute unless score @s ab_state matches 1..2 run return 0'){if(!(w.state>=1&&w.state<=2))return;continue;}
if(line==='function abraca:game/finish'){run('game/finish',w);continue;}
if(line==='function abraca:hud/finalize'){w.finalized++;continue;}
let m=line.match(/^scoreboard players set @s ab_(state|timer) (\d+)$/);if(m){w[m[1]==='state'?'state':'timer']=Number(m[2]);continue;}
if(line.includes('player/clear_state')){w.cleared++;continue;}
}}
for(const initial of [1,2,3]){const w={state:initial,timer:initial===3?120:0,finalized:0,cleared:0};if(initial!==3)run('game/end_vote',w);for(let tick=0;tick<120;tick++){if(tick%10===0){run('game/end_vote',w);run('game/finish',w);}w.timer--;}assert.equal(w.timer,0);assert.equal(w.finalized,initial===3?0:1);assert.equal(w.cleared,initial===3?0:1);}
assert.match(read('tick'),/ab_state=3,ab_timer=\.\.0.*function abraca:game\/return_lobby/);
assert.match(read('game/return_lobby'),/ab.final_info/);assert.match(read('game/return_lobby'),/function cardtable:game\/return_lobby/);
console.log('PASS: 发牌中/游戏中结束只结算一次；每10刻重复投票不重置120刻计时；已有结算状态可走完；到期清理最终面板并返回大厅。');
