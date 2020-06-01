extends BehaviorNode

#TODO: Add editor tool support to identify when child nodes are missing
class_name Composite, "res://Assets/Tools/Behavior/sequence.png"

var _childBehaviors = []

func add(child:BehaviorNode)->Composite:
	_childBehaviors.append(child)
	child.set_parent_behavior(self)
	return self

func get_child_behaviors():
	return _childBehaviors

func _ready():
	pass # Replace with function body.

