$data modify storage decrypto:form dialog.body[0].contents set value {text:"本轮密码：$(d1)－$(d2)－$(d3)    下方为己方1—4号词条：",color:"gold"}
$data modify storage decrypto:form dialog.inputs[0].label set value {text:"$(d1)：",color:"gold"}
$data modify storage decrypto:form dialog.inputs[1].label set value {text:"$(d2)：",color:"gold"}
$data modify storage decrypto:form dialog.inputs[2].label set value {text:"$(d3)：",color:"gold"}
$data modify storage decrypto:form dialog.yes.action.template set value "function decrypto:prompt/submit {p:{a:'$(a)',b:'$(b)',c:'$(c)',t:$(table),n:$(token)}}"
