tool
extends PositionalEvent

class_name SoundEvent, "res://Assets/Tools/audio.png"

enum SoundType{
	Sfx,
	Music
}

func _ready():
	if Engine.editor_hint:
		update()
	

#EXPORTS
export(String) var S_O_U_N_D = get_sep() setget set_sep,get_sep
func set_sep(_sep):
	update()
func get_sep():
	return ""

export(String) var _soundName = "Untitled"
export(SoundType) var _soundType = SoundType.Music;
export(float) var _volume = 0;

func _on_event_added():
	pass

func _execute_event():
	var _value = Globals.audioManager.playSound(_soundName,_volume)
	pass

func _process(_delta):
	if(Engine.editor_hint):
		update_y()