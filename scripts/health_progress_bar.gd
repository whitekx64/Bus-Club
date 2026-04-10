extends TextureProgressBar

var tween :Tween

func _ready() -> void:
	value = GameState.health
	max_value = GameState.max_hp
	
	GlobalEvent.player_change_hp.connect(_on_hp_changed)
		
func _on_hp_changed(_amount):
	if tween:
		tween.kill()
	tween = create_tween()
	tween.tween_property($".", "value", GameState.health, 0.3)\
		.set_trans(Tween.TRANS_SINE)\
		.set_ease(Tween.EASE_IN_OUT)
