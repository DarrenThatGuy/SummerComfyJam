extends Node2D

signal restart
signal got_secret_score
signal game_completed(game_name)

@export var ball_scene : PackedScene
var ball : Area2D

@onready var you_win_screen : PackedScene = preload("res://MiniGames/you_win.tscn")
@onready var game_over_screen : PackedScene = preload("res://MiniGames/game_over.tscn")
var player_score : int = 0
var enemy_score : int = 0
var game_over : bool = false

func _ready() -> void:
	# spawn ball in center and launch left; also connect score signal
	ball = ball_scene.instantiate() 
	ball.score.connect(add_score)
	add_child(ball)
	ball.position = Vector2(576, 50)
	ball.launch(Vector2.LEFT)

func _process(delta : float) -> void:
	if game_over and Input.is_action_just_pressed("confirm"):
		emit_signal("restart")

# handle score increase, then either relaunch ball or end game
func add_score(posx : float):
	# increase correct score
	if posx < 500:
		enemy_score += 1
		print("Enemy: " + var_to_str(enemy_score))
	else:
		player_score += 1
		print("Player: " + var_to_str(player_score))
	
	# handle game over if player or enemy score reaches 10
	if player_score == 10 or enemy_score == 10:
		# Update Player High Score
		if EventTracker.scores['Pong'] < player_score:
			EventTracker.scores["Pong"] = player_score
		if player_score >= EventTracker.secret_score["Pong"] and EventTracker.aquired_secret_score["Pong"] == false:
			EventTracker.aquired_secret_score["Pong"] = true
			emit_signal("got_secret_score")
		# show game over or you win screen
		var node : Control
		if player_score >= 10:
			node = you_win_screen.instantiate()
		else:
			node = game_over_screen.instantiate()
		node.position = $Background.position
		add_child(node)
		
		game_over = true
		game_completed.emit("PongCompleted")
	
	# otherwise, relaunch ball after delay
	else:
		$Delay.start()

func get_ball_pos() -> Vector2:
	return ball.position

func _on_delay_timeout() -> void:
	if (player_score + enemy_score) % 2 == 0:
		ball.position = Vector2(576, 30)
		ball.launch(Vector2.LEFT)
	else:
		ball.position = Vector2(576, 30)
		ball.launch(Vector2.RIGHT)
