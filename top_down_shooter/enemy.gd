extends KinematicBody2D

var enemy_motion = Vector2()
var rotation_speed = PI

func _ready():
	#connect("body_entered", self, "_on_Semi_Auto_Bullet_body_entered")
	pass

func _physics_process(delta):
	rotation += rotation_speed * delta
	# var player = get_parent().get_node("player")
	# position += (player.position - position) / 50
	# look_at(player.position)
	# move_and_collide(enemy_motion)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Area2D_area_entered(area):
	if "bullet" in area.name:
		queue_free()
