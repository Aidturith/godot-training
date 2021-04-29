extends KinematicBody2D

var velocity := Vector2.ZERO

const SPEED := 250
const GRAVITY := 35
const JUMP_FORCE := -900


func _process(delta):
	update_sprite()


func _physics_process(delta):
	var move_right = Input.is_action_pressed('move_right')
	var move_left = Input.is_action_pressed('move_left')
	#var target_speed = int(move_right) * SPEED - int(move_left) * SPEED
	#velocity.x = lerp(velocity.x, target_speed, .5)
	if move_right and move_left:
		velocity.x = lerp(velocity.x, .0, .5)
	elif move_right:
		velocity.x = lerp(velocity.x, SPEED, .5)
	elif move_left:
		velocity.x = lerp(velocity.x, -SPEED, .5)
	velocity.y += GRAVITY
	if Input.is_action_pressed("jump") and is_on_floor():
		$SfxJump.play()
		velocity.y = JUMP_FORCE
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, .0, .2)
	

func update_sprite() -> void:
	if Input.is_action_pressed('move_right'):
		$Sprite.play('walk')
		$Sprite.flip_h = false
	elif Input.is_action_pressed('move_left'):
		$Sprite.play('walk')
		$Sprite.flip_h = true
	else:
		$Sprite.play('idle')
	if not is_on_floor():
		$Sprite.play('jump')


func _on_FallZone_body_entered():
	print("fall")
	get_tree().change_scene("res://scenes/Level1.tscn")


func bounce():
	velocity.y = JUMP_FORCE * 0.7
	
	
func ouch(enemy_pos_x: float) -> void:
	velocity.y = JUMP_FORCE * 0.5
	if position.x < enemy_pos_x:
		velocity.x = -800
	else:
		velocity.x = 800
	$AnimationPlayer.play("ouch")
	Input.action_release("move_left")
	Input.action_release("move_right")
	$Timer.start()


func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/Level1.tscn")
