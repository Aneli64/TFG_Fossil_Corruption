extends Node2D

func _on_area_2d_body_entered(body):
	if (body.name == "PlayerBody"):
		Global.reducir_vida(100)
