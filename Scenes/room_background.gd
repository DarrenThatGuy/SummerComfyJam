extends Node2D

signal ghost_found

var ghosts_visible : Array[VisibleOnScreenNotifier2D] = []

func move_camera(amount : Vector2) -> void:
	$Camera2D.position += amount

func reveal_ghost() -> void:
	$NormalBackground.hide()
	
	# emit signal if ghost found
	if not ghosts_visible.is_empty():
		emit_signal("ghost_found")
	
func hide_ghost() -> void:
	$NormalBackground.show()

# add/remove ghosts from array when on/off screen, respectively
func _on_ghost_1_screen_entered() -> void:
	ghosts_visible.append($Ghost1)

func _on_ghost_1_screen_exited() -> void:
	ghosts_visible.erase($Ghost1)
