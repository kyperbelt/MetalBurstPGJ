extends Control

class_name InformationDisplay

# Called when the node enters the scene tree for the first time.
func _ready():
	#placeholder signal connection :::
	# we want to connect the singals from individual components 
	# later, like the bomb energy progress bar - boss hp ect
	var _ok = 	connect("lives_changed",self,"update_lives")
	_ok = 		connect("score_changed",self,"update_score")
	_ok =	 	connect("bombs_changed",self,"update_bombs")
	_ok = 		connect("multiplier_changed",self,"update_multiplier")
	pass 

signal lives_changed
signal score_changed
signal bombs_changed
signal stage_name_changed
signal multiplier_changed

func set_lives(lives:int,increment=true):
	emit_signal("lives_changed",lives,increment)
	print("lives set "+str(lives))
	pass

func set_score(score:int,increment=true):
	emit_signal("score_changed",score,increment)
	pass

func set_bombs(bombs:int,increment=true):
	emit_signal("bombs_changed",bombs,increment)
	pass

func set_stage_name(name:String):
	emit_signal("stage_name_changed",name)
	pass

func set_multiplier(mult:int):
	emit_signal("multiplier_changed",mult)


##################################
# for now since we are using the labels as placeholder
# we we will attach the signals to methods in here.
# Later we will switch to progress bars and having 
# individual scripts for each component that react to 
# the signals.
##################################

func update_lives(lives,_increment):
	($VerticalStack/LivesContainer as ImageRepeater).set_amount(lives)
	# $VerticalStack/Lives.set_text(str(lives) if lives <= 0 else Globals.repeat_string("[^]",lives))

func update_score(score,_increment):
	$VerticalStack/Score.set_text("%010d" % score)
	#going to get a bit hacky here
	update_progressBar()

func update_bombs(bombs,_increment):		
	# $VerticalStack/Bombs.set_text(Globals.repeat_string("O ",bombs))
	($VerticalStack/BombsContainer as ImageRepeater).set_amount(bombs)

func update_name(name):
	$StageName.set_text(name)

func update_multiplier(mult:int):
	update_progressBar()
	$MultiplierContainer/Multiplier.set_text("X %s"%mult);

func update_progressBar():
	var player = Globals.get_player();
	var _currentAccumValue = player._scoreAccumValue;
	var _currentMultiplierScoreValue = player.get_score_from_mult(player._scoreMultiplier)
	var _nextMultiplierScoreValue = player.get_score_from_mult(player._scoreMultiplier+1)
	var _amountRequired = _nextMultiplierScoreValue - _currentMultiplierScoreValue
	var _amountAchieved = _currentAccumValue - _currentMultiplierScoreValue
	var delta = _amountAchieved/_amountRequired
	$MultiplierProgressBar.value = delta*100;
