tool
extends PositionalEvent

class_name SoundEvent, "res://Assets/Tools/audio.png"

enum SoundType{
	Sfx,
	Music
}

enum EventType{
	Start,
	# Pause,
	# Resume,
	Stop
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
export(SoundType) var _soundType = SoundType.Music
export(EventType) var _eventType = EventType.Start
export(float) var _volume = 0;

func _on_event_added():
	pass

func _execute_event():
	match _soundType:
		SoundType.Music:
			match _eventType:
				EventType.Start:
					var _value = Globals.audioManager.play_music(_soundName,_volume)
				EventType.Stop:
					var _value = Globals.audioManager.stop_music(_soundName)
				_:
					pass		
			
		SoundType.Sfx:		
			var _value = Globals.audioManager.play_sound(_soundName,_volume)
		_:
			pass

	pass

func _process(_delta):
	if(Engine.editor_hint):
		update_y()
