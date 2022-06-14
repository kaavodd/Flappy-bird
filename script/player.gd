extends KinematicBody2D

var mouvement = Vector2()
var rebond = 150
var gravite = 200
var play
var tir =0
var shoot = preload("res://scene/eggD.tscn")
func _ready():
	set_physics_process(false)
func _physics_process(delta):
	move_and_slide(mouvement)
	mouvement.x = play
	mouvement.y += gravite * delta
	movement()
func movement():
	var voler = Input.is_action_just_pressed("voler")
	var tirer = Input.is_action_just_pressed("tirer")
	if voler == true:
		mouvement.y =- rebond
		$fly.play()
	if tirer == true && tir >=1:
		tir -=1
		$CanvasLayer/Control/Label3.text = str(tir)
		var b = shoot.instance()
		b.start($Position.global_position)
		get_parent().add_child(b)
func _on_Hitbox_body_shape_entered(_body_id, body, _body_shape, _area_shape):
	if body.is_in_group("environnement"):
		$AnimationPlayer.play("Game_over")
		set_physics_process(false)
		$AnimatedSprite.playing = false
		$hit.play()
	if body.is_in_group("obstacle"):
		$AnimationPlayer.play("Game_over")
		set_physics_process(false)
		$AnimatedSprite.playing = false
		$hit.play()
		print("obstacle")
	if body.is_in_group("tir"):
		pass
	if body.is_in_group("bulle"):
		body.visible = false
		body.get_node("CollisionShape2D").call_deferred("set","disabled",true)
		tir +=1
		$CanvasLayer/Control/Label3.text = str(tir)
		print(tir)

func _on_Main_menu_pressed():
	$AnimationPlayer.play("Main_menu")
	get_tree().reload_current_scene()

func _on_Play_pressed():
	$CanvasLayer2/AnimationPlayer.play("play")
	set_physics_process(true)
	play = 100
