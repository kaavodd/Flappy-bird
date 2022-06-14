extends Node2D

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var my_random_number = rng.randf_range(-300.0, 200.0)
	position.y += my_random_number
