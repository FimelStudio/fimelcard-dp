import fs from 'node:fs';
import assert from 'node:assert/strict';
const root='data/doudizhu/function/';
const rp='C:/Users/Chen Yuru/Desktop/fimelcard-rp/assets/card/';
const read=p=>fs.readFileSync(root+p+'.mcfunction','utf8');
const sounds=JSON.parse(fs.readFileSync(rp+'sounds.json','utf8'));
for(const name of ['normal','exciting','win','lose']){
 const event=sounds['doudizhu.'+name];assert.deepEqual(event.sounds,[{name:'card:doudizhu/'+name,stream:true}]);
 const b=fs.readFileSync(rp+'sounds/doudizhu/'+name+'.ogg');let offset=0,samples=0,rate;
 while(offset<b.length){assert.equal(b.toString('ascii',offset,offset+4),'OggS');const segments=b[offset+26],start=offset+27+segments;
 if(offset===0){assert.equal(b.toString('ascii',start+1,start+7),'vorbis');rate=b.readUInt32LE(start+12);}
 const granule=b.readBigInt64LE(offset+6);if(granule>=0n)samples=Number(granule);
 let size=0;for(let i=0;i<segments;i++)size+=b[offset+27+i];offset=start+size;
 }
 assert.equal(offset,b.length);const duration=samples/rate;const ticks=Math.ceil(duration*20);
 const start=read('music/start_'+name);assert.ok(start.includes('dd_mtime '+ticks));
 assert.ok(start.includes('playsound card:doudizhu.'+name+' record @s ~ ~ ~ 1 1 1'));
 assert.ok(start.indexOf('music/stop')<start.indexOf('playsound'));
 assert.ok(read('music/stop').includes('stopsound @s record card:doudizhu.'+name));
 if(name==='lose')assert.equal(duration,3);
 if(name==='win'||name==='lose')assert.ok(ticks<=100);
 console.log(name+': Vorbis '+duration.toFixed(3)+'秒 / '+ticks+'刻');
}
assert.ok(!fs.existsSync(root+'music/tracks'));
assert.ok(!read('music/tick').includes('music/tracks'));
assert.match(read('music/tick'),/dd_state=1\.\.3/);
assert.match(read('music/tick'),/dd_music=1,dd_mtime=\.\.0/);
assert.match(read('music/tick'),/dd_music=2,dd_mtime=\.\.0/);
assert.ok(!read('music/tick').includes('start_win'));assert.ok(!read('music/tick').includes('start_lose'));
assert.match(read('music/table_tick'),/dd_audio matches 0 run return 0/);
assert.match(read('music/table_tick'),/dd_id = #music_table dd_ctx/);
assert.match(read('player/clear_state'),/music\/stop/);
assert.match(read('game/finish'),/dd_timer 100/);
console.log('PASS: OGG时长、资源注册、定向播放、停止、循环、开关、旧曲谱删除及5秒结算等待。');
