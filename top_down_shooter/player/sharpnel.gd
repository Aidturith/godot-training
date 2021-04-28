extends Area2D

var speed = 100
var velocity = Vector2(speed, 0)

func _process(delta):
	for body in self.get_overlapping_bodies():
		if body.get_name() == "walls":
			queue_free()

func _physics_process(delta):
	position += velocity * delta

func start_at(new_rotation, new_position):
	rotation = new_rotation
	position = new_position
	velocity = Vector2(speed, 0).rotated(rotation)
