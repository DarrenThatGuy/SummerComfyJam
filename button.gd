class_name AppButton extends Button

@export var scene_path : String
signal send_button_data(scene)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	send_button_data.emit(scene_path)
