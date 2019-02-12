extends Area2D

const GRAVITY = 10;
var velocity = 0

func _physics_process(delta):
	velocity += GRAVITY * delta
	position.y += velocity 

func _input(event):
	if event.is_action_pressed("bird_jump"):
		velocity = -3