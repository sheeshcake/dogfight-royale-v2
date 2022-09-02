extends KinematicBody2D


const BULLET = preload("res://node/bullet.tscn")
export (int) var speed = 50
export (float) var rotation_speed = 2

var velocity = Vector2(0, 0)
var rotation_dir = 0
var running = false
var ready_to_shoot = true
var on_floor = true
onready var tween = $Tween
puppet var puppet_position = Vector2(0, 0) setget puppet_position_set
puppet var puppet_rotation = 0
puppet var puppet_velocity = Vector2()

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
	if is_network_master():
		get_input()
		rotation += rotation_dir * rotation_speed * delta
		velocity = Vector2(speed, 0).rotated(rotation)
	else:
		rotation_degrees = lerp(rotation_degrees, puppet_rotation, delta * 8)
		if not tween.is_active():
			puppet_velocity = Vector2(speed, 0).rotated(rotation)

func puppet_position_set(new_value):
	puppet_position = new_value
	tween.interpolate_property(self, "global_position", global_position, 0.1)
	tween.start()

func _on_Timer_timeout():
	ready_to_shoot = true


func _on_NetworkTickRate_timeout():
	if is_network_master():
		rset_unreliable('puppet_position', global_position)
		rset_unreliable('puppet_velocity', velocity)
		rset_unreliable('puppet_rotation', rotation_degrees)
