extends CanvasLayer

onready var leftrect = $VBoxContainer2/HBoxContainer2/CenterContainer/left
onready var rightrect = $VBoxContainer2/HBoxContainer2/CenterContainer2/right
onready var lefttext = $VBoxContainer2/HBoxContainer2/CenterContainer/left/Label
onready var righttext = $VBoxContainer2/HBoxContainer2/CenterContainer2/right/Label

func _ready():
	if State.playing_as == State.Team.BLUE:
		pass
	else:
		leftrect.color = Color('#ffff0000')
		lefttext.text = 'Red Team'
		rightrect.color = Color('#ff0075ff')
		righttext.text = 'Blue Team'

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_back_pressed():
	#print("back")
	var _err = get_tree().change_scene("res://scenes/home/home.tscn")

func _on_settings_pressed():
	pass # Replace with function body.
