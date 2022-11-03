extends KinematicBody2D

var start_position = Vector2(300,800)
var player = null
var nav = null

var speed = 100

func _ready():
	position = start_position
	
func _physics_process(delta):
	if nav == null:
		nav = get_node_or_null("/root/Game/Navigation2D")
	elif player == null:
		player = get_node_or_null("/root/Game/Player_Container/Player")
	else:
		var points = nav.get_simple_path(global_position, player.global_position,true)
		if points.size() > 1:
			var target = points[1] - global_position
			var s = speed
			if target.length() > s:
				s = target.length()
			if abs(s) < 1:
				s = 0
			var direction = target.normalized()
			var _v = move_and_slide(direction*s, Vector2.ZERO)

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.queue_free()
		queue_free()
