extends Area2D

var velocity = Vector2()
var speed = 500
var Sharpnel = preload("res://player/sharpnel.tscn")

func _process(delta):
	for body in self.get_overlapping_bodies():
		if body.get_name() == "walls":
			explode()

func _physics_process(delta):
	position += velocity * delta

func _on_lifetime_timeout():
	queue_free()

func start_at(new_rotation, new_position):
	rotation = new_rotation
	position = new_position
	velocity = Vector2(speed, 0).rotated(rotation)

func explode():
	# TODO set delay for massive bounce back + weirds angles
	var nb_sharpnel = 10
	var angle_step = (2*PI)/nb_sharpnel
	var radius = 0
	for i in range(0, nb_sharpnel):
		var direction = Vector2(cos(i * angle_step), sin(i * angle_step))
		var bits = Sharpnel.instance()
		get_tree().get_root().add_child(bits)
		bits.position = position + direction * radius
		bits.rotation = i * angle_step
		bits.velocity = bits.velocity.rotated(bits.rotation)
	queue_free()
