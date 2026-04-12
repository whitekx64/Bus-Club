extends TextureProgressBar

var tween : Tween

func _ready() -> void:
	value = GameState.hunger
	GlobalEvent.player_change_hunger.connect(_on_hunger_changed)
	
func _on_hunger_changed(_amount):
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property($".", "value", GameState.hunger, 0.3)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
