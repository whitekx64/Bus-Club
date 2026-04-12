extends Control

var tween : Tween

func _ready() -> void:
	GlobalEvent.show_interact.connect(_show)
	GlobalEvent.hide_interact.connect(_hide)
	hide()
	modulate.a = 0

func _show(ui_text):
	$Label.text = ui_text
	if tween:
		tween.kill()
	tween = create_tween()
	show()
	tween.tween_property(self, "modulate:a", 1, 0.03)
func _hide():
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property(self, "modulate:a", 0, 0.03)
	await tween.finished
	hide()
