function gomoku:system/context
scoreboard players set #nineteen gm_ctx 19
scoreboard players set #minus gm_ctx -1
scoreboard players operation #size gm_ctx = @s gm_size
scoreboard players operation #side gm_ctx = @s gm_turn
scoreboard players set #cache_ok gm_ctx 0
execute if score #size gm_ctx matches 13 run scoreboard players set #cache_ok gm_ctx 1
execute if score #size gm_ctx matches 15 run scoreboard players set #cache_ok gm_ctx 1
execute if score #size gm_ctx matches 19 run scoreboard players set #cache_ok gm_ctx 1
execute unless score #side gm_ctx matches -1 unless score #side gm_ctx matches 1 run scoreboard players set #cache_ok gm_ctx 0
scoreboard players operation #expected gm_ctx = #size gm_ctx
scoreboard players operation #expected gm_ctx *= #size gm_ctx
execute store result score #actual gm_ctx if entity @e[type=minecraft:marker,tag=gm.board]
execute unless score #actual gm_ctx = #expected gm_ctx run scoreboard players set #cache_ok gm_ctx 0
execute as @e[type=minecraft:marker,tag=gm.board] unless score @s gm_piece matches -1..1 run scoreboard players set #cache_ok gm_ctx 0

scoreboard players set #b0 gm_ctx -2
execute if score #size gm_ctx matches 1.. run function gomoku:engine/cache_cell/0

scoreboard players set #b1 gm_ctx -2
execute if score #size gm_ctx matches 2.. run function gomoku:engine/cache_cell/1

scoreboard players set #b2 gm_ctx -2
execute if score #size gm_ctx matches 3.. run function gomoku:engine/cache_cell/2

scoreboard players set #b3 gm_ctx -2
execute if score #size gm_ctx matches 4.. run function gomoku:engine/cache_cell/3

scoreboard players set #b4 gm_ctx -2
execute if score #size gm_ctx matches 5.. run function gomoku:engine/cache_cell/4

scoreboard players set #b5 gm_ctx -2
execute if score #size gm_ctx matches 6.. run function gomoku:engine/cache_cell/5

scoreboard players set #b6 gm_ctx -2
execute if score #size gm_ctx matches 7.. run function gomoku:engine/cache_cell/6

scoreboard players set #b7 gm_ctx -2
execute if score #size gm_ctx matches 8.. run function gomoku:engine/cache_cell/7

scoreboard players set #b8 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/8

scoreboard players set #b9 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/9

scoreboard players set #b10 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/10

scoreboard players set #b11 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/11

scoreboard players set #b12 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/12

scoreboard players set #b13 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/13

scoreboard players set #b14 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/14

scoreboard players set #b15 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/15

scoreboard players set #b16 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/16

scoreboard players set #b17 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/17

scoreboard players set #b18 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/18

scoreboard players set #b19 gm_ctx -2
execute if score #size gm_ctx matches 2.. run function gomoku:engine/cache_cell/19

scoreboard players set #b20 gm_ctx -2
execute if score #size gm_ctx matches 2.. run function gomoku:engine/cache_cell/20

scoreboard players set #b21 gm_ctx -2
execute if score #size gm_ctx matches 3.. run function gomoku:engine/cache_cell/21

scoreboard players set #b22 gm_ctx -2
execute if score #size gm_ctx matches 4.. run function gomoku:engine/cache_cell/22

scoreboard players set #b23 gm_ctx -2
execute if score #size gm_ctx matches 5.. run function gomoku:engine/cache_cell/23

scoreboard players set #b24 gm_ctx -2
execute if score #size gm_ctx matches 6.. run function gomoku:engine/cache_cell/24

scoreboard players set #b25 gm_ctx -2
execute if score #size gm_ctx matches 7.. run function gomoku:engine/cache_cell/25

scoreboard players set #b26 gm_ctx -2
execute if score #size gm_ctx matches 8.. run function gomoku:engine/cache_cell/26

scoreboard players set #b27 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/27

scoreboard players set #b28 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/28

scoreboard players set #b29 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/29

scoreboard players set #b30 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/30

scoreboard players set #b31 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/31

scoreboard players set #b32 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/32

scoreboard players set #b33 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/33

scoreboard players set #b34 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/34

scoreboard players set #b35 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/35

scoreboard players set #b36 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/36

scoreboard players set #b37 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/37

scoreboard players set #b38 gm_ctx -2
execute if score #size gm_ctx matches 3.. run function gomoku:engine/cache_cell/38

