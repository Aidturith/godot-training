extends Node2D

var colors = []
var layout = Vector2(6, 5)

var _brick_factory = preload("res://src/breakout/brick.tscn")
var _rng := RandomNumberGenerator.new()

func _ready():
	_rng.randomize()
	VisualServer.set_default_clear_color(Color("#191919"))
	add_bricks()
	query_colors()


func add_bricks():
	var viewport = get_viewport_rect() # TODO use viewport
	for i in range(1, layout.x + 1):
		for j in range(1, layout.y + 1):
			var brick = _brick_factory.instance()
			var height = brick.get_node("CollisionShape2D").shape.extents.y
			var width = brick.get_node("CollisionShape2D").shape.extents.x
			var spacing = 20
			brick.position = Vector2(i * width * 2, j * height * 3)
			$BrickContainer.add_child(brick)


func query_colors():
	var data = '{"model":"default"}'
	$HTTPRequest.request("http://colormind.io/api/", 
		["user-agent: Color Breakout, aidturith.itch.io"],
		false, HTTPClient.METHOD_POST, data)


func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	print(response_code)
	var json = JSON.parse(body.get_string_from_utf8())
	for rgb in json.result.result:
		colors.append(Color(rgb[0]/255, rgb[1]/255, rgb[2]/255))
	color_bricks()
	# TODO onready / loading


func color_bricks():
	var bricks = $BrickContainer.get_children()
	for i in range(bricks.size()):
		# var new_color = pick_random_color()
		bricks[i].modulate = colors[i % int(layout.y)]


func pick_random_color():
	var i = _rng.randi_range(0, colors.size() - 1)
	return colors[i]
