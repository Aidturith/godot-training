extends Node2D

var world

var world_size := Vector2(12, 12)
var tile_size := Vector2(10, 8) * 2

var rng := RandomNumberGenerator.new()
var nb_seeds = 10
var seeds := []
var seeds_biome := []
var seeds_color := []
var biomes := []

enum Biomes {
	LAND,
	BEACH,
	MOUNTAIN,
	GRASSLAND,
	MARSHLAND,
	VILLAGE_BIG,
	VILLAGE_SMALL,
	DESERT,
	WOODS,
	GRAVEYARD,
	CASTLE,
	PALACE,
	RAPIDS,
	RIVER,
}

var colors = {
	Biomes.LAND: Color("#308857"),
	Biomes.BEACH: Color("#EFBE74"),
	Biomes.MOUNTAIN: Color("#EA5566"),
}


func _ready():
	rng.randomize()
	init_seeds(nb_seeds)
	var voronoi = Voronoi.new(world_size, seeds)
	select_biomes()
	assign_biomes(voronoi.cells)


func init_seeds(nb_seeds: int):
	for i in range(0, nb_seeds):
		var sx := rng.randi_range(0, world_size.x - 1)
		var sy := rng.randi_range(0, world_size.y - 1)
		var color := Color(rng.randf(), rng.randf(), rng.randf())
		seeds.append(Vector2(sx, sy))
		seeds_color.append(color)


func _draw():
	for x in world.size():
		for y in world[x].size():
			var pos = Vector2(x * tile_size.x, y * tile_size.y)
			var color = get_color(world[x][y])
			draw_rect(Rect2(pos, tile_size), color, true, 5.0)
			if Vector2(x, y) == world[x][y]:
				color = Color(0, 0, 0, 0.4)
				draw_rect(Rect2(pos, tile_size), color, true, 5.0)
			if Vector2(-1, -1) == world[x][y]:
				color = Color(1, 1, 1, 1)
				draw_rect(Rect2(pos, tile_size), color, true, 5.0)


func get_biome(pos: Vector2) -> int:
	var i = seeds.find(pos)
	return seeds_biome[i]


func get_color(pos: Vector2) -> Color:
	var i = seeds.find(pos)
	return seeds_color[i]
	

func select_biomes():
	biomes = [Biomes.LAND, Biomes.BEACH, Biomes.MOUNTAIN]
	while biomes.size() < nb_seeds:
		var pick = rng.randi_range(0, Biomes.size())
		if not pick in biomes:
			biomes.append(pick)


func assign_biomes(cells: Array):
	world = cells.duplicate(true)
	var biomes_sizes := new_array(0, nb_seeds)
	var biomes_top := new_array(false, nb_seeds)
	var biomes_bottom := new_array(false, nb_seeds)
	for x in range(0, world_size.x):
		for y in range(0, world_size.y):
			var i = seeds.find(cells[x][y])
			if cells[x][y] == Vector2(-1, -1):
				world[x][y] = 0
				biomes_sizes[0] += 1
			else:
				world[x][y] = -i
				biomes_sizes[i] += 1
			if y == 0:
				biomes_top[i] = biomes_top[i] or true
			if y == world_size.y - 1:
				biomes_bottom[i] = biomes_bottom[i] or true
	print(biomes_sizes)
	print(biomes_top)
	print(biomes_bottom)
	print(world)


func new_array(elt, size: int) -> Array:
	var array = []
	for i in range(0, size):
		array.append(elt)
	return array
