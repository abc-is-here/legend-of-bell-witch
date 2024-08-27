extends CharacterBody3D


var SPEED = 4.0
var player
var caught = false
var distance: float
var jumpscare_time = 2
@export var scene_name: String

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _ready() -> void:
	player = get_node("/root/" + get_tree().current_scene.name + "/Player")

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
		distance = player.global_transform.origin.distance_to(global_transform.origin)
		if distance <=2 && caught == false:
			player.visible = false
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
