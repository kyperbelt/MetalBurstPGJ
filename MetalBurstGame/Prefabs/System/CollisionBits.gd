extends Node2D 
#Basic class for programming collision
#using the built  in collision system
#in godot
class_name CollisionBits

var Default = 1
var Background = 2
var Player = 4
var Enemy = 8
var EnemyBullet = 16
var PlayerBullet = 32
var PlayerBomb = 64
var Item = 128

#get the collision mask with the provided collisionBits
# in the form [mask1,mask2,mask3] where masks are positive powers of 2 > 1
static func getMask(params:Array)->int:
    var mask : int = -1
    for i in params:
        if(i>1 && i % 2 != 0):
            print("CollisionBits.getMask:: [%s] is not a valid mask value."%i)
            continue
        else:
            mask|=i
    return mask