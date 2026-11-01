import assert from 'node:assert/strict';
import fs from 'node:fs';

const games = [
  ['hanabi', 'hb'], ['abraca', 'ab'], ['bullshit', 'bw'], ['decrypto', 'dc'],
  ['critical_point', 'cp'], ['wenfei', 'wq'], ['skull', 'sk'], ['doudizhu', 'dd'], ['uno', 'un'], ['chess', 'ch'], ['xiangqi', 'xq'], ['gomoku', 'gm'], ['aeroplane_chess', 'ac'], ['love_letter', 'll'], ['guandan', 'gd'], ['weiqi', 'go'],
];
const pack = new URL('../', import.meta.url);
const readFunction = id => fs.readFileSync(new URL(`data/${id.replace(':', '/function/')}.mcfunction`, pack), 'utf8');

// 执行入口文件中的实际指令；game/abort 作为观测边界记录执行者、坐标和维度。
// 这里只实现封装所需的命令子集，遇到未支持的命令立即失败，避免忽略行为变化。
function simulate(id, source, entities) {
  const calls = [], messages = [];
  const distance = (entity, context) => Math.hypot(...entity.position.map((n, i) => n - context.position[i]));
  function select(selector, context) {
    const match = selector.match(/^@([se])(?:\[(.*)\])?$/);
    assert.ok(match, `不支持的选择器：${selector}`);
    let selected = match[1] === 's' ? (context.self ? [context.self] : []) : [...entities];
    const options = (match[2] || '').split(/,(?![^{]*\})/).filter(Boolean).map(option => [option.slice(0,option.indexOf('=')), option.slice(option.indexOf('=')+1)]);
    let sort, limit;
    for (const [key, value] of options) {
      if (key === 'type') selected = selected.filter(entity => entity.type === value);
      else if (key === 'tag') selected = selected.filter(entity => entity.tags.includes(value));
      else if (key === 'distance') {
        const bounds = value.split('..');
        const min = bounds.length === 1 ? Number(value) : bounds[0] ? Number(bounds[0]) : 0;
        const max = bounds.length === 1 ? Number(value) : bounds[1] ? Number(bounds[1]) : Infinity;
        selected = selected.filter(entity => entity.dimension === context.dimension && distance(entity, context) >= min && distance(entity, context) <= max);
      } else if (key === 'scores') {
        assert.ok(value.startsWith('{')&&value.endsWith('}'),'记分项过滤格式');
        for(const score of value.slice(1,-1).split(',')){
          const m=score.match(/^(\w+)=(-?\d+)$/);
          assert.ok(m,'只支持精确分值');
          selected=selected.filter(entity=>entity.scores[m[1]]===Number(m[2]));
        }
      } else if (key === 'sort') sort = value;
      else if (key === 'limit') limit = Number(value);
      else assert.fail(`不支持的选择器参数：${key}`);
    }
    if (sort) {
      assert.equal(sort, 'nearest');
      selected.sort((a, b) => distance(a, context) - distance(b, context));
    }
    if (limit !== undefined) selected = selected.slice(0, limit);
    return selected;
  }
  function command(line, context) {
    if (!line || line.startsWith('#')) return;
    if (line.startsWith('execute ')) {
      const separator = line.indexOf(' run ');
      assert.ok(separator >= 0, `execute 缺少 run：${line}`);
      let prefix = line.slice(8, separator), contexts = [context];
      while (prefix) {
        let match;
        if ((match = prefix.match(/^(if|unless) entity (\S+)(?: |$)/))) {
          contexts = contexts.filter(ctx => (select(match[2], ctx).length > 0) === (match[1] === 'if'));
        } else if ((match = prefix.match(/^as (\S+)(?: |$)/))) {
          contexts = contexts.flatMap(ctx => select(match[1], ctx).map(self => ({...ctx, self})));
        } else if ((match = prefix.match(/^at (\S+)(?: |$)/))) {
          contexts = contexts.flatMap(ctx => select(match[1], ctx).map(entity => ({...ctx, position: [...entity.position], dimension: entity.dimension})));
        } else assert.fail(`不支持的 execute 子命令：${prefix}`);
        prefix = prefix.slice(match[0].length);
      }
      for (const ctx of contexts) {
        const result = command(line.slice(separator + 5), ctx);
        if (result?.returned) return result;
      }
      return;
    }
    if (line === 'return fail') return {returned: true, success: false};
    let match;
    if ((match = line.match(/^tellraw (\S+) (.+)$/))) {
      for (const recipient of select(match[1], context)) messages.push({recipient: recipient.id, text: match[2]});
      return;
    }
    if ((match = line.match(/^function (\S+)$/))) {
      assert.ok(fs.existsSync(new URL(`data/${match[1].replace(':', '/function/')}.mcfunction`, pack)), `函数不存在：${match[1]}`);
      calls.push({function: match[1], executor: context.self.id, position: [...context.position], dimension: context.dimension});
      return;
    }
    assert.fail(`不支持的命令：${line}`);
  }
  const context = {self: source, position: source ? [...source.position] : [100, 64, -100], dimension: source?.dimension || 'minecraft:overworld'};
  let result;
  for (const line of readFunction(id).split(/\r?\n/)) {
    result = command(line.trim(), context);
    if (result?.returned) break;
  }
  return {calls, messages, failed: result?.success === false};
}

