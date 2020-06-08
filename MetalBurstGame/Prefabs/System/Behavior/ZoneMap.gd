#This is the zonemap as shown in the docs written by Kevin
#With some libertiies taken for coding efficiency. 
#The screen is devided into nine zones
# 
# TopLeft    |  Top    | TopRight
# Left       | Center  |  Right
# BottomLeft | Bottom  | BottomRight

class_name ZoneMap

enum ZoneMap{
	TopLeft   , Top    , TopRight,
	Left      , Center , Right,
	BottomLeft, Bottom , BottomRight
}

const Zones = ZoneMap

#Get the center position of the position on the zonemap dending on the viewport
#this will scale once we update the playarea viewport to a higher resolution
static func get_zone_position(zone,container:ViewportContainer)->Vector2:
	var size = container.rect_size
	var width = size.x
	var height = size.y
	var zoneWidth = width / 3
	var zoneHeight = height / 3
	var x = zone % 3
	var y = zone / 3 

	return Vector2(x*zoneWidth+(zoneWidth*.5),y*zoneHeight+(zoneHeight*.5))
