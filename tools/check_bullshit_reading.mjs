import fs from 'node:fs';
import assert from 'node:assert/strict';
const read=n=>fs.readFileSync('data/bullshit/function/'+n+'.mcfunction','utf8');
const dialog=read('question/answer_dialog');
assert.match(dialog,/unless score @s bw_state matches 1 run return 0/);
const lines=dialog.split(/\r?\n/).filter(l=>l.includes('run dialog show'));
assert.equal(lines.length,64);
for(let i=1;i<=64;i++){
 const line=lines.find(l=>l.includes(`bw_question matches ${i} as `));
 assert.ok(line,'missing question '+i);
 assert.match(line,/scores=\{bw_role=2\}\] if score @s bw_id = #ctx bw_ctx run dialog show @s/);
 assert.ok(line.includes("type:'minecraft:plain_message',width:440"));
 assert.ok(!line.includes('tellraw'));
}
assert.match(read('question/open_answer'),/tag=bw.player,scores=\{bw_role=2\}/);
assert.match(read('question/open_answer'),/ct_id = @s bw_id/);
assert.match(read('question/open_answer'),/bw_state=1.*bw_id = #ctx bw_ctx/);
assert.match(read('input/reading_drop'),/execute on origin if entity @s\[tag=bw.player\] at @s/);
assert.ok(read('input/reading_drop').includes('kill @s'));
assert.ok(read('question/hide_answer').includes('dialog clear @s'));
assert.match(read('question/hide_answer'),/clear @s minecraft:purple_dye.*tool:'reading'/);
assert.ok(!read('question/hide_answer').includes('tellraw'));
assert.ok(!fs.existsSync('data/bullshit/function/question/answer_chat.mcfunction'));
const inquiry=read('round/inquiry_start');
assert.ok(inquiry.indexOf('question/hide_answer')<inquiry.indexOf('本轮身份公布'));
assert.match(read('player/clear_state'),/function bullshit:question\/hide_answer/);
assert.match(read('game/resume'),/bw_state matches 1 run function bullshit:question\/resume_reading/);
assert.ok(read('tick').indexOf('round/tick_question')<read('tick').indexOf('input/reading_drop'));
console.log('PASS: 64道答案仅在对话框显示、身份及桌号检查、实际丢出者识别、阅读结束关闭/回收、重载入口。');
