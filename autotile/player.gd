extends KinematicBody2D


var velocity = Vector2.ZERO
var speed = 300.0


func _physics_process(delta):
	if up():
		velocity.y = lerp(velocity.y, -speed, 0.25)
	if down():
		velocity.y = lerp(velocity.y, speed, 0.25)
	if left():
		velocity.x = lerp(velocity.x, -speed, 0.25)
	if right():
		velocity.x = lerp(velocity.x, speed, 0.25)
	if not (up() or down()):
		velocity.y = lerp(velocity.y, 0.0, 0.5)
	if not (left() or right()):
		velocity.x = lerp(velocity.x, 0.0, 0.5)
	velocity = move_and_slide(velocity)
	print(velocity)

func up():
	return Input.is_action_pressed("ui_up")
	
func down():
	return Input.is_action_pressed("ui_down")

func left():
	return Input.is_action_pressed("ui_left")
	
func right():
	return Input.is_action_pressed("ui_right")
