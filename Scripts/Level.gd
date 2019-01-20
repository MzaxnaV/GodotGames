extends Node

var health = null
var score = null
var Brick = preload("res://Scenes/Brick.tscn")

signal game_over

func _physics_process(delta):
	if bound_ball():
		$WallHitSound.play()

func _on_Brick_area_entered(area, brick):
	score += brick.tier * 200 + brick.colour * 25
	$HUD/LevelScreen/Score.set_text(str(score))
	$HUD/Explosion.explode(brick.position, brick.colour, brick.tier)

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
	
	if brick.tier <= 0 and brick.colour <= 1:
		$BrickHit1Sound.play()
		brick.queue_free()
	else:
		$BrickHit2Sound.play()
		brick.reduce_tier(1)

func _on_Paddle_area_entered(area):
	$Ball.velocity.y = -$Ball.velocity.y

	if $Ball.position.x < $Paddle.position.x and $Paddle.speed < 0:
		$Ball.velocity.x = -50 + -(8 * ($Paddle.position.x - $Ball.position.x))
	elif $Ball.position.x > $Paddle.position.x and $Paddle.speed > 0:
		$Ball.velocity.x = 50 + 8 * abs($Paddle.position.x - $Ball.position.x)

	$Ball.velocity = $Ball.velocity.normalized() * 200
	$Ball.position.y = $Paddle.position.y - 8
	$PaddleHitSound.play()

func populate(bricks, paddle_skin):
	score = 0
	health = 3
	
	$Paddle.init(paddle_skin)
	
	for brick in bricks:
		brick.connect("area_entered", self, "_on_Brick_area_entered", [brick])
		add_child(brick)

func set_play(is_playing):
	if is_playing:
		$HUD/LevelScreen/ServeText.hide()
		$Paddle/ball.hide()
		$Ball.reset($Paddle.position)
		$Ball.show()
	else:
		$HUD/LevelScreen/ServeText.show()
		$Ball.init()
		$Ball.velocity = Vector2(0, 0)
		$Ball.position = Vector2(50, 180)
		$Ball.hide()
		$Paddle/ball.set_region_rect(change_ball($Ball.skin))
		$Paddle/ball.show()
		$HUD/LevelScreen/Hearts.change_heart(health)

func bound_ball():
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
		$HurtSound.play()
		get_parent().get_parent().change_state('serve')
		if health < 1:
			get_parent().get_parent().change_state('gameover')

	return isTouched

func change_ball(skin):
	var y = 48

	if skin > 4:
		skin -= 4
		y += 8

	return Rect2(96 + 8 * (skin-1), y, 8, 8)