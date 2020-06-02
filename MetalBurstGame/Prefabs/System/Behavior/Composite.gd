extends BehaviorNode

#TODO: Add editor tool support to identify when child nodes are missing
class_name Composite, "res://Assets/Tools/Behavior/sequence.png"

var _childBehaviors = []

func add_child_behavior(child)->Composite:
	_childBehaviors.append(child)
	child.set_parent_behavior(self)
	return self

func get_child_behaviors():
	return _childBehaviors

func _ready():
	_find_child_behaviors()
	pass # Replace with function body. cache all ChildBehaviors Here

	#find all child behaviors in this node
func _find_child_behaviors():
	for child in get_children():
		if(child.is_type("BehaviorNode")):
			add_child_behavior(child)
