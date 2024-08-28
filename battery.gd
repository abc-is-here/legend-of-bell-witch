extends StaticBody3D

var flashlight_energy
var energy_add_amount = 20.0  # Default value, can be set according to your need
var pickUp_sound
var flashlight

func _ready() -> void:
	flashlight = get_node("/root/" + get_tree().current_scene.name + "/Player/head/flashlight")
	pickUp_sound = get_node("/root/" + get_tree().current_scene.name + "/sounds/ObjPickUp")
	flashlight_energy = get_node("/root/" + get_tree().current_scene.name + "/UI/flashlight_stuff/flashlightSlider")

func interact() -> void:
	if flashlight and flashlight_energy:
		if flashlight.picked_up:
			flashlight_energy.value += energy_add_amount
			pickUp_sound.play()
			queue_free()
