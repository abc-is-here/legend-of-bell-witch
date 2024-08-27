extends StaticBody3D


func interact():
	get_node("/root/" + get_tree().current_scene.name + "/sounds/keyPickUp").play()
	queue_free()
