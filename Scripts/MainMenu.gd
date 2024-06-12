extends Control

func _on_play_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/Main_scene.tscn")


func _on_exit_btn_pressed():
	get_tree().quit()
