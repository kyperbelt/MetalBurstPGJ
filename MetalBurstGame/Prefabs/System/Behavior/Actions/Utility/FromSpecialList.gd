extends Action

# get the entity from the special List 
# and add it to the Blackboard of this entity 
class_name FromSpecialList

export(String) var _specialEntity = "nameInList"
export(String) var _blackboardName = "nameInBlackboard"


var _self = null;
var _engine = null;

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	_engine = get_blackboard()[BB.ENGINE]


func _update_behavior(_delta:float)->int:
	var _list :Dictionary = (_engine as MBengine)._specialEntitiesList;

	if(_list.has(_specialEntity)):
		return RunState.Failed
	
	get_blackboard()[_blackboardName] = _list[_specialEntity]

	return RunState.Success