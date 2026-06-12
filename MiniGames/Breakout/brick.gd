class_name Brick

extends StaticBody2D

@export_enum("Yellow", "Green", "Orange", "Red") var color : String = "Yellow"
var points : int = 0

func _ready() -> void:
	match color:
		"Yellow":
			points = 1
			modulate = Color(1.0, 1.0, 0.0)
		"Green":
			points = 3
			modulate = Color(0.0, 0.75, 0.0)
		"Orange":
			points = 5
			modulate = Color(1.0, 0.5, 0.0)
		"Red":
			points = 7
			modulate = Color(1.0, 0.0, 0.0)
