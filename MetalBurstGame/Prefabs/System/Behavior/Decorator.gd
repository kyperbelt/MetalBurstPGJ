extends BehaviorNode

class_name Decorator, "res://Assets/Tools/Behavior/decorator.png"

var _childBehavior:BehaviorNode = null

func set_child_behavior(child:BehaviorNode):
	_childBehavior = child
	child.set_parent_behavior(self)

func get_child_behavior()->BehaviorNode:
	return _childBehavior

func _ready():
	pass # Replace with function body.

