extends KinematicBody2D

signal update_score(left_score, right_score)

export(int) var speed = 250

var startPos = Vector2()
var boundary = Vector2()
var velocity = Vector2()
var randomRotation = 0.0

func _ready():
	randomize()
	var size = $Sprite.scale.y * 64
	boundary.x = size
	boundary.y = get_viewport_rect().size.y - size
	startPos = get_viewport_rect().size / 2
	reset(99)


func _physics_process(delta):
	if (position.y < boundary.x || position.y > boundary.y):
		if position.y < boundary.x:
			position.y = boundary.x
		else:
			position.y = boundary.y
		
		$WallHit.play()
		velocity.y = - velocity.y
		velocity.x = velocity.x * 1.05
		
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		$PaddleHit.play()
		velocity.x = -velocity.x
		randomRotation = rand_range(-PI/8, PI/8)

		if (velocity.rotated(randomRotation).angle_to(collision.normal) < PI/2):
			velocity = velocity.rotated(randomRotation)

func reset(playerTurn):
	position = startPos
	
	match playerTurn:
		1:
			velocity.x = rand_range(0, 1)
			velocity.y = rand_range(-velocity.x, velocity.x)
		2:
			velocity.x = rand_range(-1, 0)
			velocity.y = rand_range(velocity.x, -velocity.x)
		_:
			velocity.x = rand_range(-1, 1)
			velocity.y = rand_range(-1, 1)

	velocity = velocity.normalized() * speed


func _on_ExitAreaLeft_body_entered(body):
	reset(1)
	$Score.play()
	emit_signal("update_score", 1, 0)


func _on_ExitAreaRight_body_entered(body):
	reset(2)
	$Score.play()
	emit_signal("update_score", 0, 1)
