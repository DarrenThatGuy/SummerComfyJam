extends Node2D

var current_video
var current_element = 0
@onready var video_array = [$Video1, $Video2, $Video3]
@onready var array_size = video_array.size()


# Called when the node enters the scene tree for the first time.
func _ready():
	current_video = video_array[current_element]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_video.visible = true
	
func select_picture(direction):
	current_video.visible = false
	if direction == "Up":
		if current_element == 0:
			print("Current Element is Zero")
			current_element = array_size -1
		else:
			print("Current Element is more than Zero")
			current_element -= 1
	if direction == "Down":
		if current_element == array_size - 1:
			print("Current Element is Size")
			current_element = 0
		else:
			print("Current Element is Less than Size")
			current_element += 1
	if current_element > array_size:
		return
	current_video = video_array[current_element]
	print(current_video)
	print(current_element)
	
func _on_up_button_pressed():
	select_picture("Up")

func _on_down_button_pressed():
	select_picture("Down")
