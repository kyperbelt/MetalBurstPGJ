extends Label


var _selected : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	set_selected(false)
	pass # Replace with function body.


func set_selected(selected : bool):
	_selected = selected;
	set("custom_colors/font_color", Color.crimson if selected else Color.white)
	pass

