extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed

func _ready():
	# print_tree_pretty()
	$BulletTestArea.connect("area_entered", self, "hit")
	# $Collisionshape2D.disabled = false

func _process(delta):
	move(delta)
	removeWenOffScreen()
	#print(global_position)
		
func hit(object):
	print("Bullet collision with " + object.name + " detected!")
	if object.name == 'EnemyArea':
		queue_free()

func _on_PlayerBulletArea_area_entered(area):
	print("Bullet collision with  detected!")

func move(delta):
	global_position += (Vector2(0, -300) * (2 * delta))
	#print("Bullet position: " + String(self.global_position))

func change_speed(new_speed):
	speed = new_speed

func removeWenOffScreen():
	if global_position.y < 0:
		queue_free()

#func start(pos):
#	position = pos
#	$Collisionshape2D.disabled = false
