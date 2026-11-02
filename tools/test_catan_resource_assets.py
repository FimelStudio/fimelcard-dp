"""Resource-card publication integrity and minimum small-icon contrast checks.

This catches stale item/font/Blockbench exports and tiny washed-out symbols;
the generated preview and an actual client still require visual inspection.
It does not assert subjective recognition from exact pixel/color snapshots.
"""
import base64
import hashlib
import json

from PIL import Image
from boardgame_assets import RP
from build_catan_font import RESOURCE_NAMES, RESOURCE_GLYPHS


def check():
    source = RP / '.source/catan'
    manifest = json.loads((source / 'resource/manifest.json').read_text(encoding='utf-8'))
    font_manifest = json.loads((source / 'font/manifest.json').read_text(encoding='utf-8'))
    font = json.loads((RP / 'assets/card/font/catan.json').read_text(encoding='utf-8'))
    providers = {p['chars'][0]: p for p in font['providers']}
    assert manifest['author'] == 'Fimel Cards'
    assert tuple(manifest['resources']) == RESOURCE_NAMES
    checked = 2
    logical_images = []
    for name, glyph in zip(RESOURCE_NAMES, RESOURCE_GLYPHS):
        asset = 'card:item/catan/resource/' + name
        texture_path = RP / ('assets/card/textures/item/catan/resource/' + name + '.png')
        texture = Image.open(texture_path)
        assert texture.mode == 'RGBA' and texture.size == (64, 64), name
        alpha = texture.getchannel('A')
        assert set(alpha.getdata()) == {0, 255}, (name, 'filtered alpha edges')
        assert all(alpha.getpixel(p) == 0 for p in ((0, 0), (63, 0), (0, 63), (63, 63)))
        assert alpha.getpixel((32, 32)) == 255
        logical = texture.resize((32, 32), Image.Resampling.NEAREST)
        assert logical.resize((64, 64), Image.Resampling.NEAREST).tobytes() == texture.tobytes(), (name, 'noninteger pixel-art scaling')
        # The identifiable subject must occupy substantial space inside its card.
        background = logical.getpixel((4, 4))[:3]
        visible = [logical.getpixel((x, y))[:3] for y in range(5, 27) for x in range(5, 27)]
        contrast = sum(max(abs(pixel[c] - background[c]) for c in range(3)) >= 50 for pixel in visible)
        assert contrast >= len(visible) * .4, (name, 'subject too small or low contrast')
        logical_images.append(logical)
        digest = hashlib.sha256(texture_path.read_bytes()).hexdigest()
        assert manifest['resources'][name]['sha256'] == digest
        assert font_manifest['resources'][name]['sha256'] == digest
        checked += 8

        model = json.loads((RP / ('assets/card/models/item/catan/resource/' + name + '.json')).read_text(encoding='utf-8'))
        item = json.loads((RP / ('assets/card/items/catan/resource/' + name + '.json')).read_text(encoding='utf-8'))
        assert item['model'] == {'type': 'minecraft:model', 'model': asset}
        assert model['parent'] == 'minecraft:item/generated'
        assert model['textures'] == {'layer0': asset}
        editable = json.loads((source / ('models/resource/' + name + '.bbmodel')).read_text(encoding='utf-8'))
        assert editable['meta']['model_format'] == 'java_block'
        assert editable['elements'] == [] and len(editable['textures']) == 1
        embedded = base64.b64decode(editable['textures'][0]['source'].split(',', 1)[1])
        assert embedded == texture_path.read_bytes(), (name, 'stale embedded Blockbench texture')
        checked += 6

        provider = providers[glyph]
        assert provider['file'] == 'card:font/catan/' + name + '.png'
        assert (provider['height'], provider['ascent']) == (14, 12)
        font_path = RP / ('assets/card/textures/font/catan/' + name + '.png')
        font_texture = Image.open(font_path)
        assert font_texture.mode == 'RGBA' and font_texture.size == (32, 32)
        assert font_texture.tobytes() == logical.tobytes(), (name, 'font differs from item symbol')
        checked += 4

    # Different resources cannot accidentally be mapped to duplicate artwork.
    assert len({image.tobytes() for image in logical_images}) == 5
    for i, first in enumerate(logical_images):
        for second in logical_images[i + 1:]:
            first_small = list(first.resize((14, 14), Image.Resampling.NEAREST).getdata())
            second_small = list(second.resize((14, 14), Image.Resampling.NEAREST).getdata())
            difference = sum(sum(abs(a[c] - b[c]) for c in range(3)) >= 100
                             for a, b in zip(first_small, second_small))
            assert difference >= 35, 'Resource images become too similar at actual font height'
            checked += 1
    assert (source / 'resource/preview.png').is_file()
    print(f'Catan resource item/font/editable source checks: {checked + 2} passed')


if __name__ == '__main__':
    check()
