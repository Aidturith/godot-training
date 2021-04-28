extends Node2D

var _bounce_historic = []


func _draw():
	for i in range(_bounce_historic.size()):
		var point1 = _bounce_historic[i]
		if i < _bounce_historic.size() - 1:
			var point2 = _bounce_historic[i + 1]
			draw_line(
				point1['position'], 
				point2['position'], 
				point1['modulate'], 5.0, true)
		draw_circle(point1['position'], 5.0, point1['modulate'])


func _on_Ball_dead(bounce_historic):
	_bounce_historic = bounce_historic
	update()
