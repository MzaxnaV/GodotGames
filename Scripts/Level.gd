extends Node

var health = null
var score = null
var paddle_skin = null
var Brick = preload("res://Scenes/Brick.tscn")
var level = 1
var victory = false
var threshold = null

signal game_over

func _physics_process(delta):
	if bound_ball():
		$WallHitSound.play()
	if victory:
		get_parent().get_parent().change_state('victory')
		victory = false

func _on_Brick_area_entered(area, brick):
	score += brick.tier * 200 + brick.colour * 25

	if score > threshold:
		threshold += CONSTANTS.THRESHOLD
		$RecoverSound.play()
		health += 1
		clamp(health, 1, 3)
		$HUD/LevelScreen/Hearts.change_heart(health)

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
		if $BricksContainer.get_child_count() == 1:
			victory = true
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

func populate(l, paddle_s):
	if score == null:
		score = 5000
	$HUD/LevelScreen/Score.text = str(score)
	threshold = score + CONSTANTS.THRESHOLD

	if (paddle_skin == null):
		paddle_skin = paddle_s

	if (health == null):
		health = 3

	level = l

	var bricks = generate_bricks(level)
	$Paddle.init(paddle_skin)
	
	for brick in bricks:
		brick.connect("area_entered", self, "_on_Brick_area_entered", [brick])
		$BricksContainer.add_child(brick)

func set_play(play_mode):
	match play_mode:
		'playing' :
			$HUD/LevelScreen/LevelText.hide()
			$Paddle/ball.hide()
			$Ball.reset($Paddle.position)
			$Ball.show()
		'serving' :
			$HUD/LevelScreen/LevelText.text = "Level " + str(level)
			$HUD/LevelScreen/LevelText.show()
			$HUD/LevelScreen/VictoryText.hide()
			$Ball.init()
			$Ball.velocity = Vector2(0, 0)
			$Ball.position = Vector2(50, 180)
			$Ball.hide()
			$Paddle/ball.set_region_rect(change_ball($Ball.skin))
			$Paddle/ball.show()
			$HUD/LevelScreen/Hearts.change_heart(health)
		'victory' :
			$HUD/LevelScreen/VictoryText.text = "Level " + str(level) + " complete"
			$HUD/LevelScreen/VictoryText.show()
			$Ball.velocity = Vector2(0, 0)
			$Ball.position = Vector2(50, 180)
			$Ball.hide()
			$Paddle/ball.show()

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

func generate_bricks(level):
	var bricks = []

	var colour = 1
	var tier = 0

	randomize()
	var num_rows = 1 + randi() % 5
	var num_cols = 7 + randi() % 7
	if (num_cols % 2 == 0):
		num_cols += 1

	var highest_tier = int(min(3, level / 5))
	var highest_colour = int(min(3, level % 5 + 3))

	var brick = null
	for y in range(1, num_rows+1):
		var skip_pattern = (randi() % 2 == 0)
		var alternate_pattern = (randi() % 2 == 0)
		
		var alternate_colour1 = 1 + randi() % highest_colour
		var alternate_colour2 = 1 + randi() % highest_colour
		var alternate_tier1 = randi() % (highest_tier + 1)
		var alternate_tier2 = randi() % (highest_tier + 1)

		var skip_flag = (randi() % 2 == 0)
		var alternate_flag = (randi() % 2 == 0)

		var solid_colour = 1 + randi() % highest_colour
		var solid_tier = randi() % (highest_tier + 1)

		for x in range(1, num_cols+1):

			if skip_pattern and skip_flag:
				skip_flag = !skip_flag
				continue
			else:
				skip_flag = !skip_flag

			if alternate_pattern and alternate_flag:
				colour = alternate_colour1
				tier = alternate_tier1
				alternate_flag = !alternate_flag
			else:
				colour = alternate_colour2
				tier = alternate_tier2
				alternate_flag = !alternate_flag
			
			if !alternate_pattern:
				colour = solid_colour
				tier = solid_tier

			brick = Brick.instance()
			brick.init(
				Vector2((x-1) * 32 + 8 + (13 - num_cols) * 16 + 16, y * 16 + 8),
				colour,
				tier
			) 
			bricks.append(brick)

	return bricks