scoreboard players set #b39 gm_ctx -2
execute if score #size gm_ctx matches 3.. run function gomoku:engine/cache_cell/39

scoreboard players set #b40 gm_ctx -2
execute if score #size gm_ctx matches 3.. run function gomoku:engine/cache_cell/40

scoreboard players set #b41 gm_ctx -2
execute if score #size gm_ctx matches 4.. run function gomoku:engine/cache_cell/41

scoreboard players set #b42 gm_ctx -2
execute if score #size gm_ctx matches 5.. run function gomoku:engine/cache_cell/42

scoreboard players set #b43 gm_ctx -2
execute if score #size gm_ctx matches 6.. run function gomoku:engine/cache_cell/43

scoreboard players set #b44 gm_ctx -2
execute if score #size gm_ctx matches 7.. run function gomoku:engine/cache_cell/44

scoreboard players set #b45 gm_ctx -2
execute if score #size gm_ctx matches 8.. run function gomoku:engine/cache_cell/45

scoreboard players set #b46 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/46

scoreboard players set #b47 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/47

scoreboard players set #b48 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/48

scoreboard players set #b49 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/49

scoreboard players set #b50 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/50

scoreboard players set #b51 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/51

scoreboard players set #b52 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/52

scoreboard players set #b53 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/53

scoreboard players set #b54 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/54

scoreboard players set #b55 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/55

scoreboard players set #b56 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/56

scoreboard players set #b57 gm_ctx -2
execute if score #size gm_ctx matches 4.. run function gomoku:engine/cache_cell/57

scoreboard players set #b58 gm_ctx -2
execute if score #size gm_ctx matches 4.. run function gomoku:engine/cache_cell/58

scoreboard players set #b59 gm_ctx -2
execute if score #size gm_ctx matches 4.. run function gomoku:engine/cache_cell/59

scoreboard players set #b60 gm_ctx -2
execute if score #size gm_ctx matches 4.. run function gomoku:engine/cache_cell/60

scoreboard players set #b61 gm_ctx -2
execute if score #size gm_ctx matches 5.. run function gomoku:engine/cache_cell/61

scoreboard players set #b62 gm_ctx -2
execute if score #size gm_ctx matches 6.. run function gomoku:engine/cache_cell/62

scoreboard players set #b63 gm_ctx -2
execute if score #size gm_ctx matches 7.. run function gomoku:engine/cache_cell/63

scoreboard players set #b64 gm_ctx -2
execute if score #size gm_ctx matches 8.. run function gomoku:engine/cache_cell/64

scoreboard players set #b65 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/65

scoreboard players set #b66 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/66

scoreboard players set #b67 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/67

scoreboard players set #b68 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/68

scoreboard players set #b69 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/69

scoreboard players set #b70 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/70

scoreboard players set #b71 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/71

scoreboard players set #b72 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/72

scoreboard players set #b73 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/73

scoreboard players set #b74 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/74

scoreboard players set #b75 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/75

scoreboard players set #b76 gm_ctx -2
execute if score #size gm_ctx matches 5.. run function gomoku:engine/cache_cell/76

scoreboard players set #b77 gm_ctx -2
execute if score #size gm_ctx matches 5.. run function gomoku:engine/cache_cell/77

scoreboard players set #b78 gm_ctx -2
execute if score #size gm_ctx matches 5.. run function gomoku:engine/cache_cell/78

scoreboard players set #b79 gm_ctx -2
execute if score #size gm_ctx matches 5.. run function gomoku:engine/cache_cell/79

scoreboard players set #b80 gm_ctx -2
execute if score #size gm_ctx matches 5.. run function gomoku:engine/cache_cell/80

scoreboard players set #b81 gm_ctx -2
execute if score #size gm_ctx matches 6.. run function gomoku:engine/cache_cell/81

scoreboard players set #b82 gm_ctx -2
execute if score #size gm_ctx matches 7.. run function gomoku:engine/cache_cell/82

scoreboard players set #b83 gm_ctx -2
execute if score #size gm_ctx matches 8.. run function gomoku:engine/cache_cell/83

scoreboard players set #b84 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/84

scoreboard players set #b85 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/85

scoreboard players set #b86 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/86

scoreboard players set #b87 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/87

scoreboard players set #b88 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/88

scoreboard players set #b89 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/89

scoreboard players set #b90 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/90

scoreboard players set #b91 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/91

scoreboard players set #b92 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/92

scoreboard players set #b93 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/93

scoreboard players set #b94 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/94

scoreboard players set #b95 gm_ctx -2
execute if score #size gm_ctx matches 6.. run function gomoku:engine/cache_cell/95

