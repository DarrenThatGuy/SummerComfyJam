class_name MainScreen extends Phone


# Called when the node enters the scene tree for the first time.
func _ready():
	print(EventTracker.scores["FlappyBird"])
	if EventTracker.events['UnlockExampleLockedApp'] > 0:
		$LockedAppButton.disabled = false
	if EventTracker.events['DownloadFlappyBird'] > 0:
		$FlappyBirdButton.visible = true
	if EventTracker.events['DownloadSpaceGame'] > 0:
		$SpaceGameButton.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
