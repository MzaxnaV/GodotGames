extends Area2D

var skin = 1
var size = 3

var speed = 50

func _ready():
	$Sprite.texture = TEXTURE_ATLAS.get_texture_paddles(size, skin)
	$CollisionShape2D.shape.set_height(32 * size - 16)

func _process(delta):
	if Input.is_action_pressed("ui_left"):
		position.x -= CONSTANTS.PADDLE_SPEED * delta
	elif Input.is_action_pressed("ui_right"):
		position.x += CONSTANTS.PADDLE_SPEED * delta