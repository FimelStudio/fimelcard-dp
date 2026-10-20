import fs from 'node:fs';
import assert from 'node:assert/strict';
const read = n => fs.readFileSync(`data/decrypto/function/${n}.mcfunction`, 'utf8');
// Execute score branches from the actual mapping/count functions for every seat subset.
const range = (v, r) => {const [lo, hi = lo] = r.split('..'); return v >= +lo && v <= +hi;};
function run(name, scores, source = read(name)) {
  for (let line of source.split(/\r?\n/).map(x=>x.trim())) {
    if (!line || line.startsWith('#')) continue;
    if (line.startsWith('execute ')) {
      const [conditions, command] = line.slice(8).split(' run ');
      let pass = true;
      for (const m of conditions.matchAll(/(if|unless) score (\S+ \S+) matches (\S+)/g))
        pass &&= (m[1] === 'if') === range(scores[m[2]], m[3]);
      for (const m of conditions.matchAll(/if score (\S+ \S+) <= (\S+ \S+)/g))
        pass &&= scores[m[1]] <= scores[m[2]];
      if (!pass) continue;
      line = command;
    }
    let m = line.match(/^scoreboard players (set|add) (\S+ \S+) (-?\d+)$/);
    if (m) { scores[m[2]] = (m[1] === 'set' ? 0 : scores[m[2]]) + +m[3]; continue; }
    m = line.match(/^scoreboard players operation (\S+ \S+) (=|-=) (\S+ \S+)$/);
    if (m) {scores[m[1]] = m[2] === '=' ? scores[m[3]] : scores[m[1]] - scores[m[3]]; continue;}
    m = line.match(/^function decrypto:(\S+)$/);
    if (m) {run(m[1], scores); continue;}
    if (line === 'tag @s remove dc.team_pool') continue;
    throw Error(`Unsupported command: ${line}`);
  }
}
let cases = 0;
for (const capacity of [4, 8]) for (let mask=0; mask < 2**capacity; mask++) {
  const scores = {'#team_capacity dc_ctx':capacity, '#fixed_white dc_ctx':0, '#fixed_black dc_ctx':0};
  let white=0, black=0;
  for (let seat=1;seat<=capacity;seat++) if(mask & (1<<(seat-1))) {
    scores['@s ct_seat']=seat;
    run('team/count_fixed_one',scores);
    run('team/assign_fixed_one',scores);
    const expected = (capacity===4 ? [1,3] : [1,2,5,6]).includes(seat) ? 1 : 2;
    assert.equal(scores['@s dc_team'],expected);
    if(expected===1)white++;else black++;
  }
  assert.equal(scores['#fixed_white dc_ctx'],white);
  assert.equal(scores['#fixed_black dc_ctx'],black);
  cases++;
}
for(let size=4;size<=8;size++) {
  const scores={'#white_size dc_ctx':Math.ceil(size/2),'#order dc_ctx':0};
  let white=0;
  for(let i=0;i<size;i++){run('team/assign_one',scores);if(scores['@s dc_team']===1)white++;}
  assert.equal(white,Math.ceil(size/2));
}
const assign=read('team/assign'), start=read('game/start'), valid=read('team/validate_fixed');
assert.match(assign,/if score @s dc_id = #ctx dc_ctx run tag @s add dc.team_pool/);
assert.match(read('team/random_next'),/@a\[tag=dc.team_pool,sort=random,limit=1\]/);
assert.match(valid,/if score @s ct_id = #ctx dc_ctx run function decrypto:team\/count_fixed_one/);
assert.match(valid,/#fixed_white dc_ctx matches 2\.\.4 if score #fixed_black dc_ctx matches 2\.\.4/);
assert.ok(start.indexOf('team/validate_fixed')<start.indexOf('tag @s add dc.controller'));
assert.match(start,/dc_team_mode matches 1 if score @s ct_joined matches 4\.\. unless score #fixed_valid/);
assert.match(assign,/dc_mode matches 3 run return 0/);
for(const n of ['round/next','game/resume'])assert.ok(!read(n).includes('team/assign'));
assert.match(read('load'),/matches 12 run function decrypto:system\/upgrade_v13/);
console.log(`PASS: ${cases}种座位组合、4至8人随机分队人数、跨桌隔离、开局校验顺序、三人模式与重载保持分队。`);

// Execute actual balance validation arithmetic for both orientations, including malformed overfull teams.
const balance = valid.slice(valid.indexOf('scoreboard players operation #fixed_diff')).split('execute unless score #fixed_valid')[0];
for(let white=0;white<=8;white++)for(let black=0;black<=8;black++){
 const scores={'#fixed_white dc_ctx':white,'#fixed_black dc_ctx':black,'#fixed_valid dc_ctx':0};
 run('team/validate_fixed',scores,balance);
 assert.equal(scores['#fixed_valid dc_ctx'],Number(white>=2&&white<=4&&black>=2&&black<=4&&Math.abs(white-black)<=1),white+':'+black);
}
console.log('PASS: 81种人数分配；仅允许2:2、2:3、3:3、3:4、4:4及对调。');
