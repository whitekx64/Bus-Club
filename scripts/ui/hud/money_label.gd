extends Control

var tween : Tween
var saved_value: int = GameState.money
func _ready() -> void:
	GlobalEvent.player_change_money.connect(_on_money_changed)
	$Label.text = str(saved_value)

func _on_money_changed(_amount):
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_method(_set_text, saved_value, GameState.money, 1)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
	await tween.finished
	saved_value = GameState.money 
func _set_text(value :int):
	$Label.text = str(value)
