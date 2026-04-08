extends TextureProgressBar

var tween :Tween

func _ready() -> void:
	max_value = GameState.max_stamina

func _process(delta: float) -> void:
	value = lerp(value, GameState.stamina, 10 * delta)
