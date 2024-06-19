extends Control

func _on_play_btn_pressed():
	get_tree().change_scene_to_file("res://Scenes/Pantallas/Main_scene.tscn")


func _on_exit_btn_pressed():
	get_tree().quit()


func _on_audio_stream_player_2d_finished():
	$AudioStreamPlayer2D.play()
