extends CanvasLayer

var loc_ui = preload("res://scenes/select_location.tscn")
var loc_ui_stat = false

func _ready() -> void:
	GlobalEvent.location_ui.connect(_on_loc_ui)

func loc_ui_del():
	for child in get_children():
		if child is Panel:
			child.queue_free()
			loc_ui_stat = false

func _on_loc_ui(reason):
	match reason:
		GameData.ExitReason.BUTTON:
			if not loc_ui_stat:
				var loc_ui_spawn = loc_ui.instantiate()
				add_child(loc_ui_spawn)
				loc_ui_stat = true
				Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			else:
				loc_ui_del()
				Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		GameData.ExitReason.EXITED:
			loc_ui_del()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
