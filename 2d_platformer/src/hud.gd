extends CanvasLayer

var coins = 0


func _ready():
	update_label()


func update_label():
	$Panel/Coins.text = String(coins)


func add_coin():
	coins += 1
	update_label()


func _on_Coin1_coin_collected():
	add_coin()
	if coins == 8:
		get_tree().change_scene("res://src/Level1.tscn")
