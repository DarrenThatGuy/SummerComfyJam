extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_change_phone_scene(scene_change):
	# Upon recieving a scene to change to, the game instantiates the scene to transition to
	# Then the game connects the scene change signal and positions the phone in the proper area.
	# after this, the original scene is deleted, and the new scene is placed exactly where the old one was.
	var scene = load(scene_change).instantiate()
	scene.change_phone_scene.connect(_on_change_phone_scene)
	scene.position = Vector2(-123, -53)
	get_child(0).queue_free()
	add_child(scene)
	
