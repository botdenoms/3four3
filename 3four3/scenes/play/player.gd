extends Node2D

enum Team {
	RED, BLUE
}

export(Team) var player_type = Team.BLUE
export var to_point = Vector2()
export var accel = 250

onready var red = $red
onready var blue = $blue
signal piece_active(position, player)

func _process(delta):
	#position = position.linear_interpolate(to_point, delta * accel)
	position = position.move_toward(to_point, delta * accel)

func play_move(target_pos):
	# play animation from current pos to target pos
	# print('moving from: ', position, ' to: ', target_pos)
	to_point = target_pos
	scale = Vector2(1, 1)

func setup():
	if player_type == Team.BLUE:
		blue.visible = true
		red.visible = false
	else:
		red.visible = true
		blue.visible = false
		blue.visible = false

func _ready():
	to_point = position

func _on_Area2D_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			#print(event.position) # click position
			#print(position) # object position
			#print('player clicked at position: ', position)
			emit_signal("piece_active", position, player_type)
