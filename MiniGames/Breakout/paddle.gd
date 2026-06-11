extends CharacterBody2D

signal game_over

@export var ball_scene : PackedScene
@export var speed : float = 500

var lives : int = 3
var ball : Area2D
var started : bool = false

func _ready() -> void:
	# spawn ball at correct position
	ball = ball_scene.instantiate()
	ball.global_position = $BallPos.global_position
	add_sibling.call_deferred(ball)
	
	# connect signals for score, life loss, and game over
	ball.points.connect(get_parent().add_score)
	ball.dead.connect(_on_dead)
	game_over.connect(get_parent()._on_game_over)

func _physics_process(delta : float) -> void:
	# have ball track paddle until launched
	if not started:
		ball.global_position = $BallPos.global_position
		if Input.is_action_just_pressed("confirm"):
			started = true
			ball.launch()
	
	# handle movement if game not over
	if lives > 0:
		velocity = Vector2.RIGHT * speed * Input.get_axis("left", "right")
		move_and_slide()
	
# bounce ball in correct direction
func reflect(velocity : Vector2) -> Vector2:
	velocity.y *= -1
	return velocity

func _on_dead() -> void:
	# decrement lives; game over if <= 0
	lives -= 1
	if lives <= 0:
		emit_signal("game_over")
		return
	
	# reset ball if more lives
	ball.velocity = Vector2.ZERO
	started = false
