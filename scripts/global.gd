extends Node

func instance_node_at_location(node, parent, location):
	var node_instance = instance_node(node, parent)
	node_instance.global_position = location
	return node_instance


func instance_node(node, parent):
	var node_instance = node.instance()
	parent.add_child(node_instance)
	return node_instance
