extends StaticBody3D

var flashlight

func _ready() -> void:
	flashlight = get_node("/root/" + get_tree().current_scene.name + "/Player/head/flashlight")
	
func interact():
	flashlight.picked_up = true
	queue_free()
