extends StaticBody3D

@export var paper_material: StandardMaterial3D
var toggle = false

func _ready() -> void:
	$MeshInstance3D.material_override = paper_material

func interact():
	toggle = !toggle
	
	# Access UI paper node
	var paper_node = get_node_or_null("/root/" + get_tree().current_scene.name + "/UI/paper")
	if paper_node:
		paper_node.visible = toggle
	else:
		print("Error: UI paper node not found.")
	
	# Access Player node
	var player_node = get_node_or_null("/root/" + get_tree().current_scene.name + "/Player")
	if player_node:
		if player_node.has_method("set_movable"):
			player_node.set_movable(toggle)
		else:
			print("Error: Player node does not have a 'movable' property.")
	else:
		print("Error: Player node not found.")
	
	# Access Head node
	var head_node = get_node_or_null("/root/" + get_tree().current_scene.name + "/Player/head")
	if head_node:
		if head_node.has_method("set_movable"):
			head_node.set_movable(toggle)
		else:
			print("Error: Head node does not have a 'movable' property.")
	else:
		print("Error: Head node not found.")
