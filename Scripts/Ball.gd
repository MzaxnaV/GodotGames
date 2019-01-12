extends Area2D

var skin = 1
var velocity = null

func _ready():
	randomize()
	reset()

func _physics_process(delta):
	position += velocity * delta

func boundBall():
	var isTouched = false;

	if position.x <= 4:
		position.x = 4
		velocity.x = -velocity.x
		isTouched = true

	if position.x >= CONSTANTS.VIRTUAL_WIDTH - 4:
		position.x = CONSTANTS.VIRTUAL_WIDTH - 4
		velocity.x = -velocity.x
		isTouched = true
	
	if position.y <= 4:
		position.y = 4
		velocity.y = -velocity.y
		isTouched = true

	if position.y >= CONSTANTS.VIRTUAL_HEIGHT - 4:
		position.y = CONSTANTS.VIRTUAL_HEIGHT - 4
		velocity.y = -velocity.y
		isTouched = true

	return isTouched

func change_ball():
	var y = 48

	if skin > 4:
		y += 8

	$ball.set_region_rect(Rect2(96 + 8 * (skin - 1), y, 8, 8))

func reset():
	change_ball()

	position.x = CONSTANTS.VIRTUAL_WIDTH / 2 - 2
	position.y = CONSTANTS.VIRTUAL_HEIGHT / 2 - 2

	velocity = Vector2(rand_range(-200, 200), rand_range(-50, -60)).normalized() * 200