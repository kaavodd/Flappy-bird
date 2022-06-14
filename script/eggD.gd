extends KinematicBody2D

var speed = 500
var vel = Vector2()
func start(pos):
	position = pos 
	vel += Vector2(speed , 0)
func _process(delta):
	move_and_collide(vel * delta)

func _on_hitbox_body_shape_entered(body_id, body, _body_shape, _area_shape):
	if body.is_in_group("environnement"):
		self.queue_free()
		print("environnement")
	if body.is_in_group("obstacle"):
		body.visible = false
		body.get_node("CollisionShape2D").call_deferred("set","disabled",true)
		print(body_id)
		self.queue_free()
