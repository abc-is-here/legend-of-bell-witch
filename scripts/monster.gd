extends CharacterBody3D

var SPEED = 2.5
var player
var caught = false
var distance: float
var jumpscare_time = 2
@export var scene_name: String
@export var destination: Array[Node3D]
var rng
var current_destination
var chasing = false
var able_to_pick = false
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var walk_footsteps: Array[AudioStream]

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	player = get_node("/root/" + get_tree().current_scene.name + "/Player")
	var random_dest = rng.randi_range(0, destination.size() - 1)
	current_destination = destination[random_dest]

func pick_new_destination():
	if chasing == false && able_to_pick == false && distance<=1:
		able_to_pick = true
		SPEED = 0
		var wait_time = rng.randf_range(3.0, 10.0)
		await get_tree().create_timer(wait_time, false).timeout
		if distance<=1:
			var random_dest = rng.randi_range(0, destination.size() - 1)
			SPEED = 2.5
			current_destination = destination[random_dest]
		able_to_pick = false

func _process(delta: float) -> void:
	if chasing == true && !$chase_music.playing:
		$chase_music.play()
	if chasing == false && $chase_music.playing:
		$chase_music.stop()
	
	if chasing == false && SPEED>0:
		if !$footsteps.playing:
			var num = rng.randi_range(0, walk_footsteps.size() - 1)
			$footsteps.stream = walk_footsteps[num]
			$footsteps.play()
			
		distance = current_destination.global_transform.origin.distance_to(global_transform.origin)
		update_target_location(current_destination.global_transform.origin)
	if chasing && SPEED>0:
		if !$footsteps.playing:
			var num = rng.randi_range(0, walk_footsteps.size() - 1)
			$footsteps.stream = walk_footsteps[num]
			$footsteps.play()
		update_target_location(player.global_transform.origin)
		distance = player.global_transform.origin.distance_to(global_transform.origin)

func _physics_process(delta: float) -> void:
	get_tree().create_timer(20.0, false).timeout
	if visible:
		if not is_on_floor():
			velocity.y -= gravity*delta
		var current_location = global_transform.origin
		var next_location = $NavigationAgent3D.get_next_path_position()
		var new_velocity = (next_location-current_location).normalized() * SPEED
		$NavigationAgent3D.set_velocity(new_velocity)
		var look_dir = atan2(-velocity.x, -velocity.z)
		rotation.y = look_dir
		if chasing:
			if distance <=2 && caught == false:
				player.visible = false
				if !$jumpscare.playing:
					$jumpscare.play()
				SPEED = 0
				caught = true
				$jumpscare_camera.current = true
				await get_tree().create_timer(jumpscare_time, false).timeout
				get_tree().change_scene_to_file("res://scenes/"+scene_name+".tscn")

func update_target_location(target_location):
	$NavigationAgent3D.target_position = target_location

func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = velocity.move_toward(safe_velocity, 0.25)
	move_and_slide()
