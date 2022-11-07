extends RigidBody2D

signal hit
signal game_over

var hitted = false

func _ready():
	$AnimationPlayer.play("walk", -1, randf() * 0.5 + 0.75)
	var scale = randf() * 0.1
	$Sprite.scale.x += scale
	$Sprite.scale.y += scale

func _integrate_forces(delta):
	z_index = position.y;

func _input(event):
	if not hitted and event.is_action_pressed("wave") and randf() < 0.1:
		emit_signal("hit")
		hitted = true
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	if not hitted:
		emit_signal("game_over")
	queue_free()
 
