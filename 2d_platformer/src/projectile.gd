extends KinematicBody2D

var velocity = Vector2.ZERO
var direction = -1
const SPEED := 400
const GRAVITY := 35
const BOUNCE_FORCE := -900 * 0.7


func _ready():
	$AnimationPlayer.play("rotate")
	
func _physics_process(delta):
	velocity.y += GRAVITY
	if is_on_floor():
		velocity.y = BOUNCE_FORCE
	velocity.x = SPEED * direction
	velocity = move_and_slide(velocity, Vector2.UP)
	if is_on_wall():
		queue_free()
	

func _on_Expire_timeout():
	queue_free()
