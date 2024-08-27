extends Control

@export var scene_name: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(4.0, false).timeout
	get_tree().change_scene_to_file("res://scenes/"+scene_name+".tscn")
