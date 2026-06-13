extends Node2D

var current_picture
var current_element = 0
@onready var picture_array = [$Picture1, $Picture2, $Picture3]
@onready var array_size = picture_array.size()


# Called when the node enters the scene tree for the first time.
func _ready():
	current_picture = picture_array[current_element]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_picture.visible = true
	
func select_picture(direction):
	current_picture.visible = false
	if direction == "Left":
		if current_element == 0:
			print("Current Element is Zero")
			current_element = array_size -1
		else:
			print("Current Element is more than Zero")
			current_element -= 1
	if direction == "Right":
		if current_element == array_size - 1:
			print("Current Element is Size")
			current_element = 0
		else:
			print("Current Element is Less than Size")
			current_element += 1
	if current_element > array_size:
		return
	current_picture = picture_array[current_element]
	print(current_picture)
	print(current_element)
	
func _on_left_button_pressed():
	select_picture("Left")

func _on_right_button_pressed():
	select_picture("Right")
