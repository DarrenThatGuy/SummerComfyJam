extends Control

signal change_phone_scene(scene_change)

@onready var viewport : SubViewport = $SubViewportContainer/SubViewport

func _ready() -> void:  
	setup(load("res://MiniGames/FlappyBird/flappy_bird.tscn"))

func setup(game : PackedScene) -> void:
	var node : Node2D = game.instantiate()
	viewport.add_child(node)
	node.restart.connect(_on_restart)
	
func _on_restart() -> void:
	print("Restart")
	viewport.get_child(0).queue_free()
	setup(load("res://MiniGames/FlappyBird/flappy_bird.tscn"))

func _on_home_button_pressed() -> void:
	change_phone_scene.emit("res://main_screen.tscn")
