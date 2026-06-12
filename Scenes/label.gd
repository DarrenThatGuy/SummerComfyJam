extends Label

var current_time = Time.get_time_dict_from_system()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	print(Time.get_time_dict_from_system())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_time.hour > 12:
		text = str(
			"%02d:%02d" % [current_time.hour - 12, current_time.minute]
		)
	else:
		text = str(
			"%02d:%02d" % [current_time.hour, current_time.minute]
		)
