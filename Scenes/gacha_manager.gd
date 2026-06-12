extends Node2D

var NormalRarityArray = ["Red", "Blue", "Green", "Yellow", "Orange", "Purple", "Cyan", "Slightly Brighter Orange", "Pale Brown", "Grey"]
var UncommonRarityArray = ["Silver", "Bronze", "Iron", "Aluminum", "Lint", "Quartz", "Steel", "Fool's Gold"]
var RareRarityArray = ["GOLD", "RUBY", "EMERALD", "SAPPHIRE", "DIAMOND", "PLATINUM"]
var SuperRareRarityArray = ["NEON GREEN", "NEON WHITE", "NEON PINK", "NEON RED"]
var UltimateRarityArray = ["[Missing Texture]"]

var collectiveArray = [NormalRarityArray, UncommonRarityArray, RareRarityArray, SuperRareRarityArray, UltimateRarityArray]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func roll_gacha():
	var rng = RandomNumberGenerator.new()
	var rarity
	var weights = PackedFloat32Array([.9, .09, .009, .0009, .0001])
	var selectedarray = collectiveArray[rng.rand_weighted(weights)]
	var selectedunit = selectedarray.pick_random()
	var duplicate = false
	match selectedarray:
		NormalRarityArray:
			rarity = "Normal"
		UncommonRarityArray:
			rarity = "Uncommon"
		RareRarityArray:
			rarity = "Rare"
		SuperRareRarityArray:
			rarity = "Super Rare"
		UltimateRarityArray:
			rarity = "Ultimate Rare"
	
	if EventTracker.gacha_inventory.has(selectedunit):
		duplicate = true
		pass
	else:
		EventTracker.gacha_inventory.insert(0, selectedunit)
	
	print(EventTracker.gacha_inventory)
	if duplicate == true:
		$"../DuplicateLabel".visible = true
		return rarity + " Rarity: " + selectedarray.pick_random()
	else:
		$"../DuplicateLabel".visible = false
		return rarity + " Rarity: " + selectedarray.pick_random()
func _on_send_button_data(scene, event):
	$"../Label".text = roll_gacha()
