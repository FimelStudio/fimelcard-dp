# This is the shared output adapter; no game-operation dialog is opened.
data modify storage avalon:chat lines set from storage avalon:ui dialog.body
data modify storage avalon:chat actions set from storage avalon:ui dialog.actions
function avalon:chat/lines
function avalon:chat/actions
