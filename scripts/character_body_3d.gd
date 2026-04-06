extends CharacterBody3D

@onready var anim_tree = $mesh/AnimationTree2.get("parameters/playback")
@export var sensitivity = 0.01
@export var jump = 3.0
@export var acceleration = 10.0
@export var friction = 15.0
@export var tar_zoom :float = 3.0
var can_move = true
var was_in_air = false
var standart_speed = 3.0
var speed
var slowdown = false
var location_ui_status = false

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	# Движение мыши
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		$campivot.rotate_y(-event.relative.x * sensitivity)
		$campivot/SpringArm3D.rotate_x(-event.relative.y * sensitivity)
		$campivot/SpringArm3D.rotation.x = clamp($campivot/SpringArm3D.rotation.x, deg_to_rad(-60), deg_to_rad(60))


func land():
	slowdown = true
	anim_tree.travel("jump_end")
	await get_tree().create_timer(0.5).timeout
	slowdown = false

func _physics_process(delta):
	var horisontal_speed = Vector2(velocity.x, velocity.z).length()
	if is_on_floor() and was_in_air:
		land()
	was_in_air = not is_on_floor()

	if is_on_floor():
		anim_tree.travel("move")
		$mesh/AnimationTree2.set("parameters/move/blend_position", horisontal_speed)
	else:
		anim_tree.travel("jump_idle")
	# Гравитация
	if not is_on_floor():
		velocity.y -= 9.8 * delta

	# Прыжок
	if Input.is_action_just_pressed("jump") and is_on_floor() and can_move:
		anim_tree.travel("jump_start")
		slowdown = true
		await get_tree().create_timer(0.36).timeout
		slowdown = false
		if is_on_floor():
			velocity.y = jump

	# Скорость тип
	var sprint_mode = 2.0 if Input.is_action_pressed("sprint") else 1.0
	var slow_mode = 0.5 if slowdown else 1.0
	speed = standart_speed * sprint_mode * slow_mode

	# Регистрация нажатия и типа отработка угла поворота модельки
	var input_dir = Input.get_vector("left", "right", "forward", "backward")
	var direction = ($campivot.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()


	if direction != Vector3.ZERO and can_move:
		# Ускорение
		velocity.x = lerp(velocity.x, direction.x * speed, acceleration * delta)
		velocity.z = lerp(velocity.z, direction.z * speed, acceleration * delta)
		# Повороь мэша за камерой
		var tar_rotation = atan2(direction.x, direction.z) + PI
		rotation.y = lerp_angle(rotation.y, tar_rotation, 7.5 * delta)

	else:
		# Тормоз (как я)
		velocity.x = lerp(velocity.x, 0.0, friction * delta)
		velocity.z = lerp(velocity.z, 0.0, friction * delta)

	move_and_slide()
	# Шоб камера не съебла
	$campivot.global_position = global_position

func _process(delta: float) -> void:
	#Зум
	if Input.is_action_just_released("zoom"):
		tar_zoom = clamp(tar_zoom - 0.2, 1.5, 3)
	if Input.is_action_just_released("zoom_out"):
		tar_zoom = clamp(tar_zoom + 0.2, 1.5, 3)
	$campivot/SpringArm3D.spring_length = lerp($campivot/SpringArm3D.spring_length, tar_zoom, 5.0 * delta)

#Захватить/отпустить мышку
	if Input.is_action_just_released("esc") and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	elif Input.is_action_just_released("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	if Input.is_action_just_released("interact"):
		var areas = $InteractArea3D.get_overlapping_areas()
		for i in areas:
			if i is Interactable and i.can_interact:
				i.interact()
				break
	
	if $InteractArea3D.get_overlapping_areas():
		var areas = $InteractArea3D.get_overlapping_areas()
		for i in areas:
			if i is Interactable and i.can_interact:
				GlobalEvent.show_interact.emit(i.ui_text)
			else:
				GlobalEvent.hide_interact.emit()
	else:
		GlobalEvent.hide_interact.emit()
