extends RigidBody2D

signal dead

export var speed := 150.0
var bounce_historic = []

func _ready():
	spawn()


func spawn():
	var viewport = get_viewport_rect()
	linear_velocity = Vector2.ZERO
	position = Vector2(viewport.size.x / 2.0, viewport.size.y / 1.2)
	apply_impulse(Vector2.ZERO, Vector2.ONE.normalized() * speed)


func _on_Ball_body_entered(body):
	if body.is_in_group("brick"):
		modulate = body.modulate
		body.queue_free()
	elif body.is_in_group("paddle"):
		body.modulate = modulate
		speed *= 2 # TODO not working
	elif body.is_in_group('game_over'):
		emit_signal("dead", bounce_historic)
		bounce_historic = []
		# spawn() # TODO doesn't work
	var bounce = {'position': position, 'modulate': modulate}
	bounce_historic.append(bounce)
