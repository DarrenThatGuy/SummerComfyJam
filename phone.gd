extends Polygon2D

signal change_phone_scene(scene_change)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_send_button_data(scene):
	# When the Button of the app recieves a signal to change to the next screen, it is emitted to the
	# phone container in order to change the scene
	
	# When setting up further app buttons, ensure that the button is connected to itself with the pressed signal
	# and connected to the parent with the change phone scene signal. Also ensure they are at the proper fuctions and don't make a new one
	change_phone_scene.emit(scene)
