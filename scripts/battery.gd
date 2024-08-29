extends Node3D

@export var min_time: float
@export var max_time: float
@export var min_flash_time: float
@export var max_flash_time: float
@export var loop_flashing: bool
@export var flash_lights_at_rand: bool

var loop = true

func _process(delta: float) -> void:
	if loop and flash_lights_at_rand:
		loop = false
		var rng = RandomNumberGenerator.new()
		var rand = rng.randf_range(min_time, max_time)
		await get_tree().create_timer(rand).timeout

		if loop_flashing:
			while loop_flashing:
				$AnimationPlayer.play("flashing_light")
				$flicker_sound.play()
				var rand_flash_time = rng.randf_range(min_flash_time, max_flash_time)
				await get_tree().create_timer(rand_flash_time).timeout
				$flicker_sound.stop()
				$AnimationPlayer.play("RESET")
		else:
			$AnimationPlayer.play("flashing_light")
			$flicker_sound.play()
			await get_tree().create_timer($AnimationPlayer.current_animation_length).timeout
			$flicker_sound.stop()
			$AnimationPlayer.play("RESET")

		loop = true
