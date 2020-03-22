extends Node2D

class MBProjectile extends Sprite:
	var state = 1
	var use_default_image = true
	var pos
	var speed
	var direction
	var parent
	
	func _init(_pos, _speed, _direction):
		self.set_position(_pos)
		self.pos = _pos
		self.speed = _speed
		self.direction = _direction

	func _ready():
		self.parent = get_parent()
		#$PlayerBulletArea.connect("area_entered", self, "hit")
		#var node = get_node("Projectile/PlayerBulletArea")
		#node.connect("area_entered", self, "hit")
		self.set_process(true)

	func _process(delta):
		#print("Projectile func")
		self.move(delta)
		self.removeWenOffScreen()
		#print(global_position)
	
	func move(delta):
		self.global_position += (Vector2(0, -300) * (2 * delta))
		#print("Bullet position: " + String(self.global_position))

	func change_speed(new_speed):
		self.speed = new_speed

	func removeWenOffScreen():
		if self.global_position.y < 0:
		# if self.pos.y < 0:
			queue_free()


		#collision has started with something

#func start(pos):
#	print("Projectile start")
#	position = pos
#	$Collisionshape2D.disabled = false

func _ready():
	# print_tree_pretty()
	var _result = $PlayerBulletArea.connect("area_entered", self, "hit")
	#$Collisionshape2D.disabled = false

func hit(object):
	print("Bullet collision with " + object.name + " etected!")
	if object.name == 'EnemyArea':
		queue_free()

func _on_PlayerBulletArea_area_entered(_area):
	# pass # Replace with function body.
	#var node = get_node("Projectile/PlayerBulletArea")
	##var node = area.get_parent()
	##node.connect("area_entered", self, "hit")
	#print("Bullet collision with "+node.name+" detected!")
	print("Bullet collision with  detected!")
func start(pos):
	print("Bullet position: " + pos)
	position = pos
	$Collisionshape2D.disabled = false
