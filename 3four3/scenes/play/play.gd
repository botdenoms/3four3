extends Node2D

onready var points = $points
onready var hud = $Hud

func _ready():
	setup_game()

func setup_game():
	if State.playing_as == State.Team.BLUE:
		for child in points.get_children():
			if child.name == 'player' or child.name == 'player2' or child.name == 'player3':
				child.player_type = State.Team.BLUE
				child.setup()
			else:
				child.player_type = State.Team.RED
				child.setup()
	else:
		for child in points.get_children():
			if child.name == 'player' or child.name == 'player2' or child.name == 'player3':
				child.player_type = State.Team.RED
				child.setup()
			else:
				child.player_type = State.Team.BLUE
				child.setup()
