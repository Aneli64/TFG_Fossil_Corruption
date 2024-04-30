extends Node2D

@onready var movementSprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	movementSprite.play("BasicMovement")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		queue_free()
