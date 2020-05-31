extends Node

class_name BehaviorNode

#the data used by this node
var _blackBoard = {}
var _brain = null
var _parentBehavior : BehaviorNode = null
var _lastState : RunState = RunState.Nothing
var _state : RunState = RunState.Failed


func set_state(state):
	_state = state

func get_state():
	return _state

func set_brain(brain:Brain):
	_brain = brain;

func get_brain():
	return _brain

func set_parent_behavior(parentBehavior:BehaviorNode):
	_parentBehavior = parentBehavior

func get_parent_behavior()->BehaviorNode:
	return _parentBehavior

func get_blackboard():
	return _blackBoard

#if overwritten must be called as well. 
func initiate(board):
	_blackBoard = board
	_state = RunState.Running
	_brain.set_current(self)

	
func _ready():
	set_process(false)#proccessing handled by brain
	pass

func update_behavior(_delta:float)->RunState:
	return RunState.Failed
	
