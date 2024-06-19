extends CanvasLayer



@onready var gameMusic = get_parent().get_node("AudioStreamPlayer")
var music_paused = false
var paused_position = 0.0

func _physics_process(delta):
	if Input.is_action_just_pressed("pausa"):
		get_tree().paused = not get_tree().paused
		$ColorRect.visible = not $ColorRect.visible
		$Label.visible = not $Label.visible
		$Button.visible = not $Button.visible
		if gameMusic.playing == true: 
			gameMusic.stop()
		else:
			gameMusic.play()
		

func _on_button_pressed():
	get_tree().quit()
	
