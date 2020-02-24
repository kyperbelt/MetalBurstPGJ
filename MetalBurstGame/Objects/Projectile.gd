extends Node2D

class Projectile extends Sprite:
	var state = 1
	var use_default_image = true
	var pos
	var speed
	var direction
	var parent
	
	func _init(pos, speed, direction):
		self.set_position(pos)
		self.pos = pos
		self.speed = speed
		self.direction = direction

	func _ready():
		parent = get_parent()
		set_process(true)

	func _process(delta):
		#pos = get_position()
		print("Projectile func")
		#if pos.x <  -Globals.margin or pos.y < -Globals.margin or pos.x > Globals.screen_size.x + Globals.margin or pos.y > Globals.screen_size.y + Globals.margin:
		#	state = -1
		#if state == -1:
		#	set_process(false)
		#	queue_free()
		#	return
		#elif state == 0:
		#	pass
		# else:
		#self.pos += self.direction *  self.speed * delta
		move(delta)
		# if self.pos.y < 0
		removeWenOffScreen()
		print(global_position)
		#set_position(self.pos)
 
	func move(delta):
		global_position += (Vector2(0, -300) * delta)

	func removeWenOffScreen():
		if global_position.y < 0:
			queue_free()
# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass 




