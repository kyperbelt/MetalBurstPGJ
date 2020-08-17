extends HBoxContainer

class_name ImageRepeater

export(PackedScene) var _icon

var _freeIcons : Array = []
var _usedIcons : Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_amount(amount:int):
	clear_icons()
	for _i in range(0,amount):
		add_image_icons(get_free_icon())

func add_image_icons(icon:TextureRect):
	_usedIcons.append(icon)
	add_child(icon)

func free_image_icon(icon:TextureRect):
	remove_child(icon)
	_freeIcons.append(icon)

func clear_icons():
	for i in _usedIcons:
		free_image_icon(i)
	_usedIcons.clear()

func get_free_icon()-> TextureRect:
	if(_freeIcons.empty()):
		return _icon.instance()
	return _freeIcons.pop_front()
	
