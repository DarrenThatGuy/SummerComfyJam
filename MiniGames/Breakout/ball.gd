extends Area2D

signal dead
signal points(num_points)

@export var speed : float = 200
var velocity : Vector2 = Vector2.ZERO

func _physics_process(delta : float) -> void:
	position += velocity * delta
	
func launch() -> void:
	velocity = Vector2(speed, -speed)

func _on_body_entered(body: Node2D) -> void:
	if body is Brick:
		emit_signal("points", body.points)
		body.queue_free()
		velocity.y *= -1
		$BrickSound.play()
	else:
		velocity = body.reflect(velocity)
		$PlayerSound.play()

func _on_area_entered(area: Area2D) -> void:
	emit_signal("dead")
