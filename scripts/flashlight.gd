extends SpotLight3D

var picked_up = false
var flashlight_ui
var flashlight_energy
var drain_rate = 0.05

func _ready() -> void:
	flashlight_ui = get_node("/root/" + get_tree().current_scene.name + "/UI/flashlight_stuff")
	flashlight_energy = get_node("/root/" + get_tree().current_scene.name + "/UI/flashlight_stuff/flashlightSlider")

	# Ensure flashlight_energy is initialized with a value if not set in the UI
	if flashlight_energy.value == null:
		flashlight_energy.value = 100.0  # or any default value

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("flashlight") and picked_up and flashlight_energy.value > 0:
		visible = not visible
		flashlight_ui.visible = visible
		
		$toggle.play()

	if visible:
		flashlight_energy.value -= drain_rate * delta
		
		if flashlight_energy.value <= 0:
			flashlight_energy.value = 0
			visible = false
			flashlight_ui.visible = false
