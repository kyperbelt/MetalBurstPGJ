extends Label

class_name MenuOption

var _selected : bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	set_selected(false)
	pass # Replace with function body.


func set_selected(selected : bool):
	_selected = selected;
	set("custom_colors/font_color", Color.white if selected else Color.darkgray)
	set("custom_colors/font_color_shadow", Color.black if selected else Color.black)
	set("custom_constants/shadow_offset_x", 3 if selected else 2)
	set("custom_constants/shadow_offset_y", 3 if selected else 2)
	#set("custom_colors/font_color", Color.green if selected else Color.crimson)
	#set("custom_colors/font_color_shadow", Color.black if selected else Color.black)
	#set("custom_constants/shadow_offset_x", 3 if selected else 1)
	#set("custom_constants/shadow_offset_y", 3 if selected else 1)
	pass

