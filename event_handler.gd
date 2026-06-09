extends Node2D

@export var dialogue_resource : DialogueResource
var previous_scene
var current_scene

func _ready():
	current_scene = "res://main_screen.tscn"
	DialogueManager.show_example_dialogue_balloon(load("res://GameDialogue.dialogue"), 'start')
func true_event(event):
	EventTracker.events[event] += 1
func _on_phone_container_check_events(event, scene):
	true_event(event)
	if scene != null:
		previous_scene = current_scene
		current_scene = scene
	if current_scene == "res://main_screen.tscn":
		if EventTracker.events['UnlockExampleLockedApp'] > 0:
			print("UnlockLockedApp")
	elif current_scene == "res://example_app.tscn":
		match EventTracker.events['EnteredExampleApp']:
			1:
				print("First Time Entering Example App")
				DialogueManager.show_example_dialogue_balloon(load("res://GameDialogue.dialogue"), 'ExampleApp')
			var n when n > 1:
				print("More than First Time Entering Example App")
			_:
				pass
	elif current_scene == "res://locked_app.tscn":
		match EventTracker.events['LockedExampleApp']:
			1:
				DialogueManager.show_example_dialogue_balloon(load("res://GameDialogue.dialogue"), 'LockedExampleApp')
