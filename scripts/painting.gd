extends StaticBody3D

@export var paint_mat: StandardMaterial3D
@export var scary_painting: StandardMaterial3D
@export var stare_time: float
@export var scare_time: float
var isLooking = false

func _process(delta: float) -> void:
	$MeshInstance3D2.material_override = paint_mat

func scare():
	if isLooking == false:
		isLooking = true
		await get_tree().create_timer(stare_time, false).timeout
		if isLooking == true:
			$jumpscare.play()
			$MeshInstance3D2.material_override = scary_painting
			await get_tree().create_timer(scare_time, false).timeout
			$jumpscare.stop()
			$MeshInstance3D2.material_override = paint_mat
	

func stop_scare():
	pass
	