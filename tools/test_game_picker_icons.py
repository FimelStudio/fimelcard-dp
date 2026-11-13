"""在临时原版26.2世界验证两种图标选游窗口及全部21个安全编码参数。"""
import shutil

from test_guandan_cards import Suite as BaseSuite, PACK, run

TABLE='@e[type=minecraft:marker,tag=gi.table,limit=1]'


class Suite(BaseSuite):
    def build(self):
        self.file('reset','kill @e[tag=gi.fixture]')
        for cap in (4,8):
            lines=['function guandan_test:reset','summon minecraft:marker 8.0 64.0 8.0 {Tags:["gi.fixture","gi.table"]}',f'scoreboard players set {TABLE} ct_id 101',f'scoreboard players set {TABLE} ct_capacity {cap}',
                   'scoreboard players set #pick_nonce ct_ctx 0',f'scoreboard players set #picker_compiled_{cap} gt 0',f'execute as {TABLE} at @s run function cardtable:menu/picker/open']
            lines+=self.score('#picker_compiled_'+str(cap),'gt',1,f'picker_{cap}_complete_macro_compiles')
            for game in range(1,24):
                lines += [f'execute store result score #parameter gt run data get storage cardtable:picker p{game}']
                lines += self.score('#parameter','gt',100+game,f'picker_{cap}_parameter_{game}')
            self.case('picker_'+str(cap),lines)
        self.file('bootstrap',['forceload add 0 0 15 15','scoreboard objectives add gt dummy','scoreboard objectives add ct_ctx dummy','scoreboard objectives add ct_id dummy','scoreboard objectives add ct_capacity dummy','scoreboard objectives add ct_pick_table dummy','scoreboard objectives add ct_pick_base dummy','scoreboard objectives add ct_game_pick trigger','schedule function guandan_test:case/picker_4 2t'])
        self.file('finish','say GUANDAN_FINISHED')
        for index,name in enumerate(self.cases):self.files['case/'+name]+='schedule function guandan_test:'+('case/'+self.cases[index+1] if index+1<len(self.cases) else 'finish')+' 1t\n'


def prepare(target):
    for name in ('open','show4','show8'):
        source=PACK/f'data/cardtable/function/menu/picker/{name}.mcfunction'
        dest=target/f'data/cardtable/function/menu/picker/{name}.mcfunction'
        dest.parent.mkdir(parents=True,exist_ok=True);shutil.copy2(source,dest)
        if name.startswith('show'):
            # 真实宏正文保持原样；命令编译失败时不会执行末尾哨兵。
            dest.write_text(dest.read_text(encoding='utf-8')+f'scoreboard players set #picker_compiled_{name[4:]} gt 1\n',encoding='utf-8')


if __name__=='__main__':
    suite=Suite();suite.build()
    raise SystemExit(run(suite,prefix='fimel-game-picker-icons-',prepare_target=prepare))
