"""HUD 实际位图宽度与两遍负字距抵消，避免行位置累积漂移。"""
import json
import unittest
from PIL import Image
from boardgame_assets import PACK,RP
from build_catan_font import RESOURCE_GLYPHS


class Hud(unittest.TestCase):
    def test_icon_rewinds_and_inherited_fonts(self):
        font=json.loads((RP/'assets/card/font/catan/hud.json').read_text(encoding='utf-8'))
        negative=json.loads((RP/'assets/card/font/catan/hud_neg.json').read_text(encoding='utf-8'))['providers'][0]['advances']
        self.assertEqual(set(negative),set(RESOURCE_GLYPHS))
        for provider in font['providers']:
            if provider['type']!='bitmap':continue
            with Image.open(RP/'assets'/provider['file'].replace(':','/textures/')) as image:
                bounds=image.convert('RGBA').getchannel('A').getbbox()
                advance=int((bounds[2] if bounds else 0)*provider['height']/image.height+.5)+1
            self.assertEqual(advance+2*negative[provider['chars'][0]],0)
            self.assertLessEqual(provider['height'],10)
        # 字形继承 HUD／负字距字体，不能在组件里强制同一个正字距字体。
        row=(PACK/'data/catan/function/hud/own_resources.mcfunction').read_text(encoding='utf-8')
        component=json.loads(row.split(' set value ',1)[1])
        self.assertFalse(any('font' in part for part in component['extra']))


if __name__=='__main__':unittest.main()
