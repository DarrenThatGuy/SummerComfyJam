class_name PlayerShip

extends RigidBody2D

signal game_over

@export var projectile : PackedScene
@export var engine_power : float = 400
@export var spin_power : float = 5000
@export var lives : int = 1

@onready var screensize : Vector2 = get_viewport_rect().size # get viewport size

var thrust : Vector2 = Vector2.ZERO
var rotation_dir : float = 0

func _physics_process(delta : float) -> void:
	# get thrust and rotation
	thrust = Vector2.ZERO
	if Input.is_action_pressed("up"):
		thrust += transform.x * engine_power
	if Input.is_action_pressed("down"):
		thrust -= transform.x * engine_power
	rotation_dir = Input.get_axis("left", "right")
	
	# shoot as needed
	if Input.is_action_just_pressed("confirm"):
		var instance : Node2D = projectile.instantiate()
		instance.position = $BulletLoc.global_position
		instance.rotation = rotation
		add_sibling(instance)
		$LaserSound.play()
	
	# apply forces
	constant_force = thrust
	constant_torque = rotation_dir * spin_power

func invincibility() -> void:
	$Invincible.start()

func _integrate_forces(state : PhysicsDirectBodyState2D) -> void:
	# screen wrapping
	var xform = state.transform
	xform.origin.x = wrapf(xform.origin.x, 0, screensize.x)
	xform.origin.y = wrapf(xform.origin.y, 0, screensize.y)
	state.transform = xform

# if hit by asteroid, lose a life. If no lives, end game
func _on_body_entered(body: Node) -> void:
	if $Invincible.is_stopped():
		body.queue_free()
		lives -= 1
		
		if lives <= 0:
			game_over.emit()
			queue_free()
