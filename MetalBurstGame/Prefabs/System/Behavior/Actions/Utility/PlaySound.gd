extends Action

class_name PlaySound

export(String) var _soundName

func initiate():
	.initiate()


func _update_behavior(_delta:float)->int:
	var _value = Globals.audioManager.play_sound(_soundName)
	if(_value):
		return RunState.Success
	else:
		return RunState.Failed