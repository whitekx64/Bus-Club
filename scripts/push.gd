extends Control

func _ready() -> void:
	GlobalEvent.show_interact.connect(_show)
	GlobalEvent.hide_interact.connect(_hide)
	hide()
	
func _show(ui_text):
	$Label.text = ui_text
	show()
func _hide():
	hide()
