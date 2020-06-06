tool
extends Node
#TODO: make check for missing root node using tool
class_name Brain, "res://Assets/Tools/Behavior/brain.png"

#data used by this brain and all nodes in the behavior tree
#if a node requires some data than it must be added to the blackboard.
var _blackBoard : Dictionary = {}
var _root :BehaviorNode= null
var _current = null
var _lastState : int = RunState.Running
var _running = false

func _ready():
	if(Engine.is_editor_hint()):
		pass
	else:
		set_process(false)
		print("starting brain")
		start({},_find_first_behavior())
	
func is_running():
	return _running

func start(blackBoard,root:BehaviorNode):
	_root = root
	_running = true
	_blackBoard = blackBoard
	root.set_brain(self)
	root.initiate()
	root.set_parent_behavior(null)
	_current = root
	
func get_blackboard():
	return _blackBoard

func set_blackboard(blackBoard):
	_blackBoard = blackBoard

func set_current(current:BehaviorNode):
	_current=current

func get_current()->BehaviorNode:
	return _current

func get_root_behavior()->BehaviorNode:
	return _root

func get_last_state()->int:
	return _lastState

func update_brain(delta)->bool:
	if(_running):
		if(_root!=null):
			var state : int = _root._update_behavior(delta)
			if(state != RunState.Running):
				_running = false
				_lastState = state
	return _running

	#find the first behavior node child
func _find_first_behavior()->BehaviorNode:
	for child in get_children():
		if(child.is_class("BehaviorNode")):
			print("behavior found:"+child.get_name())
			return child as BehaviorNode
	return null
	

func _get_configuration_warning():
	if(Engine.is_editor_hint()):
		for child in get_children():
			if(child is BehaviorNode):
				return ""
	return """
			No BehaviorNode Detected! please add a child BehaviorNode to this Brain. 
			Either a Composite, Decorator or Action Node will suffice. They can be
			nested to create more complex behaviors. 
		   """
