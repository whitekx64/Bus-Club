extends TextureButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = Vector2(3, 3)
func _on_button_up() -> void:
	scale = Vector2(3, 3)

func _on_button_down() -> void:
	scale = Vector2(2.7, 2.7)
	
	get_tree().quit()
