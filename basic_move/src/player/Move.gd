extends Node2D


func _ready():
	$Gino1.play("default")
	# method 1
	$AnimationPlayer.play("Basic Move")
	# method 2
	$Gino2.position = Vector2(50, 150)
	$Gino2.position.x = 500
	# method 5
	move_tween()
	print("done")


func _physics_process(delta):
	# method 3
	var speed = 20.0
	var to = Vector2(500, 250)
	$Gino3.position = $Gino3.position.move_toward(to, delta * speed)


func _process(delta):
	# method 4
	var to2 = Vector2(500, 350)
	$Gino4.position = lerp($Gino4.position, to2, .01)
	# method 4b
	move_lerp(delta)
	# method 6
	move_path(delta)


var time = 0
var time_direction = 1

func move_lerp(delta):
	var point1 = Vector2(50, 400)
	var point2 = Vector2(500, 400)
	var move_duration = 2.0
	if time > move_duration or time < 0:
		time_direction *= -1
	time += delta * time_direction
	$Gino4b.position = lerp(point1, point2, time / move_duration)


func move_tween():
	# see https://easings.net/
	var point1 = Vector2(50, 450)
	var point2 = Vector2(500, 450)
	$Tween.start()
	$Tween.interpolate_property($Gino5, "position", point1, point2, 2.0, 
		Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0.5)
	yield($Tween, "tween_completed")
	$Tween.interpolate_property($Gino5, "position", point2, point1, 2.0, 
		Tween.TRANS_EXPO, Tween.EASE_IN_OUT, 0.5)
	yield($Tween, "tween_completed")
	move_tween()


var traverse_time = 5
var t = 0
onready var path_length = $Path2D.get_curve().get_baked_length()

func move_path(delta):
	if t > traverse_time:
		t = 0
	t += delta
	var offset = (t / traverse_time) * path_length
	$Path2D/PathFollow2D.set_offset(offset)
	$Gino6.position = $Path2D/PathFollow2D.position
