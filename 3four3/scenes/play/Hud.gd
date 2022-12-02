extends CanvasLayer

onready var leftrect = $VBoxContainer2/HBoxContainer2/CenterContainer/left
onready var rightrect = $VBoxContainer2/HBoxContainer2/CenterContainer2/right
onready var lefttext = $VBoxContainer2/HBoxContainer2/CenterContainer/left/Label
onready var righttext = $VBoxContainer2/HBoxContainer2/CenterContainer2/right/Label
onready var end = $windisp
onready var topbox = $windisp/VBoxContainer/topbox
onready var winner_text = $windisp/VBoxContainer/topbox/VBoxContainer/winnner
onready var red_tally = $windisp/VBoxContainer/MarginContainer/VBoxContainer/redscore/HBoxContainer/redtally
onready var blue_tally = $windisp/VBoxContainer/MarginContainer/VBoxContainer/bluescore/HBoxContainer2/bluetally
onready var score_label = $VBoxContainer2/HBoxContainer2/CenterContainer3/score/scoreLabel

signal next_game()

func _ready():
	end.visible = false
	var _blue = String(State.get_tally('Blue'))
	var _red = String(State.get_tally('Red'))
	if State.playing_as == State.Team.BLUE:
		score_label.text = String(_blue + ' : ' + _red)
	else:
		leftrect.color = Color('#ffff0000')
		lefttext.text = 'Red Team'
		rightrect.color = Color('#ff0075ff')
		righttext.text = 'Blue Team'
		score_label.text = String(_red + ' : ' + _blue)

func _on_back_pressed():
	#print("back")
	var _err = get_tree().change_scene("res://scenes/home/home.tscn")

func _on_settings_pressed():
	pass # Replace with function body.

func _on_quit_pressed():
	var _err = get_tree().change_scene("res://scenes/home/home.tscn")

func _on_continue_pressed():
	end.visible = false
	emit_signal("next_game")

func _on_world_end_game(winner):
	if winner == State.Team.BLUE:
		topbox.color = Color('#ff0075ff')
		winner_text.text = 'Blue Team'
	else:
		topbox.color = Color('#ffff0000')
		winner_text.text = 'Red Team'
	blue_tally.text = String(State.get_tally('Blue'))
	red_tally.text = String(State.get_tally('Red'))
	end.visible = true
