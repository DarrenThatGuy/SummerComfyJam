extends Node2D

@export var dialogue_resource : DialogueResource
var previous_scene
var current_scene

func _ready():
	current_scene = "res:///Scenes/main_screen.tscn"
	DialogueManager.show_example_dialogue_balloon(load("res://dialogue/gameDialogue/GameDialogue.dialogue"), 'start')
func true_event(event):
	EventTracker.events[event] += 1
func _on_phone_container_check_events(event, scene):
	true_event(event)
	if scene != null:
		previous_scene = current_scene
		current_scene = scene
	if current_scene == "res://Scenes/main_screen.tscn":
		match EventTracker.events['OrderedFood']:
			1:
				DialogueManager.show_example_dialogue_balloon(load("res://dialogue/gameDialogue/GameDialogue.dialogue"), 'MinigameDirection')
				EventTracker.events['OrderedFood'] += 1
		match EventTracker.events['FirstGameCompleted']:
			1:
				DialogueManager.show_example_dialogue_balloon(load("res://dialogue/gameDialogue/GameDialogue.dialogue"), 'GachaGameDirection')
				EventTracker.events['FirstGameCompleted'] += 1
	elif current_scene == "res://example_app.tscn":
		match EventTracker.events['EnteredExampleApp']:
			1:
				print("First Time Entering Example App")
				#DialogueManager.show_example_dialogue_balloon(load("res://GameDialogue.dialogue"), 'ExampleApp')
			var n when n > 1:
				print("More than First Time Entering Example App")
			_:
				pass
	elif current_scene == "res://locked_app.tscn":
		match EventTracker.events['LockedExampleApp']:
			1:
				#DialogueManager.show_example_dialogue_balloon(load("res://GameDialogue.dialogue"), 'LockedExampleApp')
				pass
	elif current_scene == "res://Scenes/food_app.tscn":
		match  EventTracker.events['OrderedFood']:
			1:
				DialogueManager.show_example_dialogue_balloon(load("res://dialogue/gameDialogue/GameDialogue.dialogue"), 'OrderedFood')
		match  EventTracker.events['EnteredFoodApp']:
			1:
				EventTracker.events['EnteredFoodApp'] += 1
				DialogueManager.show_example_dialogue_balloon(load("res://dialogue/gameDialogue/GameDialogue.dialogue"), 'OpenedFoodApp')
		

func _on_phone_container_trigger_event(event):
	if event == "SpaceGameCompleted" or event == "FlappyBirdCompleted" or event == "PongCompleted" or event == "BreakoutCompleted":
		EventTracker.last_game = event
		DialogueManager.show_example_dialogue_balloon(load("res://dialogue/gameDialogue/GameDialogue.dialogue"), 'MiniGameEnd')
