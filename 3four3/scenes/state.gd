extends Node

enum Team {
	RED, BLUE
}

var starter_points = [
	{ 'position': Vector2(-120, 150), 'item': 2 },  #0
	{ 'position': Vector2(0, 150), 'item': 2 }, #1
	{ 'position': Vector2(120, 150), 'item': 2 }, #2
	{ 'position': Vector2(-120, 0), 'item': 0 }, #3
	{ 'position': Vector2(0, 0), 'item': 0 }, #4
	{ 'position': Vector2(120, 0), 'item': 0 }, #5
	{ 'position': Vector2(-120, -150), 'item': 1 }, #6
	{ 'position': Vector2(0, -150), 'item': 1 }, #7
	{ 'position': Vector2(120, -150), 'item': 1 }, #8
]

var playing_as = Team.BLUE
var tally = {
	'Blue': 0,
	'Red' : 0
} 

func team_select(team):
	playing_as = team

func get_team():
	return playing_as

func increase_tally(team):
	tally[team] += 1

func get_tally(team):
	return tally[team]
 
