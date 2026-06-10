extends RigidBody2D

@onready var asteroid : PackedScene = preload("res://MiniGames/Asteroids/asteroid.tscn")

var size : int = 3
var speed : float = 1250

@onready var screensize = get_viewport_rect().size # get viewport size

func _ready() -> void:
	for node in get_children():
		node.scale = Vector2(size / 2.0, size / 2.0)

# move in direction spawned
func _physics_process(delta : float):
	constant_force = transform.x * speed 

# split or destroy asteroid when hit by projectile
func destroy() -> void:
	if size > 1:
		var angle : float = randf_range(.35, .85)
		add_sibling(spawn_asteroid(angle))
		add_sibling(spawn_asteroid(-angle))
	queue_free()

# split an asteroid off of this one, initializing all necessary values
func spawn_asteroid(angle : float) -> RigidBody2D:
	var instance : RigidBody2D = asteroid.instantiate()
	instance.rotate(angle)
	instance.size = size - 1
	instance.position = position
	
	return instance

func _integrate_forces(state : PhysicsDirectBodyState2D) -> void:
	# screen wrapping
	var xform = state.transform
	xform.origin.x = wrapf(xform.origin.x, 0, screensize.x)
	xform.origin.y = wrapf(xform.origin.y, 0, screensize.y)
	state.transform = xform
