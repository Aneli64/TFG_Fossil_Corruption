extends Control

func _ready():
	$ProgressBar.value = get_parent().enemy_hp_2

func _process(delta):
	$ProgressBar.value = get_parent().enemy_hp_2
