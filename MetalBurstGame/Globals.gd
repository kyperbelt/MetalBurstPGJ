extends Node2D

#This file contains important global information and functions
#that can be accessed from anywhere in the program at any given 
#time by calling Globals.something. 

const DEBUGMODE: bool = true

var screen_size
var margin = 80
#var player_bullet_image
var Player: PackedScene = preload("res://Prefabs/Player/Player.tscn") ##DEFAULT PLAEYER === CHANGED THROUGH PLAYER SELECT
const DefaultProjectile: PackedScene = preload("res://Prefabs/Projectiles/Variants/EnemyTestProjectile.tscn")

var _player = null
var random: RandomNumberGenerator = RandomNumberGenerator.new()
var audioManager: AudioManager = null
var _currentEngine = null

var _inCharacterSelect : bool = false
var _selectedStage : PackedScene = preload("res://Prefabs/Stages/AiTest.tscn")

# A dictionary holding highssores in {"stageName":Score} format
var _highScores : Dictionary = {}


# Called when the node enters the scene tree for the first time.
func _enter_tree():
	screen_size = OS.get_screen_size(0)
	var window_size = OS.get_window_size()
	OS.set_window_position(screen_size * 0.5 - window_size * 0.5)
	#player_bullet_image = preload("res://Assets/Projectiles/bullet.png")

func get_engine():
	return _currentEngine

func get_player():
	if _player == null:
		_player = Player.instance()
		print("new player created")
	return _player


func delete_player():
	print("player deleted")
	_player = null

func get_high_score(stageName:String)->int:
	return _highScores[stageName] if (stageName in _highScores) else (set_get(_highScores,stageName,0))

func set_high_score(stageName:String,highScore:int):
	_highScores[stageName] = highScore

func save_scores():
	var save = File.new()
	save.open("metal_burst_save.game",File.WRITE)
	save.store_line(to_json(_highScores))
	save.close()

func load_scores():
	var save = File.new()
	if !save.file_exists("metal_burst_save.game"):
		return
	save.open("metal_burst_save.game")
	_highScores = parse_json(save.get_line())
	save.close()


##STRING UTILS
func repeat_string(s: String, times: int) -> String:
	var s2 = ""
	for _i in range(times):
		s2 += s
	return s2

func reverseString(s:String)->String:
	var length = len(s)
	
	var chars:String = "";
	for i in range(length-1,-1,-1):
		# print("length=%s char=%s index=%s" % [length,s[i],i])
		chars+=s[i];
	return chars


func set_get(map:Dictionary,key,value):
	map[key]=value
	return value

##MATHS
#log with base
func logB(value,base)->float:
	return log(value)/log(base)
