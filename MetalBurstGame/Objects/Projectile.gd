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
		move(delta)

		removeWenOffScreen()
		print(global_position)
	
	func move(delta):
		global_position += (Vector2(0, -300) * delta)

	func removeWenOffScreen():
		if global_position.y < 0:
			queue_free()





