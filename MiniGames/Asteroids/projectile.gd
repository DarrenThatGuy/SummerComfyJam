extends RigidBody2D

@export var speed : float = 800

# move in direction fired
func _physics_process(delta : float) -> void:
	constant_force = transform.x * speed 

# destroy asteroid if collided, free self regardless
func _on_body_entered(body: Node) -> void:
	if body.has_method("destroy"):
		body.destroy()
	queue_free()

# free projectile if it doesn't hit anything
func _on_timer_timeout() -> void:
	queue_free()
