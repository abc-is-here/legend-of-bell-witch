extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$cutscene_player.play("beginning")
	$cutscene_cam.current = true
	
	# Wait for 8 seconds
	await get_tree().create_timer(8.0, false).timeout
	
	var player_node = get_node("/root/" + get_tree().current_scene.name + "/Player")
	player_node.movable = true
	
	var player_camera = get_node("/root/" + get_tree().current_scene.name + "/Player/head/Camera3D")
	var player_head = get_node("/root/" + get_tree().current_scene.name + "/Player/head")
	
	player_camera.current = true
	player_head.movable = true
	
	$cutscene_cam.current = false
	queue_free()
