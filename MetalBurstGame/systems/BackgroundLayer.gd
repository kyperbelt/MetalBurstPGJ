extends Sprite


#the multiplier of this background
export(float,0.0,1.0) var multiplier = 1.0

var grid = []

var current_pos : Vector2 = Vector2(0,0)
var original_size : Vector2 = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	
	current_pos = Vector2(position)
	original_size = Vector2(get_rect().size)

	for col in range(0,3):
		grid.append([])
		for row in range(0,3):
			grid[col].append(Sprite.new())
			grid[col][row].centered = false
			grid[col][row].name = "background@"+str(col)+":"+str(row)
			grid[col][row].set_texture(get_texture())
			grid[col][row].get_rect().position = get_rect().position
			grid[col][row].get_rect().size = get_rect().size
			grid[col][row].position.x = (position.x - get_rect().size.x)+(get_rect().size.x * col)
			grid[col][row].position.y = (position.y - get_rect().size.y)+(get_rect().size.y * row)
			add_child(grid[col][row])

			print(str(get_rect().size) + "<-size pos-> "+str(grid[col][row].position))

	set_texture(null)

	pass 
	

func _process(delta):
	pass

func scroll(hscroll : float,vscroll : float):
	current_pos+=Vector2(hscroll*multiplier,vscroll*multiplier)
	
	for col in range(grid.size()):
		for row in range(grid[col].size()):
			grid[row][col].translate(Vector2(hscroll*multiplier,vscroll*multiplier))
	
	var change_x = false
	var change_y = false
	if current_pos.x + original_size.x < position.x || current_pos.x > position.x + original_size.x :
		current_pos.x = position.x
		change_x = true
	if current_pos.y + original_size.y < position.y || current_pos.y > position.y + original_size.y : 
		current_pos.y = position.y
		change_y = true
		print("reset y")
		
	
	for col in range(grid.size()):
		for row in range(grid[col].size()):
				if(change_x):
					grid[col][row].position.x = (position.x - original_size.x)+(original_size.x * col)
				if(change_y):
					grid[col][row].position.y = (position.y - original_size.y)+(original_size.y * row)
	
	pass

