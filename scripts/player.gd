extends CharacterBody3D

var  original_speed
var SPEED = 3.0
const JUMP_VELOCITY = 4.5
var sprint_speed = 7.0
var sprint_slider
var drain_amount = 0.3
var sprint_refresh = 0.4
var movable = false

func _ready() -> void:
	original_speed = SPEED
	sprint_slider = get_node("/root/"+get_tree().current_scene.name + "/UI/SprintSlider")

func _process(delta: float) -> void:
	if movable:
		if SPEED == sprint_speed:
			sprint_slider.value -= drain_amount*delta
			if sprint_slider.value == sprint_slider.min_value:
				SPEED = original_speed
		if SPEED != sprint_speed:
			sprint_slider.value += sprint_refresh*delta
			if sprint_slider.value < sprint_slider.max_value:
				sprint_slider.value += sprint_refresh*delta

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if movable:
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		var input_dir := Input.get_vector("left", "right", "forward", "backward")
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
					
			if Input.is_action_just_pressed("sprint"):
				SPEED = sprint_speed
				sprint_slider.visible = true
			if Input.is_action_just_released("sprint"):
				SPEED = original_speed
				sprint_slider.visible = false
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

		move_and_slide()
