extends Control

var _team = 0

func _ready():
	pass

func _on_blue_btn_pressed():
	# select red team
	_team = 2
	State.team_select(State.Team.BLUE)
	#print('on blue team')

func _on_red_btn_pressed():
	# select red team
	_team = 1
	State.team_select(State.Team.RED)
	print('on red team')

func _on_play_pressed():
	# check team selected and move to play screen
	match _team:
		0:
			print('select team')
		1:
			#print('playing as Red Team')
			var _err = get_tree().change_scene("res://scenes/play/play.tscn")

		2:
			#print('playing as Blue Team')
			var _err = get_tree().change_scene("res://scenes/play/play.tscn")

func _process(_delta):
	# effects co-ordinator
	if _team == 0:
		$VBoxContainer/HBoxContainer/red_btn/ColorRect.color = Color('#ffff0000')
		$VBoxContainer/HBoxContainer/blue_btn/ColorRect.color = Color('#ff0075ff')
	elif _team == 1:
		$VBoxContainer/HBoxContainer/blue_btn/ColorRect.color = Color('#ff8080ff')
		$VBoxContainer/HBoxContainer/red_btn/ColorRect.color = Color('#ffff0000')
	else:
		$VBoxContainer/HBoxContainer/red_btn/ColorRect.color = Color('#ffff8080')
		$VBoxContainer/HBoxContainer/blue_btn/ColorRect.color = Color('#ff0075ff')
	pass

func _on_settings_pressed():
	print('to settings')
