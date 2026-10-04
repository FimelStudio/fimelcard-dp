function decrypto:prompt/authorize
execute unless score #form_ok dc_ctx matches 1 run return 0
function decrypto:prompt/give_tool
execute as @e[tag=dc.form_controller,limit=1] run function decrypto:prompt/build
function decrypto:prompt/show with storage decrypto:form
tag @e[tag=dc.form_controller] remove dc.form_controller
