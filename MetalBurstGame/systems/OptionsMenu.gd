extends Control

var options = []

var _selection : int = 0 #selection

var MenuOption = preload("res://systems/MenuOption.gd")

signal selection_changed #changed the selection
signal selection_entered #entered the selection

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var children = get_children()

	add_options(2,children)

	update_selection(_selection)

	pass # Replace with function body.


func add_options(depth : int,children : Array):
	for child in children:
		if(child is MenuOption):
			options.append(child)
		elif depth-1 > 0 :
			add_options(depth-1,child.get_children())


func prev_selection():
	update_selection(loop_index(_selection-1))

func next_selection():
	update_selection(loop_index(_selection+1))

func loop_index(index : int) -> int:
	var _index = 0 if index >= options.size() else (options.size() - 1 if index < 0 else index)
	return _index;

func update_selection(selection : int):
	if(_selection!=selection):
		_selection = selection
		emit_signal("selection_changed")

	for i in range(options.size()):
		if(i == selection):
			options[i].set_selected(true)
		else:
			options[i].set_selected(false)
		

func get_selection():
	return _selection

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("ui_accept"):
		emit_signal("selection_entered",_selection)
	if Input.is_action_just_pressed("move_down"):
		next_selection()
	if Input.is_action_just_pressed("move_up"):
		prev_selection()
	pass
