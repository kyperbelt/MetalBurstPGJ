extends Action

# spawn an entity by creating an instance of it 
# and then adding it to the engine
# at a position relative to itself 
# with a specified offset.
class_name Spawn

export (PackedScene) var _spawn
export (Vector2) var _offset = Vector2.ZERO

var _self = null
var _engine = null


func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	_engine = get_blackboard()[BB.ENGINE]
	
func _update_behavior(_delta:float)->int:
	if(_spawn == null):return RunState.Failed
	var object = _spawn.instance()
	if(object.get("position")!=null):
		object.position = (_self.position + _offset)
	_engine.add_child(object)
	return RunState.Success



