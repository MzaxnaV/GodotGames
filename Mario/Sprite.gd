extends Sprite

# SHOULD BE USING STATE MACHINE FOR THIS

const PLAYER_SPEED = 40
const GRAVITY = 7
const JUMP_VLOCITY = -200

var velocity = 0

var jumping = false

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	
	if event.is_action_pressed("ui_up") and velocity == 0:
		velocity = JUMP_VLOCITY
		$AnimationPlayer.current_animation = "jump"
		jumping = true

func _process(delta):
	velocity += GRAVITY
	position.y += velocity * delta
	
	if Input.is_action_pressed("ui_left"):
		flip_h = true
		position.x -= PLAYER_SPEED * delta
		if !jumping:
			$AnimationPlayer.current_animation = "walk"
	elif  Input.is_action_pressed("ui_right"):
		flip_h = false
		position.x += PLAYER_SPEED * delta
		if !jumping:
			$AnimationPlayer.current_animation = "walk"
	elif !jumping:
		$AnimationPlayer.current_animation = "idle"

	if position.y > 70:
		position.y = 70
		velocity = 0
		jumping = false

