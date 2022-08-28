extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Note: passing a value for the type parameter causes a crash
static func get_child_of_type(node: Node, child_type):
	for i in range(node.get_child_count()):
		var child = node.get_child(i)
		if child_type in child.name:
			return child



func _process(delta):
	var map_limits = $Node2D2/TileMap.get_used_rect()
	var map_cellsize = $Node2D2/TileMap.cell_size
	var player = get_child_of_type(self, 'KinematicBody2D')
	player.get_node('Camera2D').limit_left = (map_limits.position.x + 1) * map_cellsize.x
	player.get_node('Camera2D').limit_right = (map_limits.end.x - 1) * map_cellsize.x
	player.get_node('Camera2D').limit_top = (map_limits.position.y + 1) * map_cellsize.y
	player.get_node('Camera2D').limit_bottom = (map_limits.end.y - 1) * map_cellsize.y

