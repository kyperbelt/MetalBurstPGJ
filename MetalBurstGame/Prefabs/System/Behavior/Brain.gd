extends Node

class_name Brain, "res://Assets/Tools/Behavior/brain.png"

#data used by this brain and all nodes in the behavior tree
#if a node requires some data than it must be added to the blackboard.
var _blackBoard = {}
var _root :BehaviorNode= null
var _current = null
var _lastState : RunState = RunState.Running
var _running = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	_update_brain(delta)

func is_running():
	return _running

func start(blackBoard,root:BehaviorNode):
	_root = root
	_running = true
	_blackBoard = blackBoard
	root.set_brain(self)
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

func _update_brain(delta)->bool:
	if(_running):
		if(_root!=null):
			var state : RunState = _root.update_behavior(delta)
			if(state != RunState.Running):
				_running = false
				_lastState = state
		pass
	return _running
	
