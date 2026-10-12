import fs from 'node:fs';
import zlib from 'node:zlib';
import assert from 'node:assert/strict';
import {decodeNBT,encodeNBT} from './generate_table8.mjs';
// 保留原四人桌结构供旧布局参考；新模板只将四块真实椅子替换为空气。
const source=fs.readFileSync('data/cardtable/structure/table4.nbt');
const table=decodeNBT(zlib.gunzipSync(source));
assert.deepEqual(table.value.size.value.items,[5,1,5]);
const palette=table.value.palette.value.items;
const air=palette.findIndex(p=>p.Name.value==='minecraft:air');
assert.ok(air>=0);
let count=0;
for(const b of table.value.blocks.value.items){
 if(palette[b.state.value].Name.value==='minecraft:birch_stairs'){b.state.value=air;count++;}
}
assert.equal(count,4);
fs.writeFileSync('data/cardtable/structure/table4_display.nbt',zlib.gzipSync(encodeNBT(table)));
assert.deepEqual(fs.readFileSync('data/cardtable/structure/table4.nbt'),source);
console.log('已生成新四人桌模板：原3×3桌面、四个椅子位置为空气；原模板保留。');
