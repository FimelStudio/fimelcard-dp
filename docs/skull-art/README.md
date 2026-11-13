骷髅牌美术：内置 imagegen 生成。提示词：Mexican Dia de Muertos flat playing-card atlas; marigold flower, decorated sugar skull, symmetrical papel picado back; teal, coral, orange, cream; no text.
纹理按三等份切分为256×384，专用模型不修改扑克或掼蛋资源。
第一人称手持及GUI使用正面，第三人称手持使用牌背；桌面visible仅记录已出牌slot与公开model，未翻牌始终为back。

桌面模型Y位于8至8.15，物品居中缩放后牌面高于摆放点，防止沉入桌面。

八套牌面按ct_seat（1至8）固定分配，同一座位的3张花与1张骷髅属于同套。每轮沿用owned中的model，翻牌读取实际revealed.model，牌背不区分套装。每个主题由内置imagegen生成一张两栏图集（左花、右骷髅）；源图和提示词记录于sets.json，运行tools/build_skull_sets.py可重新生成资源。
