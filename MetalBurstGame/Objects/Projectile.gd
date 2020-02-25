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
		self.parent = get_parent()
		self.set_process(true)

	func _process(delta):
		#print("Projectile func")
		self.move(delta)
		self.removeWenOffScreen()
		#print(global_position)
	
	func move(delta):
		self.global_position += (Vector2(0, -300) * (2 * delta))
		#self.pos += (Vector2(0, -300) * (2 * delta))
		#self.set_position(self.pos)

	func change_speed(new_speed):
		self.speed = new_speed

	func removeWenOffScreen():
		if self.global_position.y < 0:
		# if self.pos.y < 0:
			queue_free()





