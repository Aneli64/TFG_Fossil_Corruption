extends Node2D

@onready var movementSprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	movementSprite.play("BasicMovement")

func _on_area_2d_body_entered(body):
	#Cuando colisione con nuestra moneda un player, sumaremos la moneda a su
	#puntuación y eliminaremos la moneda de la escena
	if body.is_in_group("Player"):
		body.points += 1
		queue_free()
