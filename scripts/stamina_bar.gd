extends TextureProgressBar

func _ready() -> void:
	value = GameState.health
	max_value = GameState.max_stamina

func _process(delta: float) -> void:
	value = lerp(value, GameState.stamina, 10 * delta)
