extends CharacterBody2D

@export var speed : float = 250
@export var is_player : bool = false
@export var deviation : float = 24

func _physics_process(delta : float) -> void:
	if is_player:
		# handle player movement
		velocity = Vector2.DOWN * speed * Input.get_axis("up", "down")
	else:
		# aim for random amount from ball center, normally distributed
		var ball_pos : Vector2 = get_parent().get_ball_pos()
		var rng : RandomNumberGenerator = RandomNumberGenerator.new()
		rng.randomize()
		var target_y : float = clamp(rng.randfn(ball_pos.y, deviation), 30, 620)
		
		# move up or down, change speed depending on how close enemy is
		if position.y >= target_y:
			velocity = minf(speed, (position.y - target_y) * 3.5) * Vector2.UP
		else:
			velocity = minf(speed, (target_y - position.y) * 3.5) * Vector2.DOWN
			
	move_and_slide()
	
# bounce ball in correct direction
func reflect(velocity : Vector2) -> Vector2:
	velocity.x *= -1
	return velocity
