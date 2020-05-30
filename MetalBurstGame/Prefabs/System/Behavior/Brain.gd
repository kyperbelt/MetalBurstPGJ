extends Node

class_name Brain, "res://Assets/Tools/Behavior/brain.png"

#data used by this brain and all nodes in the behavior tree
#if a node requires some data than it must be added to the blackboard.
var _root : BehaviorNode = null
var _running = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	_update_brain(delta)

func is_running():
	return _running

func start(blackBoard):
	if(_running):
		return
	else:
		_running = true
		_root.initiate(blackBoard)
	pass

func _update_brain(_delta):
	if(_running): return BehaviorNode.RunState.Failed
	if(_root!=null):
		return _root._update_behavior(_delta)
	return BehaviorNode.RunState.Failed