const entity = (id, type, tags = [], offset = [0, 0, 0], dimension = 'minecraft:overworld') => ({
  id, type, tags, position: offset.map((n, i) => [100, 64, -100][i] + n), dimension, scores: {ct_id: 42, ct_state: 1},
});
let checks = 0;
for (const [namespace, prefix] of games) {
  const player = () => entity('operator', 'minecraft:player', ['ct.player']);
  const table = (id, offset = [3, 0, 0], dimension) => {
    const result=entity(id,'minecraft:marker',['ct.controller',`${prefix}.controller`],offset,dimension);
    if(namespace==='love_letter')result.scores.ct_game=17;
    if(namespace==='guandan')result.scores.ct_game=18;
    if(namespace==='weiqi')result.scores.ct_game=20;
    return result;
  };
  function check(label, source, entities, expectedTarget, expectedFailure = !expectedTarget, expectedMessage = !expectedTarget && source?.type === 'minecraft:player') {
    const snapshot = structuredClone({source, entities});
    const result = simulate(`${namespace}:admin/abort`, source, entities);
    assert.equal(result.failed, expectedFailure, `${namespace}：${label}返回值`);
    assert.deepEqual(result.calls, expectedTarget ? [{function: `${namespace}:game/abort`, executor: expectedTarget.id, position: expectedTarget.position, dimension: expectedTarget.dimension}] : [], `${namespace}：${label}应仅中止目标桌一次，并切换执行者和位置`);
    assert.equal(result.messages.length, expectedMessage ? 1 : 0, `${namespace}：${label}错误提示次数`);
    for (const message of result.messages) {
      assert.equal(message.recipient, source.id);
      assert.match(message.text, /[\u4e00-\u9fff]/, '无目标时应向执行玩家提供中文错误提示');
    }
    assert.deepEqual({source, entities}, snapshot, '封装不得临时修改玩家 ct_id、标签或其他游戏状态');
    checks++;
  }
  check('无牌桌', player(), []);
  check('超过 8 格', player(), [table('far', [8.01, 0, 0])]);
  check('垂直方向也计算距离', player(), [table('above', [0, 8.01, 0])]);
  check('不同维度同坐标', player(), [table('nether', [0, 0, 0], 'minecraft:the_nether')]);
  const edge = table('boundary', [0, 0, 8]);
  check('恰好 8 格', player(), [edge], edge);
  const close = table('near', [2, 1, 0]), further = table('further', [6, 0, 0]);
  check('多个同游戏桌取最近', player(), [further, close], close);
  if (['chess','xiangqi','gomoku','aeroplane_chess','love_letter','guandan','weiqi'].includes(namespace)) {
    const preview = table('preview', [0.2, 0, 0]); preview.scores.ct_state = 0;
    check('大厅预览更近时选择进行中的局', player(), [preview, close], close);
    check('只有大厅预览时拒绝中止', player(), [preview]);
  }
  if (['love_letter','guandan','weiqi'].includes(namespace)) {
    const stale = table('stale-game-tag', [0.1, 0, 0]); stale.scores.ct_game = 1;
    check('旧游戏标签不能覆盖当前游戏编号', player(), [stale, close], close);
    check('只有旧游戏标签时拒绝中止', player(), [stale]);
  }
  const unrelated = entity('other-game', 'minecraft:marker', ['ct.controller', 'other.controller'], [0.1, 0, 0]);
  check('异游戏牌桌更近', player(), [unrelated, close], close);
  check('只有其他游戏', player(), [unrelated]);
  const orphan = entity('not-a-cardtable', 'minecraft:marker', [`${prefix}.controller`], [0.1, 0, 0]);
  check('缺少公共牌桌标签', player(), [orphan]);
  const wrongType = entity('not-a-marker', 'minecraft:armor_stand', ['ct.controller', `${prefix}.controller`], [0.1, 0, 0]);
  check('错误实体类型', player(), [wrongType]);
  const controller = table('non-player-source', [0, 0, 0]);
  check('非玩家实体调用', controller, [controller, close], undefined, true, false);
  check('服务器控制台调用', null, [close], undefined, true, false);
  const netherPlayer = entity('nether-player', 'minecraft:player', [], [0, 0, 0], 'minecraft:the_nether');
  const netherTable = table('nether-target', [4, 0, 0], 'minecraft:the_nether');
  check('下界玩家按本维度选择', netherPlayer, [table('overworld', [0.1, 0, 0]), netherTable], netherTable);
}
console.log(`通过：${games.length} 个管理员中止入口、${checks} 个行为场景；覆盖距离、维度、最近牌桌、调用者限制和执行上下文。`);
