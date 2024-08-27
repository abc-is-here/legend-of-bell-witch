extends Area3D


@export var monster: CharacterBody3D

func _on_body_entered(body: Node3D) -> void:
	if body == get_node("/root/"+get_tree().current_scene.name+"/Player"):
		monster.visible = true
