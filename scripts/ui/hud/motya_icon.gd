extends Control

var tween :Tween

func _ready() -> void:
	hp_sync()
	$AnimationPlayer.set_current_animation("idle")
	GlobalEvent.player_change_hp.connect(_on_hp_changed)

func hp_sync():
	if GameState.health >= GameState.max_hp * 0.7:
		$AnimatedSprite2D.set_animation("high")
	elif GameState.health <= GameState.max_hp * 0.15:
		$AnimatedSprite2D.set_animation("low")
	else:
		$AnimatedSprite2D.set_animation("medium")

func _on_hp_changed(amount):
	hp_sync()
	if tween:
		tween.kill()
	tween = create_tween()
	if amount <= 0:
		tween.tween_property($AnimatedSprite2D, "scale", Vector2(0.95, 0.95), 0.1)
		tween.tween_property($AnimatedSprite2D, "scale", Vector2(1.0, 1.0), 0.1)
	else:
		tween.tween_property($AnimatedSprite2D, "scale", Vector2(1.05, 1.05), 0.1)
		tween.tween_property($AnimatedSprite2D, "scale", Vector2(1.0, 1.0), 0.1)

func _on_timer_timeout() -> void:
	$AnimatedSprite2D.play()
