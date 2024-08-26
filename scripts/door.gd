extends StaticBody3D

var interactable = true
var opened = false

func interact():
	if get_parent().get_parent().locked == true && get_parent().get_parent().key == null:
		$locked.play()
		get_parent().get_parent().locked = false
	if interactable == true && get_parent().get_parent().locked == false:
		interactable = false
		opened = !opened
		if opened == false:
			$open_close.play()
			$AnimationPlayer.play("close")
		if opened == true:
			$open_close.play()
			$AnimationPlayer.play("open")
		await get_tree().create_timer(1.0, false).timeout
		interactable = true
	if interactable == true && get_parent().get_parent().locked == true:
		interactable = false
		$locked.play()
		$AnimationPlayer.play("locked")
		await get_tree().create_timer(0.7, false).timeout
		interactable = true
