extends Node2D 
#Basic class for programming collision
#using the built  in collision system
#in godot
class_name CollisionBits

const Default = 1
const Background = 2
const Player = 4
const Enemy = 8
const EnemyBullet = 16
const PlayerBullet = 32
const PlayerBomb = 64
const Item = 128

enum CollisionBitMap{
    Default = 1,
    Background = 2,
    Player = 4,
    Enemy = 8,
    EnemyBullet  = 16,
    PlayerBullet  = 32,
    PlayerBomb  = 64,
    Item = 128,
}

#get the collision mask with the provided collisionBits
# in the form [mask1,mask2,mask3] where masks are positive powers of 2 > 1
static func get_mask(params:Array)->int:
    var mask : int = -1
    for i in params:
        if(i>1 && i % 2 != 0):
            print("CollisionBits.getMask:: [%s] is not a valid mask value.[must be power of 2 greater than 1]."%i)
            continue
        else:
            mask|=i
    return mask
