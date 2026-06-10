extends Node2D

signal check_events(event, scene)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_change_phone_scene(scene_change, event):
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
			scene.setup(event)
	check_events.emit(event, scene_change)
