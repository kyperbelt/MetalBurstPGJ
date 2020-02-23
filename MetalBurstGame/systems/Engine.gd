extends Node

var play_area_width = 0
var play_area_height = 0


#level
export(NodePath) var Level 

#player
onready var player = get_node("PlayerLayer/Player");

func _ready():
	set_process(true)
	

func _process(delta):
	pass

func pre_process_entities():
	var level_children = get_node(Level).get_children();
	for child in level_children:
		if(child.is_in_group("Enemy")):
			print("added "+child.name+" to entitylayer")
			child.get_parent().remove_child(child)
			$EntityLayer.add_child(child)

func center_player():
	if(player!=null):
		player.position.y = play_area_height * .95
		player.position.x = play_area_width * .5 
		print("player pos set")
		player.play_area_width = play_area_width;
		player.play_area_height = play_area_height;


