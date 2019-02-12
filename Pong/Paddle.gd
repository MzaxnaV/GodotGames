extends KinematicBody2D

export (int) var speed = 300

var boundary = Vector2(0, 0)
var velocity = Vector2()

func _ready():
	var size = get_node("Sprite").scale.y * 32
	boundary.x = size
	boundary.y = get_viewport_rect().size.y - size
	velocity.y = 0
	velocity.x = 0

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_down"):
		velocity.y = speed 
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -speed
	else:
		velocity.y = 0
	
	position += velocity * delta
	
	position.y = clamp(position.y, boundary.x, boundary.y)