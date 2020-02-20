extends Node


export(int) var play_area_width = 640
export(int) var play_area_height = 540


#player
onready var player = get_node("PlayerLayer/Player");

func _ready():
	set_process(true)
	if(player!=null):
		player.position.y = play_area_height * .95
		player.position.x = play_area_width * .5 
		print("player pos set")
		player.play_area_width = play_area_width;
		player.play_area_height = play_area_height;
	

func _process(delta):
	pass

