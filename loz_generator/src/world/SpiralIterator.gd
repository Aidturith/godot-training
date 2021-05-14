class_name SpiralIterator

extends Reference

var offset := Vector2(0,0)
var layer := 1;
var leg := 0;
var x := 0;
var y := 0;
var counter := 0


func _init(start := Vector2(0,0)):
	offset = start


func next() -> Vector2:
	counter += 1
	match leg:
		0:
			x += 1
			if x == layer:
				 leg += 1
		1:
			y += 1
			if y == layer:
				leg += 1
		2:
			x -= 1
			if -x == layer:
				leg += 1
		3:
			y -= 1
			if -y == layer:
				leg = 0
				layer += 1
	return current_position()


func current_position() -> Vector2:
	return Vector2(x, y) + offset


func count() -> int:
	return counter;
