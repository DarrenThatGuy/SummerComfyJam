extends Node2D

signal restart
signal got_secret_score
signal game_completed(game_name)

@export var brick : PackedScene
@export var columns : int = 16
@export var spacing : int = 4

@onready var game_over_screen : PackedScene = preload("res://MiniGames/game_over.tscn")
var score : int = 0
var game_over : bool = false

func _ready() -> void:
	# spawn 8 rows of bricks, with needed columns and spacing
	for i in 8:
		for j in columns:
			var instance = brick.instantiate()
			instance.color = get_color(i)
			instance.position = Vector2((64 + spacing) * j, (16 + spacing) * i)
			$Bricks.add_child(instance)

func _process(delta : float) -> void:
	if game_over and not EventTracker.pause and Input.is_action_just_pressed("confirm"):
		emit_signal("restart")

# get the color name from row num
func get_color(num : int) -> String:
	match num:
		0,1:
			return "Red"
		2,3:
			return "Orange"
		4,5:
			return "Green"
		6,7:
			return "Yellow"
	return "Error"

# on score signal, add needed number of points
func add_score(points : int):
	score += points
	
func _on_game_over() -> void:
	
	# Update Player High Score
	if EventTracker.scores['Breakout'] < score:
		EventTracker.scores["Breakout"] = score
	# Check if Player cleared secret score
	if score >= EventTracker.secret_score["Breakout"] and EventTracker.aquired_secret_score["Breakout"] == false:
		EventTracker.aquired_secret_score["Breakout"] = true
		emit_signal("got_secret_score")
	
	# show game over screen
	var node : Control = game_over_screen.instantiate()
	node.position = $Background.position
	add_child(node)
	
	game_over = true
	game_completed.emit("BreakoutCompleted")
