extends Node3D

@onready var camere = get_viewport().get_camera_3d()
@onready var head = $blockbench_export/meow/torso/head
@onready var anim_player = $blockbench_export/AnimationPlayer

func _ready() -> void:
	anim_player.play("idle")

func _process(_delta: float) -> void:
	var mouse_pos = get_viewport().get_mouse_position()
	var mouse_3d = camere.project_position(mouse_pos, 0.8)
	
	head.look_at(mouse_3d)
