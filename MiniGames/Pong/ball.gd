extends Area2D

signal score(posx)

@export var speed : float = 400
var velocity : Vector2 = Vector2.ZERO

func _physics_process(delta : float) -> void:
	position += velocity * delta

# launch the ball to given side, and a random amount down
func launch(dir : Vector2) -> void:
	var random = randf_range(0.2, 0.8)
	var final_dir = dir.move_toward(Vector2.DOWN, random).normalized()
	velocity = speed * final_dir

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("reflect"):
		velocity = body.reflect(velocity)
	else:
		velocity.y *= -1

func _on_area_entered(area: Area2D) -> void:
	emit_signal("score", position.x)