scoreboard players set #b96 gm_ctx -2
execute if score #size gm_ctx matches 6.. run function gomoku:engine/cache_cell/96

scoreboard players set #b97 gm_ctx -2
execute if score #size gm_ctx matches 6.. run function gomoku:engine/cache_cell/97

scoreboard players set #b98 gm_ctx -2
execute if score #size gm_ctx matches 6.. run function gomoku:engine/cache_cell/98

scoreboard players set #b99 gm_ctx -2
execute if score #size gm_ctx matches 6.. run function gomoku:engine/cache_cell/99

scoreboard players set #b100 gm_ctx -2
execute if score #size gm_ctx matches 6.. run function gomoku:engine/cache_cell/100

scoreboard players set #b101 gm_ctx -2
execute if score #size gm_ctx matches 7.. run function gomoku:engine/cache_cell/101

scoreboard players set #b102 gm_ctx -2
execute if score #size gm_ctx matches 8.. run function gomoku:engine/cache_cell/102

scoreboard players set #b103 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/103

scoreboard players set #b104 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/104

scoreboard players set #b105 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/105

scoreboard players set #b106 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/106

scoreboard players set #b107 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/107

scoreboard players set #b108 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/108

scoreboard players set #b109 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/109

scoreboard players set #b110 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/110

scoreboard players set #b111 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/111

scoreboard players set #b112 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/112

scoreboard players set #b113 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/113

scoreboard players set #b114 gm_ctx -2
execute if score #size gm_ctx matches 7.. run function gomoku:engine/cache_cell/114

scoreboard players set #b115 gm_ctx -2
execute if score #size gm_ctx matches 7.. run function gomoku:engine/cache_cell/115

scoreboard players set #b116 gm_ctx -2
execute if score #size gm_ctx matches 7.. run function gomoku:engine/cache_cell/116

scoreboard players set #b117 gm_ctx -2
execute if score #size gm_ctx matches 7.. run function gomoku:engine/cache_cell/117

scoreboard players set #b118 gm_ctx -2
execute if score #size gm_ctx matches 7.. run function gomoku:engine/cache_cell/118

scoreboard players set #b119 gm_ctx -2
execute if score #size gm_ctx matches 7.. run function gomoku:engine/cache_cell/119

scoreboard players set #b120 gm_ctx -2
execute if score #size gm_ctx matches 7.. run function gomoku:engine/cache_cell/120

scoreboard players set #b121 gm_ctx -2
execute if score #size gm_ctx matches 8.. run function gomoku:engine/cache_cell/121

scoreboard players set #b122 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/122

scoreboard players set #b123 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/123

scoreboard players set #b124 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/124

scoreboard players set #b125 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/125

scoreboard players set #b126 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/126

scoreboard players set #b127 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/127

scoreboard players set #b128 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/128

scoreboard players set #b129 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/129

scoreboard players set #b130 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/130

scoreboard players set #b131 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/131

scoreboard players set #b132 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/132

scoreboard players set #b133 gm_ctx -2
execute if score #size gm_ctx matches 8.. run function gomoku:engine/cache_cell/133

scoreboard players set #b134 gm_ctx -2
execute if score #size gm_ctx matches 8.. run function gomoku:engine/cache_cell/134

scoreboard players set #b135 gm_ctx -2
execute if score #size gm_ctx matches 8.. run function gomoku:engine/cache_cell/135

scoreboard players set #b136 gm_ctx -2
execute if score #size gm_ctx matches 8.. run function gomoku:engine/cache_cell/136

scoreboard players set #b137 gm_ctx -2
execute if score #size gm_ctx matches 8.. run function gomoku:engine/cache_cell/137

scoreboard players set #b138 gm_ctx -2
execute if score #size gm_ctx matches 8.. run function gomoku:engine/cache_cell/138

scoreboard players set #b139 gm_ctx -2
execute if score #size gm_ctx matches 8.. run function gomoku:engine/cache_cell/139

scoreboard players set #b140 gm_ctx -2
execute if score #size gm_ctx matches 8.. run function gomoku:engine/cache_cell/140

scoreboard players set #b141 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/141

scoreboard players set #b142 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/142

scoreboard players set #b143 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/143

scoreboard players set #b144 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/144

scoreboard players set #b145 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/145

scoreboard players set #b146 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/146

scoreboard players set #b147 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/147

scoreboard players set #b148 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/148

scoreboard players set #b149 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/149

scoreboard players set #b150 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/150

