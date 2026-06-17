extends Button

@export var scene_path : String
var success_event : String = "EnteredSecretApp"
var fail_event : String = "WrongCode"
var code : String = ""

signal send_button_data(scene, event)


func _ready():
	# assemble secret code
	for i in EventTracker.secret_code_selection:
		code += str(EventTracker.secret_code[i])

func _on_pressed():
	# check code,event for success/failure
	if %Code.text == code:
		send_button_data.emit(scene_path, success_event)
	else:
		send_button_data.emit("", fail_event) # don't switch scene if fail
