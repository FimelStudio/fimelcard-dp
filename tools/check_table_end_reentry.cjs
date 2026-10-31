const fs=require('fs'),assert=require('assert/strict');const read=(g,p)=>fs.readFileSync('data/'+g+'/function/'+p+'.mcfunction','utf8');
// 执行实际入口中的通用状态和调用顺序；已达票数的投票分派、人数变化与渲染作为观测点。
function replay(game,old=false){const w={state:1,cleanup:0,lobby:0,depth:0};function call(g,p){if(++w.depth>20)throw Error('recursive cleanup');if(p==='game/cleanup')w.cleanup++;if(g==='cardtable'&&p==='game/return_lobby')w.lobby++;
let source=read(g,p);if(old&&g===game&&p==='game/cleanup')source=source.replace('scoreboard players set @s ct_state 0','');
for(const line of source.split(/\r?\n/)){const m=line.match(/^scoreboard players set @s ct_state (\d+)$/);if(m)w.state=Number(m[1]);
if(line==='function cardtable:table/recount_players')call('cardtable','table/recount_players');
if(line==='execute if score @s ct_state matches 1 run function cardtable:vote/refresh'&&w.state===1)call(game,'game/end_vote');
if(line==='function '+game+':game/cleanup')call(game,'game/cleanup');
if(line==='function cardtable:game/return_lobby')call('cardtable','game/return_lobby');}
w.depth--;return w;}return call(game,'game/end_vote');}
for(const game of ['liars_holdem','hanabi']){assert.throws(()=>replay(game,true),/recursive cleanup/);const w=replay(game);assert.equal(w.cleanup,1);assert.equal(w.lobby,1);assert.equal(w.state,0);}
const games=['fast_card','liars_holdem','hanabi','abraca','bullshit','decrypto','critical_point','wenfei','skull','doudizhu','uno','chess'];for(const game of games){assert.ok(read('cardtable','vote/finish').includes('function '+game+':game/end_vote'));assert.ok(fs.existsSync('data/'+game+'/function/game/end_vote.mcfunction'));}
console.log('PASS: 德州扑克/花火旧路径复现递归，新路径只清理一次并恢复大厅；'+games.length+'款游戏结束投票入口完整。');
