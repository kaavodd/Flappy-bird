extends Node2D
onready var obstacleprefab = preload("res://scene/Obstacle.tscn")
var compteur = 0
var high_score
var barricade = 0
var rng = RandomNumberGenerator.new()
const SAVE_DIR = "user://saves/"
var save_path = SAVE_DIR + "save.dat"
func _ready():
	_on_load()

func _on_Area2D_body_entered(_body):
	$player/point.play()
	compteur +=1
	$player/CanvasLayer/Control/Label.text = str(compteur)
	$player/CanvasLayer2/Control/Sprite/Label5.text = str(compteur)
	$Timer.start()
	score()
func _on_Timer_timeout():
	barricade = randi() % 200 
	if barricade > 100:
		$Obstacle2/barricade.visible = true
		$Obstacle2/barricade/CollisionShape2D.disabled = false
	else:
		$Obstacle2/barricade.visible = false
		$Obstacle2/barricade/CollisionShape2D.disabled = true
	rng.randomize()
	$Obstacle2.position.x = $player.position.x + 760
	$Obstacle2.position.y = rng.randf_range(-300.0,200.0)
	$Obstacle2.visible = true 
	$Obstacle2/bulle/bulle.visible = true 
	$Obstacle2/bulle/bulle/CollisionShape2D.disabled = false
	$Obstacle2/KinematicBody2D2/Area2D/CollisionShape2D.disabled = false
	$Obstacle2/KinematicBody2D/CollisionShape2D.disabled = false
	$Obstacle2/KinematicBody2D2/CollisionShape2D2.disabled = false
func _on_Area2D2_body_entered(_body):
	$player/point.play()	
	compteur +=1
	$player/CanvasLayer/Control/Label.text = str(compteur)
	$Timer2.start()
	score()
func _on_Timer2_timeout():
	$Obstacle.position.x = $player.position.x + 760
	$Obstacle.position.y = rng.randf_range(-200.0,200.0)
	$Obstacle/bulle/bulle.visible = true 
	$Obstacle/bulle/bulle/CollisionShape2D.disabled = false
func score():
	$player/CanvasLayer/ColorRect/Label2.text = str(compteur)
	if high_score < compteur:
		high_score= compteur
		$player/CanvasLayer/ColorRect/Label5.visible = true
		$player/CanvasLayer/ColorRect/Label4.text = str(high_score)
		$player/CanvasLayer2/Control/Sprite/Label4.text = str(high_score)
	else:
		$player/CanvasLayer/ColorRect/Label4.text = str(high_score)
		$player/CanvasLayer2/Control/Sprite/Label4.text = str(high_score)

func _on_save_game_pressed():
	$player/CanvasLayer2/AnimationPlayer.play("load_game")
func _on_load():
	var file = File.new()
	if file.file_exists(save_path):
		var error = file.open(save_path, File.READ)
		if error == OK:
			var player_data = file.get_var()
			file.close()
			print(player_data.get("high_score"))
			high_score = player_data.get("high_score") 
func _on_High_score_pressed():
	$player/CanvasLayer2/AnimationPlayer.play("High_score")
	$player/CanvasLayer2/Control/Sprite/Label4.text = str(high_score)
func _on_Button_pressed():
	$player/CanvasLayer2/AnimationPlayer.play("quitter")
func _on_Main_menu_pressed():
	var save_dict = {
		"high_score" : high_score,
		"score" : compteur
	}
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	var save = File.new()
	var error = save.open(save_path, File.WRITE)
	if error == OK:
		save.store_var(save_dict)
		save.close()
	$player/AnimationPlayer.play("Main_menu")
func _on_Commencer_body_entered(_body):
	score()


func _on_Timer3_timeout():
	$player/CanvasLayer2/Label.visible = false


func _on_Play_pressed():
	$Timer3.start()
