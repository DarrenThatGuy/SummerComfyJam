extends StaticBody2D

@export_enum("Wall", "Ceiling") var type : String

# bounce ball in correct direction
func reflect(velocity : Vector2) -> Vector2:
	if type == "Wall":
		velocity.x *= -1
	else:
		velocity.y *= -1
	return velocity
