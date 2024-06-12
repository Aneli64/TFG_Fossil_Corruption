extends Node2D

@onready var movementSprite = $AnimatedSprite2D
@onready var ptsSound = $CoinSound

# Called when the node enters the scene tree for the first time.
func _ready():
	movementSprite.play("BasicMovement")

# Cuando colisione con nuestra moneda un player, sumaremos la moneda a su
# puntuación y eliminaremos la moneda de la escena
func _on_area_2d_body_entered(body):
	if (body.name == "PlayerBody"):
		ptsSound.playing = true
		Global.sumar_pts(1)
		queue_free()
