# 文本动画库重制版 介绍

#### 索引

        0. 动画展示
        
        1. 动画详解

        2. 参数详解

        3. 使用方法

        4. 遇到的问题

        5. 总结与鸣谢

---

## 动画展示

### 展示实体动画

![20250913mp4.gif](https://b3logfile.com/file/2025/09/2025-09-13mp4-P9dogvL.gif)

### title栏动画

![202509132mp4.gif](https://b3logfile.com/file/2025/09/2025-09-13-2mp4-xDtlBeG.gif)

>  快来制作属于你自己的剧情动画吧！

---

## 动画详解

游戏在服务端storage，或服务端实体中存储了播放动画的信息，也就是文本动画的详细参数。

按照游戏刻进行循环计算，满足条件时给玩家播放相应的文本动画与声音。

### 动画类型

#### 全局动画 Global

* 全局动画，顾名思义，是给全体玩家播放的文本动画

* 全局动画在title命令下的三个title栏可以播放，[动画路径]见后文**动画详解-动画路径**

* 全局动画的记分与存储分别位于记分项

    ```mcfunction
    cgt.AnimText.storage
    ```

    与数据存储storage

    ```mcfunction
    minecraft:cgt_anim_text global.[动画路径]
    ```

* **性能说明**：由服务端storage直接传入title命令，性能开销**低**，适合优先选用。

#### 本地动画 Local

* 本地动画，是给指定玩家播放的文本动画

* 本地动画在title命令下的三个title栏可以播放，[动画路径]见后文**动画详解-动画路径**

* 本地动画的记分与存储分别位于记分项系列

    ```mcfunction
    cgt.AnimText.entity
    ```

    与数据存储storage

    ```mcfunction
    minecraft:cgt_anim_text local.[动画路径]
    ```

    以及分配实体的实体信息entity

    ```mcfunction
    interaction data
    ```

* **性能说明**：给每个玩家分配一个实体，并且在每游戏刻选择，并位于实体上计算，性能开销**中等**，对于正常使用无碍。

#### 世界动画 Positional

* 世界动画，专指使用文本展示实体播放的动画

* 世界动画有两种播放模式可以播放，分别为打字动画(typewriter)与特效动画(animation)，[动画路径]见后文**动画详解-动画路径**

* 世界动画的记分与存储分别位于记分项系列

    ```mcfunction
    cgt.AnimText.entity
    ```

    与数据存储storage

    ```mcfunction
    minecraft:cgt_anim_text positional.[动画路径]
    ```

    以及分配实体的实体信息entity

    ```mcfunction
    interaction data
    ```

* **性能说明**：给每段文本分配一个实体，并且在每游戏刻选择，并位于实体上计算，性能开销较高，不建议一次生成过多世界动画，性能开销**较大**。

---

### 动画路径

不同动画路径函数控制播放的文本以什么形式（title还是展示实体）展示，详见上文**动画详解-动画类型**。

#### 全局动画 Global

* 全局播放位于函数路径

    ```mcfunction
    cgt_anim_text:global/[动画路径]
    ```

* 全局播放有上述三个播放格式：actionbar、subtitle、title，每个模式下分别有三种动画路径：actionbar、subtitle、title。详细功能详见后文**参数详解-动画样式**。

#### 本地动画 Local

* 本地播放位于函数路径

    ```mcfunction
    cgt_anim_text:local/[动画路径]
    ```

* 本地播放有上述三个播放格式：actionbar、subtitle、title。每个模式下分别有三种动画路径：actionbar、subtitle、title。详细功能详见后文**参数详解-动画样式**。

#### 世界动画 Positonal

* 世界播放位于函数路径

    ```mcfunction
    cgt_anim_text:positional/[动画路径]
    ```

* 本地播放有上述两个播放格式：typewriter、animation。typewriter模式下有三种动画样式，而animation模式下有很多不同的特效样式，详细功能详见后文**参数详解-动画样式**。

---

### 效果

* 全局动画与本地动画都是使用title栏给指定范围的玩家播放一段文字，打字效果呈现。

* 世界动画是使用展示实体播放文字给所有能看见该实体的玩家，可以选择打字效果呈现，也可以用更多特效效果，详见下文**参数详解-动画样式**。

---

## 参数详解

**文本动画库的参数信息，包括如下**
        
        1. 文本组件信息
        
        2. 声音信息
        
        3. 速度信息
        
        4. 动画
        
        5. 内联命令
        
        6. 文本解析
        
        7. 独有参数

### 文本组件信息

>
> 文本组件（Text Component），过去亦作原始JSON文本（Raw JSON Text），Minecraft通过它向玩家发送和显示富文本。
>
> ——MinecraftWiki

文本组件记录了一段文本的所有编码信息，其格式可以为字符串、复合标签、列表。

此处只对其大体结构与功能进行介绍 [详细介绍请见Wiki](https://zh.minecraft.wiki/w/%E6%96%87%E6%9C%AC%E7%BB%84%E4%BB%B6)。

**复合标签**

* 复合标签格式作为文本组件的最基础格式，具有下列结构：

            根标签{
            type: 文本组件类型。多数情况下此标签可以被省略。
            extra: [ ] 此文本组件的子组件。
            }

* 其中按不同文本组件类型，即不同type标签可分为以下几类：

    1. **text**：静态组件，纯文本组件类型。

    2. **translatable**：静态组件，本地化文本组件类型。做标签时名称为translate。

    3. **keybind**：静态组件，键位绑定组件类型。

    4. **score**：动态组件，记分板数据组件类型。

    5. **selector**：动态组件，实体名称组件类型。

    6. **nbt**：动态组件，NBT组件类型。

    7. **object**：静态组件，精灵图组件类型。

**字符串**

* 为文本组件的简写格式，其以半角单引号或双引号包围一行字符，比如"Hello World!"即为一个字符串。效果等价于{text:"Hello World!"}

**列表**

* 列表格式是多个组件拼接的简写形式，列表中每个元素都是一个有效的文本组件，格式可以为复合标签、列表或字符串。由于SNBT与JSON都支持异构列表或数组，所以列表格式中的元素允许混搭，即文本组件的三种格式可以同时存在于一个列表中。游戏在读取列表格式时会自动将其转换为复合标签格式。

#### 参数格式

**文本组件**，参数标签下text键值，***此项必须存在***，规范见下文**使用方法-初始化函数-实例化参数要求**。

---

### 声音信息

声音信息编码了文本动画播放时音效。

#### 声音路径

位于数据包data目录的五个文件

```
cgt_anim_text/function/operation/sound/default.mcfunction
cgt_anim_text/function/operation/sound/default_out.mcfunction
cgt_anim_text/function/operation/sound/positional.mcfunction
cgt_anim_text/function/operation/sound/positional_out.mcfunction
cgt_anim_text/function/operation/sound/positional_drop.mcfunction
```

其中的检测分数码即为声音编码。

#### 声音效果

* 其中**default**两个文件，是给玩家播放声音时的音频编码文件，用于**全局、本地动画播放**：

    ```按照数据包代码，其中playsound是选择玩家为执行实体、执行位置后执行命令，因此目标选择器建议设为@s。```

* 其中**positional**三个文件，是给展示实体播放声音时的音频编码文件，用于**世界动画播放**：

    ```按照数据包代码，其中playsound是选择展示实体为执行实体、执行位置后执行命令，因此目标选择器建议设为@a，并且设置合适的**声音衰减**参数。```

* 而每个“播放位置文件组”对应两个文件，不带后缀名的是文本动画的出现音效。带后缀out则为消失音效，此文件中的音频并非总是播放，只有带有**消失动画**的**动画样式**才有此音效。带后缀drop则为掉落音效，此文件中的音频并非总是播放，只有指定**文字掉落**标签时才有此音效

#### 自定义声音

你可以在sound目录下的五个文件中自定义音效，并在游戏内传入参数sound以自定义声音，具体写法见下文**使用方法-**。

#### 参数格式

**整型数字**，参数标签下sound键值，*默认为1*，规范见下文**使用方法-初始化函数-实例化参数要求**。

---

### 速度信息

speed参数控制文本播放速度，其数值越大，速度越快，计算公式如下：

$$时间间隔T=[t_0\frac{100}{speed}]，t_0=3tick$$

**此函数为向下取整函数*

#### 参数格式

**正整形数字**，参数标签下speed键值，*默认为100*，规范见下文**使用方法-初始化函数-实例化参数要求**。

---

### 动画样式

**动画样式**控制此动画路径下的动画选择哪种效果，样式可以改变文本动画的出现动画、消失动画，达到不一样的效果。

#### 全局动画

        全局播放有三个动画路径：actionbar、subtitle、title

* 每个路径下分别有三种**动画样式**，分别为style下编号0、1、2

  * **默认样式**
  
      style编号0，文本以打字形式播放，随后自然淡去
  
  * **退格消失**
  
      style编号1，文本以打字形式播放，随后退格消失，此样式为消失动画
  
  * **双向退格消失**
  
      style编号2，文本以打字形式播放，随后从两侧退格消失，此样式为消失动画

#### 本地动画

        本地播放有三个播放路径：actionbar、subtitle、title

* 每个模式下也分别有三种**动画样式**，分别为style下编号0、1、2，具体效果**与全局播放一致**。

#### 世界动画

        世界播放有两个播放路径：typewriter、animation

1. **打字样式**

  * 有三种**动画样式**，分别为style下编号0、1、2，具体效果**与全局播放一致**。

2. **特效动画样式**

  * 有如下许多特效动画样式：

    * style=0，逐字放大出现

    * style=1，逐字横向拉伸出现

    * style=2，逐字纵向拉伸出现

    * style=3，逐字缩小出现

    * style=4，逐字横向压缩出现

    * style=5，逐字纵向压缩出现

    * style=6，逐字随机缩放出现

    * style=7，逐字随机拉伸出现

    * style=8，逐字随机压缩出现

    * style=9，逐字横向伸缩出现

    * style=10，逐字纵向伸缩出现

    * style=11，逐字下落出现

    * style=12，逐字上浮出现

    * style=13，逐字随机上下滑动出现

    * style=14，逐字前进出现（有背景时效果不佳，由于游戏逻辑无插值动画）

    * style=15，逐字左滑出现（由于游戏逻辑无插值动画）

    * style=16，逐字左翻转出现（有背景时效果不佳）

    * style=17，逐字右翻转出现（有背景时效果不佳）

    * style=18，逐字随机左右翻转出现（有背景时效果不佳）

    * style=19，逐字上翻出现（有背景时效果不佳）

    * style=20，逐字下翻出现（有背景时效果不佳）

    * style=21，逐字随机上下翻出现（有背景时效果不佳）

    * style=22，逐字左旋转出现

    * style=23，逐字右旋转出现

    * style=24，逐字随机左右旋转出现

    * style=25，逐字从乱码显形出现

    * style=26，逐字变为乱码后消失（此样式包括淡出音效）

    * style=27，逐字从乱码显形出现，变为乱码后消失（此样式包括淡出音效）

    * style=28，中心打字出现，中心扩散淡出消失

    * style=29，中心扩散淡入显现，中心打字消失

    * style=30，中心扩散淡入显现，随后中心扩散淡出消失

    * style=31，随机淡入显现，中心打字消失

    * style=32，中心打字出现，随机淡出消失

    * style=33，随机淡入显现，随后随机淡出消失

    * style=34，随机淡入显现，随后中心扩散淡出消失

    * style=35，中心扩散淡入显现，随后随机淡出消失

#### 参数格式

**正整形数字**，参数标签下style键值，*默认为0*，规范见下文**使用方法-初始化函数-实例化参数要求**。

---

### 内联命令

内联命令允许开发者自定义文本播放结束后的命令，留空则不执行任何命令

#### 执行者与执行位置

* 对于全局动画，执行者是服务器，执行位置在世界默认位置，一般为主世界的坐标原点

* 对于本地动画，执行者是玩家，执行位置也在播放此字幕的玩家处

* 对于世界动画，执行者是文本展示实体，执行位置在实体生成处（永远处于其生成位置而非跟随展示实体的变幻、传送与动画而改变）。

#### 参数格式

**字符串**，参数标签下command键值，默认为空字符串，规范见下文**使用方法-初始化函数-实例化参数要求**。

---

### 文本解析

数据包识别唯一文本组件是列表形式，但是为什么可以输入任意的文本组件形式？

原因在于输入的text参数会先经过文本解析过程，自动转化为单字符的列表组件形式。

#### 文本解析

* 对于输入的文本，数据包自动识别是否可以拆分字符串，并且在保留文本组件样式的同时，拆分、转化、以列表输出文本组件，使其成为可读的列表形式

例如输入下例文本组件

```SNBT
    "Hello!"

    {text:"123456",color:"red",extra:["77",{text:"88",color:"green"}]}
```

将自动转化为

```SNBT
[{text:"H",color:"white"},{text:"e",color:"white"},{text:"l"color:"white"},{text:"l",color:"white"},{text:"o",color:"white"}{text:"!",color:"white"}]

[{text:"1",color:"red"},{text:"2",color:"red"},{text:"3",color:"red"},{text:"4",color:"red"},{text:"5",color:"red"},{text:"6",color:"red"},{text:"7",color:"red"},{text:"7",color:"red"},{text:"8",color:"green"},{text:"8",color:"green"}]
```

但若输入文本量过大，游戏在解析负载较高，可能影响正常运行。因此我们可以选择不允许游戏解析文本内容，直接传入列表后应用于动画。

#### 详细功能

* analyse参数设为0b（false），则直接读取输入文本组件，如果为列表形式则调用，如果非列表形式发出警告，并自动解析后执行，该警告可以于设置关闭，详见下文**使用方法-设置项-报错与警告**。

* analyse参数设为1b（true），数据包无论文本组件是否符合要求，均开始解析，转化成列表形式，期间遇到不规范语法输出警告，并自动改正语法，随后开始播放文本动画。

#### 参数格式

**布尔值**，参数标签下analyse键值，*默认为1b*，规范见下文**使用方法-初始化函数-实例化参数要求**。

---

### 独有参数

数据包中的不同文本动画格式函数有不同的特性，比如只适用于title栏位（actionbar、subtitle、title）播放的**栏位覆盖参数**……

#### 栏位覆盖

        该参数只适用于全局动画和本地动画

对于占用玩家title栏（包括actionbar、subtitle、title三个栏位）的动画，如果在播放同时再执行播放一条命令，则游戏会发出报错提示——正在播放动画。如果你明确需要覆盖掉当前播放的动画，可以使用栏位覆盖。

##### 详细功能

* 全局动画和本地动画播放，当replace参数设置为0，即不进行覆盖，若同时有正在播放的文本，则弹出报错。报错不会干扰游戏运行，可以在设置选项关闭，详见下文**使用方法-设置项-报错与警告**。

* 对于全局动画和本地动画播放，如果replace参数设置为1，则可以覆盖掉同类别的文本，也就是全局动画可以覆盖全局动画，本地动画覆盖本地动画，被覆盖的文本将直接截断，后续不再播放。

* 在本地动画栏位覆盖为0或1时，全局动画的栏位覆盖无论设置与否，都可以覆盖本地动画，此时被覆盖的文本不会直接截至，而是等优先级高的全局动画播放完毕后继续播放。

* 当本地动画replace设置为2时，可以覆盖全局动画，全局动画为兼顾多人播放，将继续推进，因此遗漏的全局动画将不会再播放，直到优先级高的本地动画播放结束后才会显示。

##### 参数格式

**整型数字**，参数标签下replace键值，*默认为0*，规范见下文**使用方法-初始化函数-实例化参数要求**。

#### title值

        该参数只适用于subtitle播放

由于Minecraft游戏机制，subtitle只有在title存在时才会正常显示，如果当前不存在主标题title栏的展示，则你将得到“棍木”，因此适时决定是否存在title标题显示是subtitle动画播放的保证。

##### 详细功能

* title参数设置为0b（false），表示打字时不存在正在显示的title标题，游戏自动补全一个空title展示，保证subtitle独立播放。

* title参数设置为1b（true），表示打字时存在正在播放的title标题，游戏将直接输出subtitle而不追加空title展示。

##### 参数格式

**布尔值**，参数标签下title键值，*默认为0b*，规范见下文**使用方法-初始化函数-实例化参数要求**。

#### 实体属性

        该参数只适用于世界动画播放，因为只有展示实体可以更改实体属性

如果你希望生成一个更奇特的世界动画动画，比如自然添加了仿射变换、对其模式、背景颜色、甚至单行长度……不妨试试预设实体属性参数。

##### 详细功能

[参见Wiki-展示实体-数据值](https://zh.minecraft.wiki/w/%E5%B1%95%E7%A4%BA%E5%AE%9E%E4%BD%93#%E6%95%B0%E6%8D%AE%E5%80%BC)

* 此标签预设的实体属性会自动被植入游戏。只要传入标签正确，拼写无误，等价于生成展示实体并预设NBT，与下面命令功能相同。

* *特效动画（animation）动画路径下不支持复杂的仿射变换，仅支持缩放大小（scale）参数，具体见**参数详解-独有参数-缩放大小**

```mcfunction
execute summon text_display run data merge entity @s {实体属性}
```

##### 参数格式

**复合标签**，参数标签下entity_properties键值，*默认按Minecraft游戏默认预设生成实体*，规范见下文**使用方法-初始化函数-实例化参数要求**。

#### 缩放大小

        该参数只适用于世界动画播放的animation实例

为了保证动画正常播放而不产生不正确渲染效果，animation路径下所有动画都不允许仿射变换，唯一的接口是scale用以缩放。

##### 详细功能

* scale参数仅对文本大小进行调整，计算公式如下

$$文本展示实体边长X=x_0·[scale]，x_0=0.2250格$$

##### 参数格式

**单精度浮点数**，参数标签下scale键值，*默认为1.00f*，规范见下文**使用方法-初始化函数-实例化参数要求**。

#### 反向动画

        该参数只适用于世界动画播放的animation实例

想让文本动画反向出现？来试试反向生成模式。

##### 详细功能

* reverse参数仅对文本出现方向进行调整，取0b正向，取1b反向。

##### 参数格式

**布尔值**，参数标签下reverse键值，*默认为0b*，规范见下文**使用方法-初始化函数-实例化参数要求**。

#### 总文本上限

        该参数只适用于世界动画播放的typewriter实例

由于title栏（包括actionbar、subtitle、title三个栏位）是硬编码，文本无法缩放，因此使用其进行播放，数据包已经硬编码了**最大宽度**，当打字超出宽度时，将从左端消除文本以保证可视性。而展示实体打字时，可以通过更改与玩家距离，字体缩放等参数，使得在屏幕上可显示的文本数量不确定，因此通过该参数可以动态调节展示实体的**总文本上限**。

##### 详细功能

* 参数width和展示实体属性line_width不冲突，前者是**总文本上限**，后者是展示实体一行内最大文本数。

* 多余的也没什么能介绍的awa，进游戏试试就知道了。

##### 参数格式

**正整型数字**，参数标签下width键值，*默认为32*，规范见下文**使用方法-初始化函数-实例化参数要求**。

#### 文字掉落

        该参数只适用于世界动画播放的animation实例

*米塔！*

##### 详细功能

* 参数drop不存在时，动画播放完将按原有消失动画消失。

* 参数drop标签存在时，动画播放完后文字依次掉落到地面。

    * 此时若不指定motion标签，则文字永远以0初速度掉落，即使指定direction也没有效果。
    
    * 若指定motion标签，则有以下参数修饰。

* **速度参数**：drop标签下的motion标签，如果为值，则掉落时每个文字被赋予此值大小、随机方向的初速度，如果为三元列表，则按照列表直接赋予x y z三个方向的初速度，如果为复合标签，形式如下：

    ```SNBT
    motion:{max:[最大速度], min:[最小速度]}
    ```

    游戏将随机选取[min, max]的随即方向初速度，除非指定direction

* **方向参数**：drop标签下的direction标签，只能为复合标签，形式如下：

    ```SNBT
    direction:{rotation:[y_rotaton, x_rotation], x_rotation:{max:[最大角度], min:[最小角度]}, y_rotation:{max:[最大角度], min:[最小角度]}}
    ```

    其中rotation表示初速度赋值的基础朝向，如果不指定x_rotation或y_rotation，则游戏默认予以特定方向，如果指定x_rotation、y_rotation，则按照局部坐标系朝向，分别加上最大、最小角度，作为随机方向区间。如果不指定rotation，则以实体Rotation作为rotation参数。
    
* 例如下面：同时指定了motion与direction
    
    ```SNBT
    drop:{motion:{max:0.2f, min:0.0f}, direction:{rotation:[22.5f, 40.0f], x_rotation:{max:20.0f, min:-15.0f}, y_rotation:{max:11.0f, min:-14.0f}}}
    ```

    掉落时，游戏将随机赋予文字一个介于0到0.2的速度，其偏航角方向位于8.5到33.5之间，俯仰角位于25到60之间。

* **视角跟随**：drop标签下的billboard标签，布尔值

    ```SNBT
    billboard:[billboard]
    ```

    此参数决定掉落后的文本是否设置billboard，若不指定则随机旋转，[详细参数见wiki](https://zh.minecraft.wiki/w/%E5%B1%95%E7%A4%BA%E5%AE%9E%E4%BD%93/#%E6%95%B0%E6%8D%AE%E5%80%BC)

##### 参数格式

**复合标签**，参数标签下drop键值，*默认为不存在*，规范见下文**使用方法-初始化函数-实例化参数要求**。

<!-- #### 背景渐变

        该参数只适用于世界动画播放的animation实例

*丝滑渐变背景*

##### 详细功能

* 参数background不存在时，游戏以预设**实体属性**的background为准，若此项也不存在则使用默认背景40000000。

* 参数background标签存在时，可以设置背景效果，使用如下复合标签，游戏自动从起始颜色插值到终止颜色，形成渐变效果。当颜色跨度大时，或字数少时，效果不佳。

    ```SNBT
    background:{from:[起始颜色], to:[终止颜色]}
    ```

    [详细颜色编码见Wiki](https://zh.minecraft.wiki/w/%E5%B1%95%E7%A4%BA%E5%AE%9E%E4%BD%93#%E5%AE%9E%E4%BD%93%E6%95%B0%E6%8D%AE)

##### 参数格式

**复合标签**，参数标签下background键值，*默认为空*，规范见下文**使用方法-初始化函数-实例化参数要求**。 -->

---

## 使用方法

### 初始化函数

数据包中所有动画均以以下函数加载

```mcfunction
function cgt_anim_text:[动画类型]/[动画路径]/load {data:{参数标签}}
```

动画类型详见**动画详解-动画类型**，动画路径详见**动画详解-动画路径**，均为小写英文单词。

#### 实例化参数要求

**这里是重点！这里是重点！这里是重点！**

**想流畅使用请务必阅读！**

* 所有动画统一使用宏函数进行执行，所有参数统一位于{data:{这里}}，务必在根标签内嵌套data以便游戏解析，data外的参数将被自动忽略。

* **必须参数**：text标签必须存在，否则直接中断进程并报错。

* 可选参数：除了text意外所有参数均可以省略，省略则按照默认值预设，以下是默认参数列表：

```SNBT
{data:{text:[必须参数], sound:1, speed:100, style:0, command:"", analyse:1b, title:0b, width:32, entity_properties:{}, replace:0, scale:1.0, reverse:0b}}
```

* 因此默认情况下执行动画的函数为：

```mcfunction
function cgt_anim_text:[动画类型]/[动画路径]/load {data:{text:[必须参数], sound:1, speed:100, style:0, command:"", analyse:1b, title:0b, width:32, entity_properties:{}, replace:0, scale:1.0, reverse:0b}}
```

* 而包括省略参数，一条命令至少为如下示例：

```mcfunction
function cgt_anim_text:[动画类型]/[动画路径]/load {data:{text:"一小段话"}}
```

---

### 执行修饰

#### 全局动画

* 修饰要求：全局动画无需执行修饰，可以直接执行函数。

* 执行信息：执行者由服务器处理，执行位置默认原点。

* 显示对象：此模式下文本动画实例化过程中的报错与警告均对全部玩家展示。

* 关于声音：使用**execute as @a at @s**修饰声音播，放位置为全体玩家，并使用default音频文件组。

#### 本地动画

* 修饰要求：本地动画需要选择对应的玩家才能执行，执行者非玩家自动返回。

* 执行信息：执行者是该玩家，执行位置默认为玩家处。

* 显示对象：此模式下文本动画实例化过程中报错与警告只对执行者玩家展示。

* 关于声音：使用**execute at @s**修饰声音，播放位置为目标玩家，并使用default音频文件组。

#### 世界动画

* 修饰要求：世界动画需要选择执行维度、执行位置、执行朝向等一系列参数，就好比生成一个实体时所需的修饰，因此切记要选择好位置再编辑函数，开发者制作地图时也**务必多调试**。

* 执行信息：执行者为该实体的主目标实体，位置于生成处。

* 显示对象：此模式下文本动画实例化的报错与警告对全部玩家展示。

* 关于声音：使用**execute at @s**修饰声音，播放位置为主目标实体位置，并使用positional音频文件组。

---

### 具体示例

#### 全局动画

##### title与actionbar

###### 示例1

        目标：
        给所有玩家title栏播放金色文本“欢迎使用文本动画库”
        打字音效为2
        完成后执行命令，给最近玩家一个钻石

* 参数要求

    * text:{text:"欢迎使用文本动画库", color:"gold"}

    * sound:2

    * command:"give @p diamond"

* 具体函数

```mcfunction
function cgt_anim_text:global/title/load {data:{text:{text:"欢迎使用文本动画库", color:"gold"}, sound:2, command:"give @p diamond"}}
```

###### 示例2

        目标：
        给所有玩家actionbar栏播放从红到紫的渐变文本“文本动画库真棒”
        速度稍慢，取60
        结束后双向退格消失
        初始化不解析文本组件


* 参数要求

    * text:[{text:"文",color:"red"},{text:"本",color:"gold"},{text:"动",color:"yellow"},{text:"画",color:"green"},{text:"库",color:"aqua"},{text:"真",color:"blue"},{text:"棒",color:"light_purple"}]

    * speed:60

    * style:2

    * analyse:0b

* 具体函数

```mcfunction
function cgt_anim_text:global/actionbar/load {data:{text:[{text:"文",color:"red"},{text:"本",color:"gold"},{text:"动",color:"yellow"},{text:"画",color:"green"},{text:"库",color:"aqua"},{text:"真",color:"blue"},{text:"棒",color:"light_purple"}], speed:60, style:2, analyse:0b}}
```

##### subtitle

###### 示例1

        目标：
        给所有玩家subtitle栏播放金色文本“欢迎使用文本动画库”
        此时无正在播放的title

* 参数要求

    * text:{text:"欢迎使用文本动画库", color:"gold"}

    * title:0b

* 具体函数

```mcfunction
function cgt_anim_text:global/subtitle/load {data:{text:{text:"欢迎使用文本动画库", color:"gold"}, title:0b}}
```

###### 示例2

        目标：
        给所有玩家subtitle栏播放蓝色文本“世界你好……”
        此时有正在播放的title

* 参数要求

    * text:{text:"世界你好……", color:"blue"}

    * title:1b

* 具体函数

```mcfunction
function cgt_anim_text:global/subtitle/load {data:{text:{text:"世界你好……", color:"blue"}, title:1b}}
```

*如果你尝试在没有title的适合播放，会发现声音照常播放，而文字波出现，这就是title键值的作用*
详见上文**参数详解-独有参数-title值**。

#### 本地动画

你可以尝试直接复制上述示例，把**function cgt_anim_text:global/xxx**改为**function cgt_anim_text:local/xxx**，随后补充execute as命令选中玩家再执行，得到的效果应与上例相同，只不过文本声音与字幕只有指定玩家能看到。

#### 世界动画

##### typewriter

类似本地动画对全局动画示例的变更，把**function cgt_anim_text:global/xxx**改为**function cgt_anim_text:positional/typewriter**，随后补充execute命令选择执行位置、朝向等。

###### 示例

        目标：
        在世界(0,100,0)位置，朝向(0,0)，播放从红到紫的渐变文本“文本动画库真棒”
        速度稍快，取120
        结束后退格消失
        初始化不解析文本组件
        最大文本数为5
        展示实体背景设置为完全透明

* 参数要求

    * text:[{text:"文",color:"red"},{text:"本",color:"gold"},{text:"动",color:"yellow"},{text:"画",color:"green"},{text:"库",color:"aqua"},{text:"真",color:"blue"},{text:"棒",color:"light_purple"}]

    * speed:120

    * style:1

    * analyse:0b

    * width:5

    * entity_properties:{background:0}

* 具体函数

```mcfunction
execute positioned .0 100.0 .0 rotated .0 .0 run function cgt_anim_text:positional/typewriter/load {data:{text:[{text:"文",color:"red"},{text:"本",color:"gold"},{text:"动",color:"yellow"},{text:"画",color:"green"},{text:"库",color:"aqua"},{text:"真",color:"blue"},{text:"棒",color:"light_purple"}], speed:120, style:1, analyse:0b, width:5, entity_properties:{background:0}}}
```

##### animation

特效字幕模式，也称特效动画，是此数据包中效果最惊艳的部分。

###### 示例1

        目标：
        在世界(0,100,0)位置，朝向(0,0)，播放“文本动画库真棒”
        使用动画样式3（缩小出现）
        展示实体背景设置为完全透明
        结束后字幕正常淡去，不掉落

* 参数要求

    * text:{text:"文本动画库真棒"}

    * style:3

    * entity_properties:{background:0}

    * 无drop

* 具体函数

```mcfunction
execute positioned .0 100.0 .0 rotated .0 .0 run function cgt_anim_text:positional/animation/load {data:{text:{text:"文本动画库真棒"}, style:3, entity_properties:{background:0}}}
```

###### 示例2

        目标：
        在世界(0,100,0)位置，朝向(0,0)，播放“文本动画库真棒”
        使用动画样式11（下滑出现）
        结束后字幕掉落，初速度0.1，方向随机

* 参数要求

    * text:{text:"文本动画库真棒"}

    * style:11

    * drop:{motion:0.1}

* 具体函数

```mcfunction
execute positioned .0 100.0 .0 rotated .0 .0 run function cgt_anim_text:positional/animation/load {data:{text:{text:"文本动画库真棒"}, style:11, drop:{motion:0.1,direction:{x_rotation:{max:180, min:-180}, y_rotation:{max:180, min:-180}}}}}
```

###### 示例3

        目标：
        在世界(0,100,0)位置，朝向(0,0)，播放“文本动画库真棒”
        使用动画样式28（中心扩散淡入显现）
        结束后字幕掉落，初速度0 ~ 0.3，方向为字幕局部坐标系z轴正向（文本正前向）

* 参数要求

    * text:{text:"文本动画库真棒"}

    * style:28

    * drop:{motion:{max:0.3, min:0}, direction:{x_rotation:{max:0, min:0}, y_rotation:{max:0, min:0}}}

* 具体函数

```mcfunction
execute positioned .0 100.0 .0 rotated .0 .0 run function cgt_anim_text:positional/animation/load {data:{text:{text:"文本动画库真棒"}, style:28, drop:{motion:{max:0.3, min:0}, direction:{x_rotation:{max:0, min:0}, y_rotation:{max:0, min:0}}}}}
```

---

### 高级开发功能

#### 巧用文本解析

设想一下，你希望创建一段对话，在文本动画最初直接显示“<Steve> ”这样的人名字符头，可以怎么做？

我们发现，对于写入的字符串，经过文本组件解析后自动变成了零散的字符，这却和初衷相违背。因此，如果能直接将此字符头作为一个文本组件传入，就可以解决了。

不过如果要避免解析，则必须保证写入的文本组件格式无误，并且手动拆分后续每一个字符，这显然是不方便的，我们可以使用网站[渐变文本生成器](https://mcg.tuanzi.ink/)，快速生成已经拆分为列表形式的JSON格式或SNBT格式的文本组件。

最后，再把字符头放入列表第一位即可。

##### 示例

我从网站生成了如下对话文本：

```JSON
[{"text":"H","color":"#d9afd9"},{"text":"i","color":"#d5b1d9"},{"text":"艾","color":"#d1b4da"},{"text":"利","color":"#cdb6da"},{"text":"克","color":"#c9b9db"},{"text":"斯","color":"#c6bbdb"},{"text":"，","color":"#c2bedc"},{"text":"我","color":"#bec0dc"},{"text":"是","color":"#bac3dd"},{"text":"史","color":"#b6c5dd"},{"text":"蒂","color":"#b2c8de"},{"text":"夫","color":"#aecade"}]
```

将Steve名称字符头插入第一位

```JSON
[{"text":"<Steve> ","color":"#aaaaaa"},{"text":"H","color":"#d9afd9"},{"text":"i","color":"#d5b1d9"},{"text":"艾","color":"#d1b4da"},{"text":"利","color":"#cdb6da"},{"text":"克","color":"#c9b9db"},{"text":"斯","color":"#c6bbdb"},{"text":"，","color":"#c2bedc"},{"text":"我","color":"#bec0dc"},{"text":"是","color":"#bac3dd"},{"text":"史","color":"#b6c5dd"},{"text":"蒂","color":"#b2c8de"},{"text":"夫","color":"#aecade"}]
```

这样再实例化执行，就大功告成了！

#### 自定义文本组件格式

##### 组件类型

>Question：“我需要添加翻译组件、记分板组件、甚至精灵图组件，可以直接使用吗？”
>
>Answer：“当然可以，重制版数据包支持全部组件格式，包括提到的这三类，以及NBT组件、实体名称组件、键位绑定组件都可以！”

没错，数据包内文本组件支持**任意类型**，不影响使用，你可以直接将文本以translate组件展示，也可以输出分数……

##### 个性化组件

在上述的多类型组件使用过程中，可能遇到标点符号不能自动解析、延时的问题，甚至有时播放间隔过短。为了解决这些小缺点，数据包引入了**个性化组件**支持。

上面介绍了，对于一行文本，可以设置预设值，使用函数的data下的参数设置：

```mcfunction
function cgt_anim_text:[动画类型]/[动画路径]/load {data:{参数标签}}
```

而若想单独控制一个文本组件被播放时的音效与延迟，可以在**文本组件**的**复合标签形式**下填写参数

* delay：代表游戏播放到此组件时停顿游戏刻数，此数值与默认计算数值类似，受总参数speed倍率影响。

* sound：代表游戏播放到此组件时的声音，与前文所说的音频编码一致，如果不需要声音可以填写不存在的编码。

###### 示例

```mcfunction
function cgt_anim_text:global/actionbar/load {data:{text:[{text:"文",color:"red",sound:0},{text:"本",color:"gold",delay:10},{text:"动",color:"yellow",delay:10},{text:"画",color:"green",delay:10},{text:"库",color:"aqua"},{text:"真",color:"blue"},{text:"棒",color:"light_purple"}], speed:50}}
```

这条命令会播放与上述示例相同的动作栏文本——“文本动画库真棒”，而“文”字**无音效**，“本”“动”“画”三字有**较长延迟**（20游戏刻：10*2），其余以0.5倍速播放。

#### 创建存储打字

使用命令

```mcfunction
function cgt_anim_text:storage/output/load {[args]， id:"id"}
```

创建一个仅存储的打字计算进程，可以通过不断刷新任意位置的文本组件，写入数据

```SNBT
{storage:"minecraft:cgt_anim_text", nbt:"storage.output.output.[id]", interpret:true}
```

从而在更多文本组件位置实现打字效果。

---

### 设置项

#### 报错与警告

        *此条目只适用于高级开发者

如果不希望任何玩家看到报错信息与警告信息，可以使用命令更改

报错信息开关：0为关闭 1为打开

```mcfunction
scoreboard players set #settings.tip.error cgt.AnimText.storage 0/1
```

警告信息开关：0为关闭 1为打开

```mcfunction
scoreboard players set #settings.tip.warn cgt.AnimText.storage 0/1
```

---

## 遇到的问题

##### 为什么初始化文本动画时，显示实例化函数缺少传入参数data？

> 请见前文**使用方法-初始化函数-实例化参数要求**，明确说明参数形式，必须嵌套一层data标签

##### 为什么执行函数未报错，但是我看不见文本？

> 检查是否使用本地动画或世界动画（local、positional），具体请见前文**使用方法-执行修饰**，检查是否正确选择了执行位置，执行实体等。
>
> 以及需要检查是否禁用了报错、警告提示，确保提示设置项打开，再执行。

##### 为什么文本出现但没有声音？

> 检查传入的音频编码是否正确，以及如果有自定义音效，请务必确保正确地给玩家播放了声音，对于不同文本类型（global、local、positional）有不同的音频文件，详见**使用方法-执行修饰**。检查自定义音频的命令是否与默认命令格式一致。

##### 为什么特效播放时有个别展示实体好像卡住了？

> Mojang的代码发力了，在插值动画时有概率卡住，具体原理暂不清楚，如果卡顿频繁就重进一下游戏，或许可以缓解。

---

## 制作鸣谢

> [纸圆Paper](https://x.com/CricelPaper)
> [凛冬初十](https://space.bilibili.com/437726454)
> [烦伪](https://space.bilibili.com/418369418)
> 
> [Axiom Mod](https://https://modrinth.com/mod/axiom)
> [DatapackHelperPlus](https://marketplace.visualstudio.com/items?itemName=SPGoding.datapack-language-server)
> [PCL2](https://afdian.com/a/LTCat)
> [Minecraft 渐变文字生成器](https://mcg.tuanzi.ink)
> [MinecraftWiki](https://zh.minecraft.wiki)

## 总结与展望

* 数据包完全免费开源，且完全重置，[点此查看更新](https://wwbol.lanzout.com/b00cskhlpa)，密码：cul6
* 合作与Bug反馈请移步[CoolGaston个人空间](https://space.bilibili.com/648638421)私聊作者
* 最后，衷心希望此资源库数据包能为各位开发者的地图创作带来便利！