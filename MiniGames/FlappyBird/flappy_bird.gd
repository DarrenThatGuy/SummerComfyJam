extends Node2D

signal restart

@export var obstacle : PackedScene
@onready var player : Node2D = $PlayerBird
@onready var game_over_screen : PackedScene = preload("res://MiniGames/FlappyBird/game_over.tscn")

@export var spacing : float = 350  
var next : float
var score : int = 0
var game_over : bool = false

func _ready() -> void:
	next = $Obstacles.position.x # start from x position of marker
	
	while next < 1500:
		add_obstacle(next)
		next += spacing

func _process(delta : float) -> void:
	if not game_over:
		# consistently spawn obstacles out of camera view
		while (next - $PlayerBird.position.x < 1500):
			add_obstacle(next)
			next += spacing
	else:
		if Input.is_action_just_pressed("confirm"):
			print("Made it here")
			emit_signal("restart")

func add_obstacle(posx : float) -> void:
	# randomize posy deviation from center (normal distribution)
	var rng : RandomNumberGenerator = RandomNumberGenerator.new()
	rng.randomize()
	var posy : float = clamp(rng.randfn($Obstacles.position.y, 100), 75, 570)
	
	# add obstacle as child, connect signals
	var node : Node2D = obstacle.instantiate()
	node.position = Vector2(posx, posy)
	node.collision.connect(_on_hit_obstacle)
	node.score.connect(_on_score)
	add_child(node)
	
func _on_hit_obstacle() -> void:
	player.dead = true
	player.speed = 0
	
func _on_score() -> void:
	score += 1
	print(score)

func _on_game_over_body_entered(body: Node2D) -> void:
	if body is PlayerBird:
		# ensure player dead if not already
		body.dead = true
		body.speed = 0
		
		# Update Player High Score
		if EventTracker.scores['FlappyBird'] < score:
			EventTracker.scores["FlappyBird"] = score
		
		# show game over screen
		
		var node : Control = game_over_screen.instantiate()
		add_child(node)
		node.position = $Camera2D.position # for some reason, this flips the text?
		
		game_over = true
		
	
