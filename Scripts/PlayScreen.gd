extends Control

func _ready():
	$Level.generate_map()

func _physics_process(delta):
	if $Ball.boundBall():
		$WallHitSound.play()

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		$Paddle.position.x -= CONSTANTS.PADDLE_SPEED * delta
	elif Input.is_action_pressed("ui_right"):
		$Paddle.position.x += CONSTANTS.PADDLE_SPEED * delta

func _on_Paddle_area_entered(area):
	$Ball.velocity.y = -$Ball.velocity.y
	$Ball.position.y = $Paddle.position.y - 10
	$PaddleHitSound.play()