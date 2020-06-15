extends Node

class_name BehaviorNode

var _brain = null
var _parentBehavior : BehaviorNode = null
var _lastState : int = RunState.Failed
var _state : int = RunState.Failed

	
func _ready():
	set_process(false)#proccessing handled by brain

func set_state(state):
	_state = state

func get_state():
	return _state

func set_brain(brain):
	_brain = brain;

func get_brain():
	return _brain if _brain != null else get_parent_behavior().get_brain()

func set_parent_behavior(parentBehavior:BehaviorNode):
	_parentBehavior = parentBehavior

func get_parent_behavior()->BehaviorNode:
	return _parentBehavior

func get_blackboard()->Dictionary:
	return get_brain().get_blackboard()

#if overwritten must be called as well. 
func initiate():
	_state = RunState.Running
	get_brain().set_current(self)


func _update_behavior(_delta:float)->int:
	return RunState.Failed

func is_class(type):
	return type == get_class()

func get_class()->String:
	return "BehaviorNode"
	
