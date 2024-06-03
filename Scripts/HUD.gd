extends CanvasLayer

func _ready():
	$ProgressBar.value = Global.hp
	$points.text = str(Global.points)
	$lifes.text = str(Global.lifes)
	$municion_arma.text = str(Global.weapon_ammun)

func _process(delta):
	$ProgressBar.value = Global.hp
	$points.text = str(Global.points)
	$lifes.text = str(Global.lifes)
	$municion_arma.text = str(Global.weapon_ammun)
