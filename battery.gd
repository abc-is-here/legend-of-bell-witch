extends StaticBody3D

var flashlight_energy
var energy_add_amount

func _ready() -> void:
	flashlight_energy = get_node("/root/" + get_tree().current_scene.name + "/UI/flashlight_stuff/flashlightSlider")

func interact():
	flashlight_energy.value += energy_add_amount
