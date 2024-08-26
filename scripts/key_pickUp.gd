extends StaticBody3D


func interact():
	get_node("/root/" + get_tree().current_scene.name + "/keyPickUp").play()
	queue_free()
