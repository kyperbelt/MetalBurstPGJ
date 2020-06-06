tool
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
	if(!Engine.is_editor_hint()):
		_find_child_behaviors() #cache all ChildBehaviors Here

	#find all child behaviors in this node
func _find_child_behaviors():
	for child in get_children():
		if(child is BehaviorNode):
			add_child_behavior(child)
			
func _get_configuration_warning():
	if(Engine.is_editor_hint()):
		for child in get_children():
			if(child is BehaviorNode):
				return ""
	return """
			No child BehaviorNode was found so this will not function properly.
			Try adding BehaviorNodes like Decorators,Composite or Actions for the
			sequence to perform correctly.
		   """
