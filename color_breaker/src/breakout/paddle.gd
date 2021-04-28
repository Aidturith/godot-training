extends StaticBody2D

export var speed = 150.0

var left_limit = 0
var right_limit = 0


func _ready():
	var viewport = get_viewport_rect()
	position.x = viewport.size.x / 2
	position.y = viewport.size.y / 1.1
	var paddle_length = $CollisionShape2D.shape.extents.x
	left_limit = viewport.position.x + (paddle_length / 2)
	right_limit = viewport.position.x + viewport.size.x - (paddle_length / 2)


func _physics_process(delta):
	var direction = 0
	if Input.is_action_pressed("move_left"):
		direction = -1
	elif Input.is_action_pressed("move_right"):
		direction = 1
	var velocity = Vector2(direction * speed * delta, 0)
	position += velocity
	if position.x < left_limit:
		position.x = left_limit
	elif position.x > right_limit:
		position.x = right_limit
