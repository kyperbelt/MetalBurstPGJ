extends Node

var play_area_width = 0
var play_area_height = 0

var elapsed : float = 0
export(float) var max_duration = 20.0

#level
export(NodePath) var Level
export(NodePath) var PauseScreen


const Background = preload("res://systems/ScrollingBackground.gd")
const Projectile = preload("res://Objects/Projectile.gd")

#player
onready var player = get_node("PlayerLayer/Player");

func _ready():
	set_process(true)
	

func _process(delta):
	elapsed+=delta
	if(Input.is_action_just_pressed(("pause"))):
		get_node(PauseScreen).show()
		get_tree().paused = true
	if(elapsed>=max_duration):
		elapsed=0
		var code = get_tree().change_scene("res://Screens/GameOverScreen.tscn")
		if(code != OK):
			print("failed to change to gameover screen")

#proceess the entities in the level by adding them to engine 
#so that logic works properly
func pre_process_entities():
	var level_children = get_node(Level).get_children();
	for child in level_children:
		var added : bool = false
		if(child.is_in_group("Enemy")):
			print("added "+child.name+" to entitylayer")
			child.get_parent().remove_child(child)
			$EntityLayer.add_child(child)
			added = true
		if(child is Background):
			print("added "+child.name+" to background layer")
			child.get_parent().remove_child(child)
			$BackgroundLayer.add_child(child)
			added = true
		if added : 
			if child.has_method("engine_ready"):
				child.engine_ready(self)

func add_child(node : Node, legible_unique_name: bool = false):
	if(node is Projectile):
		$BulletLayer.add_child(node, legible_unique_name)
	else:
		.add_child(node, legible_unique_name)



func center_player():
	if(player!=null):
		player.position.y = play_area_height * .95
		player.position.x = play_area_width * .5 
		print("player pos set")
		player.play_area_width = play_area_width;
		player.play_area_height = play_area_height;


