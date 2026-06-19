class_name PlayerBird

extends CharacterBody2D

@export var gravity : float = 20           
@export var speed : float = 200     
@export var jump : float = 325
var dead : bool = false

@export var camera : Camera2D

func _ready() -> void:
	# start having already jumped, to give a small grace period
	velocity = Vector2(speed, -jump)

func _physics_process(delta : float) -> void:
	velocity.x = speed
	if Input.is_action_just_pressed("jump") and not dead:
		velocity.y = -jump
		$FlapSound.play()
	else:
		velocity.y += gravity
	move_and_slide()
	
	camera.global_position.x = $CameraLoc.global_position.x
