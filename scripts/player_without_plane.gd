extends KinematicBody2D

export (int) var run_speed = 20
export (int) var jump_speed = -400
export (int) var gravity = 50

var velocity = Vector2()
var jumping = false

func get_plane():
	queue_free()


func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_select')

	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if is_on_floor():
		$AnimatedSprite2.play("close_parachute")
		$AnimatedSprite3.play("close")
		
	if right:
		$AnimatedSprite.play("running_right")
		velocity.x += run_speed
	if left:
		$AnimatedSprite.play("running_left")
		velocity.x -= run_speed
	elif !left and !right and !jump:
		$AnimatedSprite.play("idle")

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	
	if !is_on_floor():
		$AnimatedSprite.play("parashoot")
		$AnimatedSprite2.play("open_parachute")
		$AnimatedSprite3.play("parashoot")
	velocity = move_and_slide(velocity, Vector2(0, -1))
