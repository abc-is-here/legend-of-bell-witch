extends Node3D

@export var min_time: float
@export var max_time: float
@export var min_flash_time: float
@export var max_flash_time: float
@export var loop_flashing: bool
@export var flash_lights_at_rand: bool

var loop = true

func _process(delta: float) -> void:
	if loop == true && flash_lights_at_rand == true:
		loop = false
		var rng = RandomNumberGenerator.new()
		var rand = rng.randf_range(min_time, max_time)
		await get_tree().create_timer(rand, false).timeout
		if loop_flashing:
			$AnimationPlayer.get_animation("flashing_light").loop = true
		$AnimationPlayer.play("flashing_light")
		if loop_flashing == false:
			loop = true
		if loop_flashing == true:
			var rand2 = rng.randf_range(min_flash_time, max_flash_time)
			await get_tree().create_timer(rand2, false).timeout
			$AnimationPlayer.play("RESET")
			loop = true
