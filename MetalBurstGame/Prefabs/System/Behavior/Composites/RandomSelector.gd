tool
extends Selector

class_name RandomSelector

func initiate():
	.initiate()
	get_child_behaviors().shuffle()

