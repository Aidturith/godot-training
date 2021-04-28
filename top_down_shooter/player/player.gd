extends KinematicBody2D

var move_speed = 200
var bullet_speed = 500
var bullet = preload("res://player/bullet.tscn")

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var motion = Vector2()
	if Input.is_action_pressed("up"):
		motion.y -= 1
	if Input.is_action_pressed("down"):
		motion.y += 1
	if Input.is_action_pressed("left"):
		motion.x -= 1
	if Input.is_action_pressed("right"):
		motion.x += 1
	motion = motion.normalized()
	motion = move_and_slide(motion * move_speed)
	look_at(get_global_mouse_position())
	#if Input.is_action_pressed("player_shoot"):
	if Input.is_action_pressed("mouse1"):
		if $bullet_cooldown.time_left == 0:
			shoot()

func shoot():
	var fired = bullet.instance()
	fired.start_at(rotation, position)
	$bullet_container.add_child(fired)
	$bullet_cooldown.start()

#func shoot(delta):
#	var fired  = bullet.instance()
#	fired.position = get_global_position()
#	fired.rotation_degrees = rotation_degrees
#	fired.apply_impulse(Vector2(), Vector2(bullet_speed, 0).rotated(rotation))
#	get_tree().get_root().call_deferred("add_child", fired)

func _on_Area2D_body_entered(body):
	if "enemy" in body.name:
		kill()

func _on_Area2D_area_entered(area):
	print(area.name)
	if "Sharpnel" in area.name:
		kill()

func kill():
	get_tree().reload_current_scene()
