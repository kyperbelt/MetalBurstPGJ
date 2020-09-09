extends Panel

onready var _cancelButton = $CenterContainer/Container/OptionsContainer/Cancel

#var _originalValues : Dictionary = {}
#for testing purposes
#onready var _fauxAudioManager = preload("res://Prefabs/System/AudioManager.tscn")

func _ready():
	#pause_mode = Node.PAUSE_MODE_PROCESS
	#hide() #commented out for testing
	_cancelButton.connect("pressed",self,"cancel_pressed")
	pass # Replace with function body.

func apply_pressed():
	hide()
	pass

func cancel_pressed():
	hide()
	pass
