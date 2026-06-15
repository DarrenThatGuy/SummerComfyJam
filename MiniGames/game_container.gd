extends Control

signal change_phone_scene(scene_change, event)
signal trigger_secret_score()
signal game_completed()

@onready var viewport : SubViewport = $SubViewportContainer/SubViewport
var game_event : String
var current_game : String
		

func setup(event : String) -> void:
	# set game to load based on event string
	game_event = event
	var game : PackedScene
	if event == "EnteredFlappyBird":
		current_game = "FlappyBird"
		game = load("res://MiniGames/FlappyBird/flappy_bird.tscn")
	elif event == "EnteredSpaceGame":
		current_game = "SpaceGame"
		game = load("res://MiniGames/Asteroids/asteroids_game.tscn")
	elif event == "EnteredBreakout":
		current_game = "Breakout"
		game = load("res://MiniGames/Breakout/breakout.tscn")
	elif event == "EnteredPong":
		current_game = "Pong"
		game = load("res://MiniGames/Pong/pong.tscn")
		
	var node : Node2D = game.instantiate()
	viewport.add_child(node)
	node.restart.connect(_on_restart)
	node.got_secret_score.connect(_on_got_secret_score)
	node.game_completed.connect(_on_game_completed)
	
func _on_restart() -> void:
	print("Restart")
	viewport.get_child(0).queue_free()
	setup(game_event)

func _on_home_button_pressed() -> void:
	change_phone_scene.emit("res://Scenes/main_screen.tscn", 'EnteredHomeScreen')

func _on_got_secret_score() -> void:
	trigger_secret_score.emit()

func _on_game_completed(event) -> void:
	print(event)
	game_completed.emit(event)
