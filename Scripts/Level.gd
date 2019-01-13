extends Node

var brick = null
var health = null
var score = null

signal game_over

export var posbyColour = [
	Vector2(0, 0),
	Vector2(4*32, 0),
	Vector2(2*32, 16),
	Vector2(0, 32),
	Vector2(4*32, 32)
]

var Brick = preload("res://Scenes/Brick.tscn")

func _ready():
	score = 0
	health = 3
	generate_map()

func _physics_process(delta):
	if boundBall():
		$WallHitSound.play()

func _on_Brick_area_entered(area, brick):
	score += 1
	$BrickHitSound.play()

	if $Ball.position.x - 2 < brick.position.x - 16 and $Ball.velocity.x > 0:
		$Ball.velocity.x = -$Ball.velocity.x
		$Ball.position.x = brick.position.x - 20
	elif $Ball.position.x + 2 > brick.position.x + 16 and $Ball.velocity.x < 0:
		$Ball.velocity.x = -$Ball.velocity.x
		$Ball.position.x = brick.position.x + 20
	elif $Ball.position.y < brick.position.y - 4:
		$Ball.velocity.y = -$Ball.velocity.y
		$Ball.position.y = brick.position.y - 12
	else:
		$Ball.velocity.y = -$Ball.velocity.y
		$Ball.position.y = brick.position.y + 12

	brick.queue_free()

func _on_Paddle_area_entered(area):
	$Ball.velocity.y = -$Ball.velocity.y

	if $Ball.position.x < $Paddle.position.x and $Paddle.speed < 0:
		$Ball.velocity.x = -50 + -(8 * ($Paddle.position.x - $Ball.position.x))
	elif $Ball.position.x > $Paddle.position.x and $Paddle.speed > 0:
		$Ball.velocity.x = 50 + 8 * abs($Paddle.position.x - $Ball.position.x)

	$Ball.velocity = $Ball.velocity.normalized() * 200
	$PaddleHitSound.play()

func generate_map():
	randomize()
	var num_rows = 1 + randi() % 5
	var num_cols = 7 + randi() % 7

	for y in range(1, num_rows+1):
		for x in range(1, num_cols+1):
			var brickpos = Vector2()
			
			brick.init(self, 
				posbyColour[0],
				(x-1) * 32 + 8 + (13 - num_cols) * 16 + 16,
				y * 16)
			add_child(brick)

func boundBall():
	var isTouched = false;

	if $Ball.position.x <= 4:
		$Ball.position.x = 4
		$Ball.velocity.x = -$Ball.velocity.x
		isTouched = true

	if $Ball.position.x >= CONSTANTS.VIRTUAL_WIDTH - 4:
		$Ball.position.x = CONSTANTS.VIRTUAL_WIDTH - 4
		$Ball.velocity.x = -$Ball.velocity.x
		isTouched = true
	
	if $Ball.position.y <= 4:
		$Ball.position.y = 4
		$Ball.velocity.y = -$Ball.velocity.y
		isTouched = true

	if $Ball.position.y >= CONSTANTS.VIRTUAL_HEIGHT - 4:
		health -= 1
		$Ball.reset()
		if health < 1:
			emit_signal("game_over")

	return isTouched