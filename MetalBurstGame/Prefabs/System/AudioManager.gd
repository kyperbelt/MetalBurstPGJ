extends Node

class_name AudioManager, "res://Assets/Tools/wave.png"

var _audioStreams = {}
var _busMap = {}

func _ready():
	if Globals.audioManager != null:
		Globals.audioManager.queue_free();
		Globals.audioManager = null;
	Globals.audioManager = self;
	
	load_streams()
	map_busses()
	print_bus_info()


#attempt to play a sound - return false if unable to play sound
func playSound(sound:String,volume_db:float = 0)->bool:
	if(sound in _audioStreams):
		var player := _audioStreams[sound] as AudioStreamPlayer;
		player.volume_db = volume_db
		player.play(0)
		return true;
	printerr("ERROR: No sound named [%s] found in AudioManager"%sound);
	return false;

func load_streams():
	for stream in get_children():
		if (stream is AudioStreamPlayer):
			var key : String =  stream.name;
			var value : AudioStreamPlayer = stream;
			_audioStreams[key] = value
			print("Added %s to AudioManager"%key)

func map_busses():
	for i in range(AudioServer.bus_count):
		_busMap[AudioServer.get_bus_name(i)] = i

func print_bus_info():
	print("-------------- AudioManager ------------")
	print("Current Device:[%s]"%AudioServer.capture_get_device())
	print("BusCount[%d]"%AudioServer.bus_count)
	print(" ");
	print("BusList:")
	for i in range(AudioServer.bus_count):
		print("  -%-20s dB:%.3f"% [AudioServer.get_bus_name(i),AudioServer.get_bus_volume_db(i)])
		var effectCount : int = AudioServer.get_bus_effect_count(i);
		if(effectCount > 0 ):
			print(" [EFFECTS]:")
		for j in range(effectCount):
			var af : AudioEffect = AudioServer.get_bus_effect(i,j)
			print("      -%s"%af.get_class())
		print("________________________________________")
