extends Node2D

var velocity = Vector2(400,40)
var isFlip = false

func ready():
	if isFlip:
		velocity.x *= -1

func _process(delta):
	position += velocity * delta

func _on_hitbox_body_entered(body):
	velocity = Vector2(0,0)
	$AnimationPlayer.stop()
	$ArrojSprite.play("broken")
	
func _on_arroj_sprite_animation_finished():
	self.queue_free()
