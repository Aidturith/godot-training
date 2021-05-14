class_name Voronoi

extends Reference


var _world_size := Vector2(12, 12)
var _seeds := []

var cells := []


func _init(world_size: Vector2, seeds: Array):
	_world_size = world_size
	_seeds = seeds
	init_cells()
	voronoi()
	trim_cells()
	trim_cells()



func init_cells():
	for x in range(0, _world_size.x):
		cells.append([])
		for y in range(0, _world_size.y):
			cells[x].append(null)
	

func voronoi():
	for x in range(0, _world_size.x):
		for y in range(0, _world_size.y):
			var pos = Vector2(x, y)
			for s in _seeds:
				if (cells[x][y] == null or 
						distance(pos, s) < distance(pos, cells[x][y])):
					cells[x][y] = s


func distance(a: Vector2, b: Vector2) -> float:
	return manhattan(a, b)


func manhattan(a: Vector2, b: Vector2) -> float:
	var dx = a.x - b.x
	var dy = a.y - b.y
	return abs(dx) + abs(dy)


func trim_cells():
	var cells_trimmed = cells.duplicate(true)
	for x in range(0, _world_size.x):
		for y in range(0, _world_size.y):
			var count = 0
			var current = cells[x][y]
			if x - 1 >= 0 and cells[x-1][y] == current:
				count += 1
			if y - 1 >= 0 and cells[x][y-1] == current:
				count += 1
			if x + 1 < _world_size.x and cells[x+1][y] == current:
				count += 1
			if y + 1 < _world_size.y and cells[x][y+1] == current:
				count += 1
			if count == 1:
				cells_trimmed[x][y] = Vector2(-1, -1)
	cells = cells_trimmed
