extends Panel

func change(path):
	if get_tree().current_scene.scene_file_path != path:
		get_tree().change_scene_to_file(path)
	else:
		return


func _on_test1_pressed() -> void:
	change("res://levels/test_map.tscn")

func _on_test2_pressed() -> void:
	change("res://levels/test_map2.tscn")
