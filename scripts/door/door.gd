extends Interactable

var material = preload("res://materials/door/material_0.tres")
var outline = preload("res://materials/outline/outline.gdshader")
var loc_material: StandardMaterial3D

func _ready() -> void:
	loc_material = material.duplicate()

func interact():
	$Marker3D/blockbench_export/AnimationPlayer.play("open")
	can_interact = false
	$Marker3D/blockbench_export/StaticBody3D/CollisionShape3D.disabled = true
	await get_tree().create_timer(3.5).timeout
	$Marker3D/blockbench_export/AnimationPlayer.play_backwards("open")
	await $Marker3D/blockbench_export/AnimationPlayer.animation_finished
	$Marker3D/blockbench_export/StaticBody3D/CollisionShape3D.disabled = false
	can_interact = true
