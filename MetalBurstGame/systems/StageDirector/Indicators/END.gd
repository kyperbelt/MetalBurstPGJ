tool
extends Sprite

#Declare signals here
signal position_changed

# Declare member variables here
var last_position : Vector2 = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	last_position = Vector2(position)
	pass # Replace with function body.


func _process(delta):
	if(last_position!=position):
		last_position = Vector2(position)
		emit_signal("position_changed")
	pass
