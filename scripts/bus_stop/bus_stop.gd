extends Interactable


func interact():
	GlobalEvent.location_ui.emit(GameData.ExitReason.BUTTON)


func _on_area_exited(_area: Area3D) -> void:
	GlobalEvent.location_ui.emit(GameData.ExitReason.EXITED)
