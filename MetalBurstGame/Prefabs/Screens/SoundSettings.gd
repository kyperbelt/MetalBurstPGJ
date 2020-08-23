extends Panel

const TESTING : bool = false

onready var _masterVolumeSlider = $Container/SoundVerticals/Scrolls/MasterScroll#master
onready var _musicVolumeSlider = $Container/SoundVerticals/Scrolls/MusicScroll	#music
onready var _soundVolumeSlider = $Container/SoundVerticals/Scrolls/SFXScroll	#sfx

onready var _masterPercentage = $Container/SoundVerticals/Percentages/MasterPercent #master
onready var _musicPercentage = $Container/SoundVerticals/Percentages/MusicPercent  #music
onready var _soundPercentage = $Container/SoundVerticals/Percentages/SoundPercent  #sfx

onready var _applyButton = $Container/OptionsContainer/Apply
onready var _cancelButton = $Container/OptionsContainer/Cancel


var _originalValues : Dictionary = {}
#for testing purposes
onready var _fauxAudioManager = preload("res://Prefabs/System/AudioManager.tscn")
var _audioManager : AudioManager

func _ready():
	#starts hidden - must call show()
	pause_mode = Node.PAUSE_MODE_PROCESS
	if TESTING :
		_audioManager = _fauxAudioManager.instance()
		add_child(_audioManager)
	else:
		hide() #commented out for testing
		_audioManager = Globals.audioManager

	_applyButton.connect("pressed",self,"apply_pressed")
	_cancelButton.connect("pressed",self,"cancel_pressed")

	_masterVolumeSlider.connect("value_changed",self,"volume_changed",["Master"])
	_musicVolumeSlider.connect("value_changed",self,"volume_changed",["Music"])
	_soundVolumeSlider.connect("value_changed",self,"volume_changed",["Sound FX"])
	
	_originalValues["Master"] = _audioManager.get_name_volume("Master")
	_originalValues["Music"] = _audioManager.get_name_volume("Music")
	_originalValues["Sound FX"] = _audioManager.get_name_volume("Sound FX")

	_masterVolumeSlider.value = volume_db_to_percentage(_originalValues["Master"]) * 100
	_musicVolumeSlider.value = volume_db_to_percentage(_originalValues["Music"]) * 100
	_soundVolumeSlider.value = volume_db_to_percentage(_originalValues["Sound FX"]) * 100

	pass # Replace with function body.


func apply_pressed():
	print("sound changes applied")
	hide()
	pass

func cancel_pressed():
	print("cancelled applying sound changes")
	_audioManager.set_name_volume("Master",_originalValues["Master"])
	_audioManager.set_name_volume("Music", _originalValues["Music"])
	_audioManager.set_name_volume("Sound FX",_originalValues["Sound FX"])
	hide()
	pass

func volume_changed(value:float,bus:String):
	print("%s volume changed to %s" % [bus,value])
	_audioManager.set_name_volume(bus,volume_percentage_to_db(value/100.0))
	match bus:
		"Master":
			_masterPercentage.text = "%3d%%" % [int(value)]
		"Music":
			_musicPercentage.text = "%3d%%" % [int(value)]
		"Sound FX":
			_soundPercentage.text = "%3d%%" % [int(value)]

func volume_percentage_to_db(percentage)->float:
	return AudioManager.MIN_DB + (AudioManager.MAX_DB - AudioManager.MIN_DB) * percentage if percentage > 0 else -80

func volume_db_to_percentage(db:float)->float:
	return ((db-AudioManager.MIN_DB)/(AudioManager.MAX_DB-AudioManager.MIN_DB)) if db > AudioManager.MIN_DB else 0
