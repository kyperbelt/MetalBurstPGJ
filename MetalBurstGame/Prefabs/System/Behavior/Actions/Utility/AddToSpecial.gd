extends Action

#add self to special entities list
class_name AddToSpecial

export(String) var _name = "uniqueName"

var _self = null
var _engine = null
var _specialList : Dictionary;

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	_engine = get_blackboard()[BB.ENGINE]
	_specialList = (_engine as MBengine)._specialEntitiesList

func  _update_behavior(_delta:float)->int:
	_specialList[_name] = _self;
	return RunState.Success
