extends Control


#player Select code
class_name PlayerSelect

export(Array,PackedScene) var playerTypes 


var _currentSelection : int = 0 
var _current : Player
var _next : Player 
var _prev : Player
var _temp : Player

export(float) var _animationTime = .5
var _animating : bool = false
var _animationElapsed : float = 0

onready var CurrentNode = $Current
onready var PrevNode = $Prev
onready var NextNode = $Next

onready var CharacterName : Label= $Name
onready var CharacterDescription : RichTextLabel= $Description
onready var DamageProg : ProgressBar = $Stats/Damage/Prog
onready var SpeedProg : ProgressBar = $Stats/Mobility/Prog
onready var RangeProg : ProgressBar = $Stats/Range/Prog
onready var DifficultyProg : ProgressBar = $Stats/Ease/Prog

var animationFunc : FuncRef = null

var _selectionMade : bool = false

func _ready():
	Globals._inCharacterSelect = true
	_current = playerTypes[get_selection(_currentSelection)].instance()
	_current.position = CurrentNode.position
	_current.scale = Vector2(2,2)
	_next = playerTypes[get_selection(_currentSelection+1)].instance()
	_next.position = NextNode.position
	_prev = playerTypes[get_selection(_currentSelection-1)].instance()
	_prev.position = PrevNode.position

	add_child(_current)
	add_child(_next)
	add_child(_prev)

	update_current_fields()
	_selectionMade = false

#function to wrap the selection
#in case we exceed the expected amount
func get_selection(selection : int)->int:
	if(selection < 0):
		 return playerTypes.size() - 1
	if(selection >= playerTypes.size()):
		return 0
	return selection

func move_selection_left():
	_currentSelection = get_selection(_currentSelection-1)
	animationFunc=funcref(self,"animate_from_left")
	_animationElapsed = 0
	_animating = true
	pass #animate

func move_selection_right():
	_currentSelection = get_selection(_currentSelection+1)
	animationFunc=funcref(self,"animate_from_right")
	_animationElapsed = 0
	_animating = true
	pass #animate

func make_selection():
	$sfx_menuSelect.play() #ReimJ: copied from Title Screen ; Plays riff ; please link to Audio Manager
	yield(get_tree().create_timer(2.0), "timeout") #ReimJ: copied from Title Screen ; Causes pause before play
	Globals.Player = playerTypes[_currentSelection]
	Globals._inCharacterSelect = false
	#hook into stage
	var _result = get_tree().change_scene_to(Globals._selectedStage)
	_selectionMade = true
	pass

func animate_from_right(time:float):
	_next.position = tween_vector(NextNode.position,CurrentNode.position,time)
	_next.scale = tween_vector(Vector2(1,1),Vector2(2,2),time)
	_current.position = tween_vector(CurrentNode.position,PrevNode.position,time)
	_current.scale = tween_vector(Vector2(2,2),Vector2(1,1),time)
	_prev.scale = tween_vector(Vector2(1,1),Vector2(0,0),time)
	if(_temp == null):
		_temp = playerTypes[get_selection(_currentSelection+1)].instance()
		_temp.position = NextNode.position
		add_child(_temp)
	_temp.scale = tween_vector(Vector2(0,0),Vector2(1,1),time)
	
	if(time >= 1):
		_prev.queue_free()
		_prev = _current
		_current = _next
		_next = _temp
		_animating = false
		_temp = null
		update_current_fields()


func animate_from_left(time:float):
	_prev.position = tween_vector(PrevNode.position,CurrentNode.position,time)
	_prev.scale = tween_vector(Vector2(1,1),Vector2(2,2),time)
	_current.position = tween_vector(CurrentNode.position,NextNode.position,time)
	_current.scale = tween_vector(Vector2(2,2),Vector2(1,1),time)
	_next.scale = tween_vector(Vector2(1,1),Vector2(0,0),time)
	if(_temp == null):
		_temp = playerTypes[get_selection(_currentSelection-1)].instance()
		_temp.position = _prev.position
		add_child(_temp)
	_temp.scale = tween_vector(Vector2(0,0),Vector2(1,1),time)
	
	if(time >= 1):
		_next.queue_free()
		_next = _current
		_current = _prev
		_prev = _temp
		add_child(_prev)
		_animating = false
		_temp = null
		update_current_fields()

func update_current_fields():
	CharacterName.text = _current._name
	CharacterDescription.text = _current._descritpion
	DamageProg.value = _current._damageInfo
	SpeedProg.value = _current._speedInfo
	RangeProg.value = _current._rangeInfo
	DifficultyProg.value = _current._difficultyInfo

func tween_vector(start:Vector2,end:Vector2,time:float)->Vector2:
	return Vector2(start.x +(end.x - start.x) * time,start.y + (end.y - start.y) * time)

func tween_float(start:float,end:float,time:float)->float:
	return start + (end - start) * time

func _process(delta):
	_animationElapsed+=delta

	if(_animating):
		var time = min(_animationElapsed / _animationTime,1)
		animationFunc.call_func(time)
	
	if _selectionMade:
		return
	if(Input.is_action_just_pressed("move_left")):
		if(_animating):
			animationFunc.call_func(1)
		move_selection_left()
	elif( Input.is_action_just_pressed("move_right")):
		if(_animating):
			animationFunc.call_func(1)
		move_selection_right()
	elif Input.is_action_just_pressed("ui_accept"):
		if(_animating):
			animationFunc.call_func(1)
		make_selection()
