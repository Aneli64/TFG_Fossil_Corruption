extends Node2D

@onready var movementSprite = $AnimatedSprite2D

# Iniciamos el sprite básico de movimiento
func _ready():
	movementSprite.play("anim_hp")

# Cuando colisione con nuestro hp extra un player, sumaremos el hp a su
# vida y eliminaremos el hp de la escena
func _on_area_2d_body_entered(body):
	if (body.name == "PlayerBody"):
		Global.sumar_hp(40)
		queue_free()
