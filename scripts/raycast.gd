extends RayCast3D

var int_text
var last_hit

func _ready() -> void:
	int_text = get_node("/root/" + get_tree().current_scene.name + "/UI/interact_text")

func _process(_delta: float) -> void:
	if is_colliding():
		var hit = get_collider()
		last_hit = hit
		
		if hit.has_method("interact"):
			int_text.visible = true
			if Input.is_action_just_pressed("interact"):
				hit.interact()
		if hit.has_method("scare"):
			hit.scare()
		else:
			int_text.visible = false
	else:
		int_text.visible = false
		if last_hit != null && last_hit.has_method("scare"):
			last_hit.stop_scare()
