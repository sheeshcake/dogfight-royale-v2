extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
const PLANE = preload("res://node/player_with_plane.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	var b = PLANE.instance()
	body.get_plane()
	b.global_position = $Position2D.global_position
	get_parent().add_child(b)
