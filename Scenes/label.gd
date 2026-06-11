extends Label

var current_time = Time.get_time_dict_from_system()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	print(Time.get_time_dict_from_system())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(current_time['hour']) + ' : ' + str(current_time['minute'])
