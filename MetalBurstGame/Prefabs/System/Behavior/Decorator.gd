extends BehaviorNode

#TODO: create a tool script to verify that there is a child node attached
class_name Decorator, "res://Assets/Tools/Behavior/decorator.png"

var _childBehavior = null

func set_child_behavior(child):
	_childBehavior = child
	child.set_parent_behavior(self)

func get_child_behavior()->BehaviorNode:
	return _childBehavior

func _ready():
	_find_first_behavior()
	pass # Replace with function body.

func _find_first_behavior():
	for child in get_children():
		if(child.is_type("BehaviorNode")):
			set_child_behavior(child)