scoreboard players set #b151 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/151

scoreboard players set #b152 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/152

scoreboard players set #b153 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/153

scoreboard players set #b154 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/154

scoreboard players set #b155 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/155

scoreboard players set #b156 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/156

scoreboard players set #b157 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/157

scoreboard players set #b158 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/158

scoreboard players set #b159 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/159

scoreboard players set #b160 gm_ctx -2
execute if score #size gm_ctx matches 9.. run function gomoku:engine/cache_cell/160

scoreboard players set #b161 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/161

scoreboard players set #b162 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/162

scoreboard players set #b163 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/163

scoreboard players set #b164 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/164

scoreboard players set #b165 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/165

scoreboard players set #b166 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/166

scoreboard players set #b167 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/167

scoreboard players set #b168 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/168

scoreboard players set #b169 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/169

scoreboard players set #b170 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/170

scoreboard players set #b171 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/171

scoreboard players set #b172 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/172

scoreboard players set #b173 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/173

scoreboard players set #b174 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/174

scoreboard players set #b175 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/175

scoreboard players set #b176 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/176

scoreboard players set #b177 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/177

scoreboard players set #b178 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/178

scoreboard players set #b179 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/179

scoreboard players set #b180 gm_ctx -2
execute if score #size gm_ctx matches 10.. run function gomoku:engine/cache_cell/180

scoreboard players set #b181 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/181

scoreboard players set #b182 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/182

scoreboard players set #b183 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/183

scoreboard players set #b184 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/184

scoreboard players set #b185 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/185

scoreboard players set #b186 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/186

scoreboard players set #b187 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/187

scoreboard players set #b188 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/188

scoreboard players set #b189 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/189

scoreboard players set #b190 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/190

scoreboard players set #b191 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/191

scoreboard players set #b192 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/192

scoreboard players set #b193 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/193

scoreboard players set #b194 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/194

scoreboard players set #b195 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/195

scoreboard players set #b196 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/196

scoreboard players set #b197 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/197

scoreboard players set #b198 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/198

scoreboard players set #b199 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/199

scoreboard players set #b200 gm_ctx -2
execute if score #size gm_ctx matches 11.. run function gomoku:engine/cache_cell/200

scoreboard players set #b201 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/201

scoreboard players set #b202 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/202

scoreboard players set #b203 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/203

scoreboard players set #b204 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/204

scoreboard players set #b205 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/205

scoreboard players set #b206 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/206

scoreboard players set #b207 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/207

scoreboard players set #b208 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/208

scoreboard players set #b209 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/209

scoreboard players set #b210 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/210

scoreboard players set #b211 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/211

scoreboard players set #b212 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/212

scoreboard players set #b213 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/213

scoreboard players set #b214 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/214

scoreboard players set #b215 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/215

scoreboard players set #b216 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/216

scoreboard players set #b217 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/217

scoreboard players set #b218 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/218

scoreboard players set #b219 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/219

scoreboard players set #b220 gm_ctx -2
execute if score #size gm_ctx matches 12.. run function gomoku:engine/cache_cell/220

scoreboard players set #b221 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/221

scoreboard players set #b222 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/222

scoreboard players set #b223 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/223

scoreboard players set #b224 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/224

scoreboard players set #b225 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/225

scoreboard players set #b226 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/226

scoreboard players set #b227 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/227

scoreboard players set #b228 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/228

scoreboard players set #b229 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/229

scoreboard players set #b230 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/230

scoreboard players set #b231 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/231

scoreboard players set #b232 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/232

scoreboard players set #b233 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/233

scoreboard players set #b234 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/234

scoreboard players set #b235 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/235

scoreboard players set #b236 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/236

scoreboard players set #b237 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/237

scoreboard players set #b238 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/238

scoreboard players set #b239 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/239

scoreboard players set #b240 gm_ctx -2
execute if score #size gm_ctx matches 13.. run function gomoku:engine/cache_cell/240

scoreboard players set #b241 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/241

scoreboard players set #b242 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/242

scoreboard players set #b243 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/243

scoreboard players set #b244 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/244

scoreboard players set #b245 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/245

scoreboard players set #b246 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/246

scoreboard players set #b247 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/247

scoreboard players set #b248 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/248

scoreboard players set #b249 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/249

scoreboard players set #b250 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/250

scoreboard players set #b251 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/251

scoreboard players set #b252 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/252

scoreboard players set #b253 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/253

scoreboard players set #b254 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/254

scoreboard players set #b255 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/255

scoreboard players set #b256 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/256

