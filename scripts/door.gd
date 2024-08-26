extends StaticBody3D

var interactable = true
var opened = false

func interact() -> void:
	if interactable:
		interactable = false
		if not opened:
			$AnimationPlayer.play("open")
		else:
			$AnimationPlayer.play("close")
		opened = !opened
		await get_tree().create_timer(1.0).timeout
		interactable = true
