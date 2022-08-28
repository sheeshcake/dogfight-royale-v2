extends KinematicBody2D

var speed = 250
var velocity = Vector2()


func start(pos, dir):
	$AnimatedSprite.play("default")
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		$AnimatedSprite.play("blast")
		velocity = Vector2()
		#velocity = velocity.bounce(collision.normal)
		#if collision.collider.has_method("hit"):
			#collision.collider.hit()
			
func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == 'blast':
		queue_free()
		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
