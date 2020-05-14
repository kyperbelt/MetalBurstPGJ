extends Sprite

class_name Projectiles

#This controls PlayerBullets
var speed

const PLAYER_VELOCITY = Vector2(0, -600)
const ENEMY_VELOCITY = Vector2(0, 300)
const PLAYER_BOMB_VELOCITY = Vector2(0, -100)

export(Array,Texture) var PROJECTILE_TYPES = []

export (int, "PLAYER_BULLET", "ENEMY_BULLET") var projectileType setget setProjectileType


func setProjectileType(newProjectileType):
	if newProjectileType != null:
		projectileType = newProjectileType
		texture = PROJECTILE_TYPES[projectileType]

func _ready():
	# print_tree_pretty()
	var _result = $ProjectilesArea.connect("area_entered", self, "hit")
	# $Collisionshape2D.disabled = false

func _process(delta):
	move(delta)
	removeWenOffScreen()
	#print(global_position)
		
func hit(object):
	print("Bullet collision with " + object.name + " detected!")
	if object.name == 'EnemyArea' && projectileType == 0:
		queue_free()
	if object.name == 'PlayerCollisionArea' && projectileType == 1:
		queue_free()
		print("player hit")
		object.get_parent().hit(self)

func move(delta):
	if (projectileType == 0):
		global_position += (PLAYER_VELOCITY * (2 * delta))
	elif (projectileType == 2):
		global_position += (PLAYER_BOMB_VELOCITY * (2 * delta))
	else:
		global_position += (ENEMY_VELOCITY * (2 * delta))
	#print("Bullet position: " + String(self.global_position))

func change_speed(new_speed):
	speed = new_speed

func removeWenOffScreen():
	if global_position.y < 0:
		queue_free()

#func start(pos):
#	position = pos
#	$Collisionshape2D.disabled = false
