class_name Phone extends Polygon2D

signal change_phone_scene(scene_change, event)




# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_send_button_data(scene, event):
	print(scene)
	print(event)
	change_phone_scene.emit(scene, event)
