extends Area3D

@export var animationPlayer: AnimationPlayer
@export var anim_name: String

func _on_body_entered(body: Node3D) -> void:
	if body == get_node("/root/" + get_tree().current_scene.name + "/Player"):
		animationPlayer.play(anim_name)
		monitoring = false
