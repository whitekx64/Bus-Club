extends Control


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

func _on_hp_changed(_amount):
	hp_sync()


func _on_timer_timeout() -> void:
	$AnimatedSprite2D.play()
