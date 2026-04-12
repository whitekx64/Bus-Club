extends TextureButton

func _on_button_up() -> void:
	scale = Vector2(3, 3)

func _on_button_down() -> void:
	scale = Vector2(2.7, 2.7)
	OS.shell_open("https://t.me/whitekxdev")
