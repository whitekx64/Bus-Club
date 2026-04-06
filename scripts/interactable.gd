extends Area3D

class_name Interactable

@export var can_interact : bool
@export var ui_text : String

func interact():
	if not can_interact:
		return
