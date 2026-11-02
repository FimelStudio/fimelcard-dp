"""不读取绝对坐标的射线落点测试，覆盖负坐标、旋转和世界边界附近。"""
import shutil
from test_catan_engine import Suite,run,PACK,C


def prepare(target):
    shutil.copytree(PACK/'data/catan/function/input',target/'data/catan/function/input',dirs_exist_ok=True)


def main():
    s=Suite()
    s.file('coords','$say INPUT_COORDS x=$(x) z=$(z)')
    for base in (8,-800,29000000):
        for orient in (0,1):
            name=f'local_{str(base).replace("-","n")}_{orient}'
            c=['kill @e[tag=ce.fixture]',f'execute positioned {base}.0 64.0 8.0 summon minecraft:marker run function catan_engine_test:table {{table:101}}',f'tag {C} add ca.current',f'scoreboard players set {C} ct_capacity 4',f'scoreboard players set {C} ca_orient {orient}',f'scoreboard players set {C} ca_mode 1',f'execute positioned {base+.8660254} 65.025 8.0 summon minecraft:marker run tag @s add ca.ray']
            c += [f'execute as {C} at @s run function catan:input/ray_target','execute store result storage catan_engine_test:coords x int 1 run scoreboard players get #x ca_ctx','execute store result storage catan_engine_test:coords z int 1 run scoreboard players get #z ca_ctx','function catan_engine_test:coords with storage catan_engine_test:coords']
            c += s.score('#x','ca_ctx','3540..3555' if not orient else '-4..4',name+'_x')+s.score('#z','ca_ctx','-4..4' if not orient else '-3555..-3540',name+'_z')+['kill @e[tag=ca.ray]']
            s.case(name,c)
    s.finish()
    body=s.files['bootstrap']
    additions='\n'.join('scoreboard objectives add '+v+' dummy' for v in ('ct_capacity','ca_orient','ca_mode'))+'\n'
    additions+='forceload add -800 0 -785 15\nforceload add 29000000 0 29000015 15\n'
    s.files['bootstrap']=additions+body
    return run(s,prepare_target=prepare,prefix='fimel-catan-input-',setup_ticks=120)


if __name__=='__main__':raise SystemExit(main())
