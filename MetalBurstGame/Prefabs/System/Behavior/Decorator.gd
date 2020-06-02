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
	pass # Replace with function body.

