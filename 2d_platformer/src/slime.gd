extends KinematicBody2D

var velocity = Vector2.ZERO
export var direction = -1
export var detects_cliffs = true
var speed = 50


func _ready():
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$FloorChecker.enabled = detects_cliffs
	update_floor_checker()
	if not detects_cliffs:
		modulate = Color(1.2, 0.5, 1)


func _physics_process(delta):
	if (is_on_wall() or (not $FloorChecker.is_colliding() 
			and is_on_floor() and detects_cliffs)):
		flip()
	velocity.y += 20
	velocity.x = speed * direction
	velocity = move_and_slide(velocity, Vector2.UP)


func flip():
	direction *= -1
	$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
	update_floor_checker()


func update_floor_checker():
	var extents_width = $CollisionShape2D.shape.extents.x
	$FloorChecker.position.x = extents_width * direction


func _on_TopChecker_body_entered(body):
	if body.is_in_group("player"):
		squashed()
		body.bounce()
	elif body.is_in_group("projectile"):
		squashed()
		

func squashed():
	speed = 0
	$AnimatedSprite.play("squash")
	$SfxSquash.play()
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$TopChecker.set_collision_layer_bit(4, false)
	$TopChecker.set_collision_mask_bit(0, false)
	$SideChecker.set_collision_layer_bit(4, false)
	$SideChecker.set_collision_mask_bit(0, false)
	$Disappear.start()


func _on_Disappear_timeout():
	queue_free()


func _on_SideChecker_body_entered(body):
	if body.is_in_group("player"):
		body.ouch(position.x)

