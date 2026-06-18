extends Node2D

signal restart
signal got_secret_score
signal game_completed(game_name)

@onready var asteroid : PackedScene = preload("res://MiniGames/Asteroids/asteroid.tscn")
@onready var screensize : Vector2 = get_viewport_rect().size # get viewport size
@onready var game_over_screen : PackedScene = preload("res://MiniGames/game_over.tscn")
var waves_cleared : int = 0
var game_over : bool = false

func _ready() -> void:
	$PlayerShip.game_over.connect(_on_game_over)
	asteroid_wave()

func _process(delta : float) -> void:
	# emit restart if needed
	if game_over and not EventTracker.pause and Input.is_action_just_pressed("confirm"):
		restart.emit()
	
	# new wave when current defeated
	elif $Asteroids.get_child_count() == 0:
		asteroid_wave()
		waves_cleared += 1

func asteroid_wave() -> void:
	# ensure player doesn't die if asteroid spawns on their position
	$PlayerShip.invincibility() 
	
	# spawn random number of asteroids
	var num_asteroids : int = randi_range(5, 9) + waves_cleared
	for i in num_asteroids:
		var pos : Vector2 = Vector2(randf_range(0, screensize.x), randf_range(0, screensize.y))
		spawn_asteroid(pos)

func spawn_asteroid(pos : Vector2) -> void:
	# spawn individual asteroid of random rotation and add to the scene
	var angle : float = randf_range(0, 2 * PI)
	var instance : RigidBody2D = asteroid.instantiate()
	instance.size = randi_range(1, 3)
	instance.position = pos
	instance.rotation = angle
	
	$Asteroids.add_child(instance)
	
func _on_game_over():
	game_over = true
	
	# Update Player High Score
	if EventTracker.scores['SpaceGame'] < waves_cleared:
		EventTracker.scores["SpaceGame"] = waves_cleared
	if waves_cleared >= EventTracker.secret_score["SpaceGame"] and EventTracker.aquired_secret_score["SpaceGame"] == false:
		EventTracker.aquired_secret_score["SpaceGame"] = true
		emit_signal("got_secret_score")
	
	# show game over screen
	var node : Control = game_over_screen.instantiate()
	node.position = $Background.position
	add_child(node)
	
	game_completed.emit("SpaceGameCompleted")
