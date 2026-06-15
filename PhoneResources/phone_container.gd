extends Node2D

signal check_events(event, scene)
signal trigger_event(event)
# Called when the node enters the scene tree for the first time.
func _ready():
	print(EventTracker.secret_code)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_change_phone_scene(scene_change, event):
	print("Scene Change Recieved")
	if scene_change == '':
		pass
	else:
		var scene = load(scene_change).instantiate()
		scene.change_phone_scene.connect(_on_change_phone_scene)
		scene.position = Vector2(-123, -53)
		get_child(0).queue_free()
		add_child(scene)
		
		# if game container, choose game based on event
		if scene_change == "res://MiniGames/game_container.tscn":
			scene.trigger_secret_score.connect(_on_trigger_secret_score)
			scene.game_completed.connect(_on_game_completed)
			scene.setup(event)
	check_events.emit(event, scene_change)

func _on_trigger_secret_score():
	var picked_index = randi_range(0, EventTracker.secret_code_selection.size() - 1)
	var selected_digit = EventTracker.secret_code_selection[picked_index]
	EventTracker.code_number = EventTracker.secret_code[selected_digit]
	EventTracker.code_digit = EventTracker.secret_code.find_key(EventTracker.code_number)
	EventTracker.secret_code_selection.erase(EventTracker.code_digit)

func _on_game_completed(event):
	trigger_event.emit(event)
