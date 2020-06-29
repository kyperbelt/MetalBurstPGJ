extends Sprite

class_name BulletTest
#This controls FoeBullets

const PLAYER_VELOCITY = Vector2(0, -300)
const ENEMY_VELOCITY = Vector2(0, 200)

export(Array,Texture) var PROJECTILE_TYPES = []
export (int, "PLAYER_BULLET", "ENEMY_BULLET") var projectileType setget setProjectileType

var _velocity : Vector2 = ENEMY_VELOCITY
var _speed : float = 200

func setProjectileType(newProjectileType):
	if newProjectileType != null:
		projectileType = newProjectileType
		texture = PROJECTILE_TYPES[projectileType]

func _ready():
	# print_tree_pretty()
	$BulletTestArea.connect("area_entered", self, "hit")
	# $Collisionshape2D.disabled = false

func _process(delta):
	move(delta)
	removeWenOffScreen()
		
func hit(object):
	print("Bullet collision with " + object.name + " detected!")
	object.get_parent().hit(self)
	queue_free()

func _on_PlayerBulletArea_area_entered(area):
	print("Bullet collision with  detected!")

func move(delta):
	if (projectileType == 0):
		global_position += (PLAYER_VELOCITY * (2 * delta))
	else:
		position += (_velocity * (_speed*delta))
	#print("Bullet position: " + String(self.global_position))

func set_speed(newSpeed):
	_speed = newSpeed

func removeWenOffScreen():
	if global_position.y < 0:
		queue_free()

func set_velocity(x:float,y:float):
	_velocity.x = x
	_velocity.y = y

#func start(pos):
#	position = pos
#	$Collisionshape2D.disabled = false
