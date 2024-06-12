extends Node2D


var hp = 100
var points = 0
var lifes = 5
var weapon_ammun = 10
var enemy_hit = false

func reducir_vida(cantidad):
	hp -= cantidad
	# Evitamos que la vida sea negativa
	if hp < 0:
		hp = 0
		
func sumar_pts(pts):
	points += pts
	
func sumar_hp(hps):
	if (hp + hps) < 100:
		hp += hps
	else:
		hp += 100 - hp
	
func sumar_municion(munic):
	weapon_ammun += munic

func reset_player():
	points = 0
	hp = 100
	weapon_ammun = 10
	
func respawn():
	lifes -= 1
	if (lifes <= 0):
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
		lifes = 5
	get_tree().reload_current_scene()
	reset_player()
