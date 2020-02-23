extends Viewport


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

	
# Called when the node enters the scene tree for the first time.
func _ready():
	print(size)
	pass


func add_child(node : Node,legible_unique_name : bool = false):
	.add_child(node,legible_unique_name)
	if(node.name == "Engine"):
		node.play_area_width = size.x
		node.play_area_height = size.y
		

func update_size(w,h):
	$Engine.play_area_width = w
	$Engine.play_area_height = h
	size.x = w
	size.y = h
	$Engine.center_player()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
