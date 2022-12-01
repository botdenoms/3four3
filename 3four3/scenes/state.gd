extends Node

enum Team {
	RED, BLUE
}

var playing_as = Team.BLUE

func team_select(team):
	playing_as = team

func get_team():
	return playing_as
