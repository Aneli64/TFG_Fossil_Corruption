extends Node2D

@onready var movementSprite = $AnimatedSprite2D

# Iniciamos el sprite básico de movimiento
func _ready():
	movementSprite.play("BasicMovement")

# Cuando colisione con nuestra munición extra un player, sumaremos la munición extra a su
# munición y eliminaremos la munición extra de la escena
func _on_area_2d_body_entered(body):
	if (body.name == "PlayerBody"):
		Global.sumar_municion(10)
		queue_free()
