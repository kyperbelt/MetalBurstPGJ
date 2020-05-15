extends Node

#SIGNALS
signal player_died

#EXPORT
export(NodePath) var Level
export(NodePath) var PauseScreen

#ONREADY
onready var position : Vector2 = Vector2(0,0)

#VARS
var player = null
var informationDisplay : InformationDisplay = null
var play_area_width = 0
var play_area_height = 0


func _ready():
	player = Globals.get_player()
	player.connect("player_hit",self,"player_hit")
	$PlayerLayer.add_child(player)
	set_process(true)

func set_info_display(info_display):
	informationDisplay = info_display
	informationDisplay.set_lives(player.lives)
	informationDisplay.set_score(player.score)
	informationDisplay.set_bombs(floor(player.bomb_percentage / player.bomb_cost))

func _process(delta):
	if(Input.is_action_just_pressed(("pause"))):
		get_node(PauseScreen).show()
		get_tree().paused = true

func cleanup():
	#remove player so that it doesnt get freed
	if(player.get_parent()!=null):
		player.get_parent().remove_child(player) #=================?????

#proceess the entities in the level by adding them to engine
#so that logic works properly
func pre_process_entities():
	var level_children = get_node(Level).get_children();
	for child in level_children:
		var added : bool = false
		if(child.is_in_group("Enemy")):
			print("please use SceneDirector SPawnEvents to add to Entities to Stage [failed to add "+child.name+" to entitylayer]")
			child.get_parent().remove_child(child)
			$EntityLayer.add_child(child)
			added = true
		if(child is ScrollingBackground):
			print("added "+child.name+" to background layer")
			child.get_parent().remove_child(child)
			$BackgroundLayer.add_child(child)
			added = true
		if added :
			if child.has_method("engine_ready"):
				child.engine_ready(self)

func add_child(node : Node, legible_unique_name: bool = false):
	if(node is Projectiles):
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


func player_hit():
	if(player.lives <= 0):
		get_tree().change_scene("res://Prefabs/Screens/GameOverScreen.tscn")
		cleanup()
		emit_signal("player_died")
		player.lives = 4 #This resets players life to 4 ; Bandaid ; Mod "Player.gd"
	else:
		informationDisplay.set_lives(player.lives,false)
	pass
