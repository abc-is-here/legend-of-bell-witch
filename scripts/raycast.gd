extends RayCast3D

var int_text
var last_hit = null

func _ready() -> void:
	int_text = get_node("/root/" + get_tree().current_scene.name + "/UI/interact_text")
	int_text.visible = false

func _process(_delta: float) -> void:
	if is_colliding():
		var hit = get_collider()
		
		if hit != last_hit:
			if last_hit != null and last_hit.has_method("stop_scare"):
				last_hit.stop_scare()
			last_hit = hit

		if hit.has_method("interact"):
			int_text.visible = true
			if Input.is_action_just_pressed("interact"):
				hit.interact()
		else:
			int_text.visible = false

		if hit.has_method("scare"):
			hit.scare()
	else:
		int_text.visible = false
		if last_hit != null and last_hit.has_method("stop_scare"):
			last_hit.stop_scare()
			last_hit = null
