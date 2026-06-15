extends Node
var events = {
'EnteredExampleApp' : 0,
'EnteredHomeScreen' : 0, 
'UnlockExampleLockedApp' : 0, 
'LockedExampleApp' : 0, 
'EnteredFlappyBird' : 0, 
"DownloadFlappyBird" : 0, 
'EnteredSpaceGame' : 0, 
"DownloadSpaceGame" : 0, 
"DownloadPong" : 0, 
"DownloadBreakout" : 0, 
"EnteredWeatherApp" : 0, 
"EnteredVideoApp" : 0, 
"EnteredCameraApp" : 0, 
"EnteredGalleryApp" : 0, 
"EnteredPong" : 0, 
"EnteredBreakout" : 0,
"EnteredStorefrontApp" : 0, 
"EnteredFoodApp" : 0, 
"EnteredGachaApp" : 0, 
"EnteredSecretApp" : 0, 
"OrderedFood" : 0, 
"RolledGacha" : 0, 
"BuyPlant" : 0,
"BuySoil" : 0,
"BuyWateringCan" : 0,
"BuyFertilizer" : 0,
"GhostScannerOn" : 0,
"TriggerApocEnding" : 0,
"SpaceGameCompleted" : 0,
}
var secret_code_selection = ["First", "Second", "Third", "Fourth"]
var secret_code = {'First' : 0, 'Second' : 0, 'Third' : 0, 'Fourth' : 0}
var scores = {'FlappyBird': 0, 'SpaceGame': 0, 'Breakout': 0, 'Pong': 0}
var secret_score = {'FlappyBird': 1, 'SpaceGame': 1, 'Breakout' : 1, 'Pong' : 10}
var aquired_secret_score = {'FlappyBird' : false, 'SpaceGame' : false, 'Breakout' : false, 'Pong' : false}
var last_game
var gacha_inventory = []

var rng

var code_digit
var code_number

func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	randomize_secret_code()

func randomize_secret_code():
	rng.randomize()
	for code in secret_code:
		secret_code[code] = randi() % 9
