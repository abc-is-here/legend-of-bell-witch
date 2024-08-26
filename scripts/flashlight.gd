extends SpotLight3D

var picked_up = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("flashlight") && picked_up == true:
		visible = !visible
		$toggle.play()
