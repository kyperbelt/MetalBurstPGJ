tool
extends Node2D

class_name EnemyControl, "res://Assets/Tools/boss.png"

var _engineReady : bool = false#ready to roll baby
var _myEngine = null
var _brain : Brain = null

func _ready():
	if(Engine.is_editor_hint()):
		pass
	else:
		for child in get_children():
			if(child is Brain):
				_brain = child
				break
		pass
	pass # Replace with fun

#called by the engine when it adds it to the correct layer
func engine_ready(engine):
	_engineReady = true
	_myEngine = engine
	_brain.start({
	
	})

func get_engine_ready()->bool:
	return _engineReady

##########################################################
#@@@@@@@@@@@@@@@@@@@@@@@@ EDITOR @@@@@@@@@@@@@@@@@@@@@@@@#
##########################################################

func _get_configuration_warning():
	if(Engine.is_editor_hint()):
		for child in get_children():
			if(child is Brain):
				return ""
		return """This Enemy does not have a Brain - Therefore It will not be able to proccess behaviors.
				Try adding a brain node -> and then add behaviors to that brain"""
	else:
		return ""

func is_class(type):
	return type == get_class()

func get_class():
	return "Enemy"
