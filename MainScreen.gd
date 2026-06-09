class_name MainScreen extends Phone


# Called when the node enters the scene tree for the first time.
func _ready():
	if EventTracker.events['UnlockExampleLockedApp'] > 0:
		$LockedAppButton.disabled = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
