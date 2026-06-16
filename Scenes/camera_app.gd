extends Node2D

signal ghost_found
signal change_phone_scene(scene_change, event)

@export var speed : float = 300
var photo_taken : bool = false

func _physics_process(delta : float) -> void:
	# don't allow movement or more photos if one just taken
	if not photo_taken:
		# if enter or space pressed, show ghost photo
		if Input.is_action_just_pressed("confirm"):
			photo_taken = true
			%RoomBackground.reveal_ghost()
			$PhotoDuration.start()
			return
	
		# get input direction and move phone/camera based on it
		var dir : Vector2 = Vector2(Input.get_axis("left", "right"), Input.get_axis("up", "down")).normalized()
		var velocity : Vector2 = (speed * dir * delta)
		$Offset/Phone.position += velocity
		%RoomBackground.move_camera(velocity)

func _on_photo_duration_timeout() -> void:
	# return to normal background view and allow camera movement
	%RoomBackground.hide_ghost()
	photo_taken = false

# propagate ghost found signal upwards
func _on_room_background_ghost_found() -> void:
	print("Ghost Found!")
	emit_signal("ghost_found")

# propagate up scene change signal
func _on_phone_change_phone_scene(scene_change: Variant, event: Variant) -> void:
	change_phone_scene.emit(scene_change, event)
