extends Node

class_name BehaviorNode

enum RunState{
	Running, 
	Failed,
	Success
}

#the data used by this node
var blackBoard = {}

#if overwritten must be called as well. 
func initiate(board):
	blackBoard = board

	
func _ready():
	pass

func _update_behavior(_delta:float):
	return RunState.Failed
	
func _process(delta):
	_update_behavior(delta)