scoreboard players set #b257 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/257

scoreboard players set #b258 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/258

scoreboard players set #b259 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/259

scoreboard players set #b260 gm_ctx -2
execute if score #size gm_ctx matches 14.. run function gomoku:engine/cache_cell/260

scoreboard players set #b261 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/261

scoreboard players set #b262 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/262

scoreboard players set #b263 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/263

scoreboard players set #b264 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/264

scoreboard players set #b265 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/265

scoreboard players set #b266 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/266

scoreboard players set #b267 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/267

scoreboard players set #b268 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/268

scoreboard players set #b269 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/269

scoreboard players set #b270 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/270

scoreboard players set #b271 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/271

scoreboard players set #b272 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/272

scoreboard players set #b273 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/273

scoreboard players set #b274 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/274

scoreboard players set #b275 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/275

scoreboard players set #b276 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/276

scoreboard players set #b277 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/277

scoreboard players set #b278 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/278

scoreboard players set #b279 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/279

scoreboard players set #b280 gm_ctx -2
execute if score #size gm_ctx matches 15.. run function gomoku:engine/cache_cell/280

scoreboard players set #b281 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/281

scoreboard players set #b282 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/282

scoreboard players set #b283 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/283

scoreboard players set #b284 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/284

scoreboard players set #b285 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/285

scoreboard players set #b286 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/286

scoreboard players set #b287 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/287

scoreboard players set #b288 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/288

scoreboard players set #b289 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/289

scoreboard players set #b290 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/290

scoreboard players set #b291 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/291

scoreboard players set #b292 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/292

scoreboard players set #b293 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/293

scoreboard players set #b294 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/294

scoreboard players set #b295 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/295

scoreboard players set #b296 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/296

scoreboard players set #b297 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/297

scoreboard players set #b298 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/298

scoreboard players set #b299 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/299

scoreboard players set #b300 gm_ctx -2
execute if score #size gm_ctx matches 16.. run function gomoku:engine/cache_cell/300

scoreboard players set #b301 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/301

scoreboard players set #b302 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/302

scoreboard players set #b303 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/303

scoreboard players set #b304 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/304

scoreboard players set #b305 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/305

scoreboard players set #b306 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/306

scoreboard players set #b307 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/307

scoreboard players set #b308 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/308

scoreboard players set #b309 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/309

scoreboard players set #b310 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/310

scoreboard players set #b311 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/311

scoreboard players set #b312 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/312

scoreboard players set #b313 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/313

scoreboard players set #b314 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/314

scoreboard players set #b315 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/315

scoreboard players set #b316 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/316

scoreboard players set #b317 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/317

scoreboard players set #b318 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/318

scoreboard players set #b319 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/319

scoreboard players set #b320 gm_ctx -2
execute if score #size gm_ctx matches 17.. run function gomoku:engine/cache_cell/320

scoreboard players set #b321 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/321

scoreboard players set #b322 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/322

scoreboard players set #b323 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/323

scoreboard players set #b324 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/324

scoreboard players set #b325 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/325

scoreboard players set #b326 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/326

scoreboard players set #b327 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/327

scoreboard players set #b328 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/328

scoreboard players set #b329 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/329

scoreboard players set #b330 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/330

scoreboard players set #b331 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/331

scoreboard players set #b332 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/332

scoreboard players set #b333 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/333

scoreboard players set #b334 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/334

scoreboard players set #b335 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/335

scoreboard players set #b336 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/336

scoreboard players set #b337 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/337

scoreboard players set #b338 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/338

scoreboard players set #b339 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/339

scoreboard players set #b340 gm_ctx -2
execute if score #size gm_ctx matches 18.. run function gomoku:engine/cache_cell/340

scoreboard players set #b341 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/341

scoreboard players set #b342 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/342

scoreboard players set #b343 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/343

scoreboard players set #b344 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/344

scoreboard players set #b345 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/345

scoreboard players set #b346 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/346

scoreboard players set #b347 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/347

scoreboard players set #b348 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/348

scoreboard players set #b349 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/349

scoreboard players set #b350 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/350

scoreboard players set #b351 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/351

scoreboard players set #b352 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/352

scoreboard players set #b353 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/353

scoreboard players set #b354 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/354

scoreboard players set #b355 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/355

scoreboard players set #b356 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/356

scoreboard players set #b357 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/357

scoreboard players set #b358 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/358

scoreboard players set #b359 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/359

scoreboard players set #b360 gm_ctx -2
execute if score #size gm_ctx matches 19.. run function gomoku:engine/cache_cell/360
