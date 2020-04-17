extends Node2D

#A scrolling background that scrolls indefinitely in the direction
#that is specified at the speed specified

#speed of vertical scrolling - invert speed to invert direction
export(float) var vertical_velocity = 100
#speed of horizontal scrolling - invert speed to invert direction
export(float) var horizontal_velocity = 0

const BackgroundLayer = preload("res://Prefabs_Backgrounds/BackgroundLayer.gd")

#will contain a list of layers
var layers = []

# Called when the node enters the scene tree for the first time.
func _ready():
	#populate the layers with layers found inside named LAYER
	
	for child in get_children():
		if(child is BackgroundLayer):
			layers.append(child)			
	


func _process(delta):
	for layer in layers:
		layer.scroll(horizontal_velocity*delta,vertical_velocity*delta)


