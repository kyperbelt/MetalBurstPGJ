extends ViewportContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$PlayArea.update_size(rect_size.x,rect_size.y)
	$PlayArea/Engine.pre_process_entities()
	pass # Replace with function body.


