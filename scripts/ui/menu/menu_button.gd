extends TextureButton

enum Type {NEW_GAME, CONTINUE, SETTINGS}

@export var current_type : Type

func _ready() -> void:
	match current_type:
		Type.NEW_GAME:
			$Label.text = "Новая игра"
		Type.CONTINUE:
			$Label.text = "Продолжить"
		Type.SETTINGS:
			$Label.text = "Настройки"
	if disabled:
		print(":3")
		self.material.set_shader_parameter("saturation", 0)

func _on_button_up() -> void:
	scale = Vector2(1, 1)

func _on_button_down() -> void:
	scale = Vector2(0.9, 0.9)
	
	match current_type:
		Type.NEW_GAME:
			get_tree().change_scene_to_file("res://levels/test_map.tscn")
		Type.SETTINGS:
			get_tree().change_scene_to_file("res://scenes/ui/settings/settings.tscn")
