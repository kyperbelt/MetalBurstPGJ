extends Panel

onready var _applyButton = $Container/OptionsContainer/Apply
onready var _cancelButton = $Container/OptionsContainer/Cancel

#var _originalValues : Dictionary = {}
#for testing purposes
#onready var _fauxAudioManager = preload("res://Prefabs/System/AudioManager.tscn")

func _ready():
	#pause_mode = Node.PAUSE_MODE_PROCESS
	#hide() #commented out for testing

	_applyButton.connect("pressed",self,"apply_pressed")
	_cancelButton.connect("pressed",self,"cancel_pressed")
	pass # Replace with function body.


func apply_pressed():
	hide()
	pass

func cancel_pressed():
	hide()
	pass
