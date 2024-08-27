extends Control

func play():
	get_tree().change_scene_to_file("res://scenes/level.tscn")
	
func quit():
	get_tree().quit()


func _on_button_pressed() -> void:
	play()


func _on_button_3_pressed() -> void:
	quit()
