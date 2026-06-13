extends Control

signal change_phone_scene(scene_change, event)

@onready var viewport : SubViewport = $SubViewportContainer/SubViewport
var game_event : String

func setup(event : String) -> void:
	# set game to load based on event string
	game_event = event
	var game : PackedScene
	if event == "EnteredFlappyBird":
		game = load("res://MiniGames/FlappyBird/flappy_bird.tscn")
	elif event == "EnteredSpaceGame":
		game = load("res://MiniGames/Asteroids/asteroids_game.tscn")
	elif event == "EnteredBreakout":
		game = load("res://MiniGames/Breakout/breakout.tscn")
	elif event == "EnteredPong":
		game = load("res://MiniGames/Pong/pong.tscn")
		
	var node : Node2D = game.instantiate()
	viewport.add_child(node)
	node.restart.connect(_on_restart)
	
func _on_restart() -> void:
	print("Restart")
	viewport.get_child(0).queue_free()
	setup(game_event)

func _on_home_button_pressed() -> void:
	change_phone_scene.emit("res://Scenes/main_screen.tscn", 'EnteredHomeScreen')
