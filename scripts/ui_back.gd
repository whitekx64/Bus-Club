extends Control

var tween : Tween

func _ready() -> void:
	$AnimationPlayer.set_current_animation("idle")
	GlobalEvent.player_change_money.connect(_on_money_changed)
	
func _on_money_changed(amount):
	if tween:
		tween.kill()
	tween = create_tween()
	var local_scale = $Control.scale.x
	if amount <= 0:
		tween.tween_property($Control, "scale", Vector2(local_scale -0.05, local_scale -0.05), 0.1)
		tween.tween_property($Control, "scale", Vector2(local_scale +0.05, local_scale +0.05), 0.1)
	else:
		tween.tween_property($Control, "scale", Vector2(local_scale +0.05, local_scale +0.05), 0.1)
		tween.tween_property($Control, "scale", Vector2(local_scale -0.05, local_scale -0.05), 0.1)

func _process(delta: float) -> void:
	var local_scale
	if Input.is_action_pressed("sprint"):
		local_scale = clamp(lerp($Control.scale.x, $Control.scale.x - 0.05, 30 * delta), 0.9, 1)
		$Control.scale = Vector2(local_scale, local_scale)
	else:
		local_scale = clamp(lerp($Control.scale.x, $Control.scale.x + 0.05, 10 * delta), 0.9, 1)
		$Control.scale = Vector2(local_scale, local_scale)
