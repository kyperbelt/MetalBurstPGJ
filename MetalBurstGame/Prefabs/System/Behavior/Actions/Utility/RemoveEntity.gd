extends Action


#Removes the entity that is the owner of this behavior
#TODO: add functionality to remove external entities
class_name RemoveEntity

var _self = null

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]


func _update_behavior(_delta:float)->int:
	print(_self.name + " queued for removal!")
	_self.queue_free()
	return RunState.Success
