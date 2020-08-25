extends Action


#check the distance relative to an object
#if the eneity parent to this behavior exceeds the specified distance
#then return Success
class_name CheckDistance

enum RelativeObjects{
	RPlayer,
	RPlayArea
}

export(float) var max_distance = 100
export(RelativeObjects) var robject = RelativeObjects.RPlayArea

var _self = null
var _point : Vector2 = Vector2(0,0) 

func initiate():
	.initiate()
	_self = get_blackboard()[BB.SELF]
	_point = ZoneMap.get_zone_position(ZoneMap.Zones.Center,get_blackboard()[BB.PLAY_AREA]) if robject == RelativeObjects.RPlayArea else get_blackboard()[BB.PLAYER].position	
	


func _update_behavior(_delta:float)->int:
	var sp : Vector2 = _self.position
	if(sp.distance_to(_point) >= max_distance):
		return RunState.Success
	
	return RunState.Failed


