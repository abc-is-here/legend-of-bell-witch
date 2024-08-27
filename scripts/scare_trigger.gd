extends Area3D

@export var animationPlayer: AnimationPlayer
@export var anim_name: String
@export var scare_sound: AudioStreamPlayer
var token = 0

func _on_body_entered(body: Node3D) -> void:
	if body == get_node("/root/" + get_tree().current_scene.name + "/Player") && token == 0:
		animationPlayer.play(anim_name)
		if scare_sound != null:
			scare_sound.play()
		token = 1
