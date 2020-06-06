tool
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
	if(!Engine.is_editor_hint()):
		_find_first_behavior()

func _find_first_behavior():
	for child in get_children():
		if(child is BehaviorNode):
			set_child_behavior(child)
			break

func _get_configuration_warning():
	if(Engine.is_editor_hint()):
		for child in get_children():
			if(child is BehaviorNode):
				return ""
	return """
			Decorators require a node to decorate(apply their effect on) they do
			not do anything on their own. Try adding a child BehaviorNode. 
		   """
