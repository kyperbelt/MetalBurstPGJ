extends Node
#Audio manager class 
#--------------------
# usage: 
# store all sound effects and music in a neat container that can be reused for multiple scenes
# This lets us reuse scripts without having to add new AudioPlayers
class_name AudioManager, "res://Assets/Tools/wave.png"

export(bool) var _instanceNewSFX = false

var _musicStreams = {}
var _sfxStreams = {}

#map of audio busses in {"name":index} format
var _busMap = {} setget _set_bus_map,get_bus_map

func _ready():
	#TODO: At some point we want to make this a singleton where it doesnt get instantiated more than once
	# 	   unless we have some unique need like a different set of sounds that must be loaded whilst not requiring any of the old ones. 
	if Globals.audioManager != null:
		# if weakref(Globals.audioManager).get_ref() :
		# 	Globals.audioManager.queue_free()
		Globals.audioManager = null
	Globals.audioManager = self
	
	load_streams()
	map_busses()
	print_bus_info()

func play_music(music:String,volume_db:float = 0)->bool:
	if(music in _musicStreams):
		var player := _musicStreams[music] as AudioStreamPlayer
		if(volume_db != -999):
			player.volume_db = volume_db
		player.play(0)
		return true
	printerr("ERROR: No music named [%s] found in AudioManager"%music)
	return false

#attempt to play a sound - return false if unable to play sound
func play_sound(sound:String,volume_db:float = -999,instance = false)->bool:
	if(sound in _sfxStreams):
		var player := _sfxStreams[sound] as AudioStreamPlayer
		if(volume_db != -999):
			player.volume_db = volume_db
		#_clone_stream(player).play(0)	
		if(instance || _instanceNewSFX):
			var c : AudioStreamPlayer = _clone_stream(player)#player.duplicate(DUPLICATE_USE_INSTANCING | DUPLICATE_SCRIPTS)#play from position 0 -
			add_child(c)
			c.volume_db = player.volume_db
			c.bus = player.bus
			c.play(0)
		else:
			player.play(0)
		return true
	printerr("ERROR: No sound named [%s] found in AudioManager"%sound)
	return false

#set the bus db volume using the name of the bus
func set_name_volume(busName:String,volume_db:float)->void:
	set_id_volume(_busMap[busName],volume_db)

#set the bus db volume using busId
func set_id_volume(busId:int,volume_db:float)->void:
	AudioServer.set_bus_volume_db(busId,volume_db)

#get the bus volume using the name of the bus
func get_name_volume(busName:String)->float:
	return get_id_volume(_busMap[busName])

#get bus db volume using busId
func get_id_volume(busId:int)->float:
	return AudioServer.get_bus_volume_db(busId)

#attempt to stop all instances of the soundeffect - return true if success
func stop_sound(sound:String)->bool:
	printerr("stop sound not yet implemented in AudioManager")
	return false

#attempt to stop music - return true if success
func stop_music(music:String)->bool:
	if(music in _musicStreams):
		var player := _musicStreams[music] as AudioStreamPlayer
		player.stop()
		return true
	printerr("ERROR: No music named [%s] found in AudioManager"%music)
	return false

func pause_music(music:String)->float:
	printerr("pause music not yet implemented in AudioManager")
	return -1.0

func resume_music(music:String,position:float)->bool:
	printerr("resume music not yet implemented in AudioManager")
	return false

#cannot set the bus map
func _set_bus_map(__busMap):
	pass

# return a map of audio busses in {"name":index} format
# cannot be edited- if you would like to add a map
func get_bus_map()->Dictionary:
	return _busMap.duplicate(true)

func load_streams():
	var music = $Music
	var sound = $Sound
	for stream in music.get_children():
		if (stream is AudioStreamPlayer):
			var key : String =  stream.name
			var value : AudioStreamPlayer = stream
			_musicStreams[key] = value
			print("Added %s to AudioManager._musicStreams"%key)
	for stream in sound.get_children():
		if (stream is AudioStreamPlayer):
			var key : String =  stream.name
			var value : AudioStreamPlayer = stream
			_sfxStreams[key] = value
			print("Added %s to AudioManager._sfxStreams"%key)
		

func map_busses():
	for i in range(AudioServer.bus_count):
		_busMap[AudioServer.get_bus_name(i)] = i

func print_bus_info():
	print("============== AudioManager ==============")
	print("Current Device:[%s]"%AudioServer.capture_get_device())
	print("BusCount[%d]"%AudioServer.bus_count)
	print(" ")
	print("BusList:")
	for i in range(AudioServer.bus_count):
		print("  -%-20s dB:%.3f"% [AudioServer.get_bus_name(i),AudioServer.get_bus_volume_db(i)])
		var effectCount : int = AudioServer.get_bus_effect_count(i)
		if(effectCount > 0 ):
			print(" [EFFECTS]:")
		for j in range(effectCount):
			var af : AudioEffect = AudioServer.get_bus_effect(i,j)
			print("      -%s"%af.get_class())
		print("________________________________________")


func _clone_stream(stream:AudioStreamPlayer) -> AudioStreamPlayer:
	var clone : AudioStreamPlayer = AudioStreamPlayer.new()
	clone.stream = stream.stream
	clone.volume_db = stream.volume_db
	clone.autoplay = stream.autoplay
	clone._import_path = stream._import_path
	clone.bus = stream.bus 
	clone.stream_paused = stream.stream_paused
	clone.owner = stream.owner
	clone.custom_multiplayer = stream.custom_multiplayer
	clone.filename = stream.filename
	clone.mix_target = stream.mix_target
	clone.name = stream.name
	clone.pitch_scale = stream.pitch_scale
	return clone
