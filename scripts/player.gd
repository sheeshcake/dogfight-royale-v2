extends KinematicBody2D


const BULLET = preload("res://node/bullet.tscn")
export (int) var speed = 50
export (float) var rotation_speed = 2

var velocity = Vector2()
var rotation_dir = 0
var running = false
var ready_to_shoot = true
var on_floor = true

func start(pos):
	velocity = Vector2(pos)

func get_input():
	rotation_dir = 0
	if Input.is_action_pressed("ui_right") and !on_floor:
		rotation_dir += 1
	if Input.is_action_pressed("ui_left") and !on_floor:
		rotation_dir -= 1
	if Input.is_action_pressed("ui_up") and on_floor:
		on_floor = false
		running = true
	
	if running:
		velocity = move_and_slide(velocity)
		
	if Input.is_action_just_pressed("shoot") && ready_to_shoot:
		ready_to_shoot = false
		$Timer.start(1)
		shoot()

func shoot():
	var b = BULLET.instance()
	b.start($Target.global_position, rotation)
	get_parent().add_child(b)
		

func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = Vector2(speed, 0).rotated(rotation)


func _on_Timer_timeout():
	ready_to_shoot = true
