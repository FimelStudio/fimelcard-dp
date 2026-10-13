
# 新部分

data modify storage fimel_title:io text_buffer append value {text:"", font:"", extra:[]}
data modify storage fimel_title:io text_buffer[-1].extra append from storage fimel_title:io text
data modify storage fimel_title:io text_buffer[-1].font set from storage fimel_title:io font

data modify storage fimel_title:io neg_text_buffer append value {text:"", font:"",extra:[]}
data modify storage fimel_title:io neg_text_buffer[-1].extra append from storage fimel_title:io text
data modify storage fimel_title:io neg_text_buffer[-1].font set from storage fimel_title:io neg_font

