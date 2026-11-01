$data modify storage ito:form dialog.inputs[0].label.text set value "手牌$(slot) · 数字$(number)"
$data modify storage ito:form dialog.yes.action.template set value "function ito:form/submit {p:{a:'$(a)',t:$(table),e:$(epoch),s:$(slot),n:$(token)}}"
