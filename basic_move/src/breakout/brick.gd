tool
extends StaticBody2D

export (Color) var color = Color(1, 1, 1) setget set_color


func _ready():
	set_color(color)
	

func set_color(new_color):
	color = new_color
	if is_inside_tree():
		$AnimatedSprite.modulate = color
