extends Node2D

onready var players = $points
onready var hud = $Hud
onready var timer = $Timer

var _turn
var _using_touch = false
var _actvite_position = Vector2()
var _game_over = false

signal end_game(winner)

var points = [
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

func _ready():
	setup_game()
	_turn = State.playing_as

func setup_game():
	if State.playing_as == State.Team.BLUE:
		for child in players.get_children():
			if child.name == 'player' or child.name == 'player2' or child.name == 'player3':
				child.player_type = State.Team.BLUE
				child.setup()
			else:
				child.player_type = State.Team.RED
				child.setup()
	else:
		for child in players.get_children():
			if child.name == 'player' or child.name == 'player2' or child.name == 'player3':
				child.player_type = State.Team.RED
				child.setup()
			else:
				child.player_type = State.Team.BLUE
				child.setup()

func make_move():
	pass

func check_turn(player):
	if _game_over:
		return false
	return player == _turn

func win_check():
	# check for win
	# (120,0)(0,0)(-120,0)
	if points[4]['item'] == points[5]['item'] and points[4]['item'] == points[3]['item'] and points[4]['item'] != 0:
		print('mid horiz win')
		print('game over, ', _turn, ' wins')
		_game_over = true
		timer.start()
	# (0,150)(0,0)(0,-150)
	elif points[4]['item'] == points[7]['item'] and points[4]['item'] == points[1]['item'] and points[4]['item'] != 0:
		print('mid verti win')
		print('game over, ', _turn, ' wins')
		_game_over = true
		timer.start()
	# (-120,-150)(0.0)(120,150)
	elif points[4]['item'] == points[6]['item'] and points[2]['item'] == points[4]['item'] and points[4]['item'] != 0:
		print('diagnol left to right')
		print('game over, ', _turn, ' wins')
		_game_over = true
		timer.start()
	# (-120,150)(0.0)(120,-150)
	elif points[4]['item'] == points[8]['item'] and points[0]['item'] == points[4]['item'] and points[4]['item'] != 0:
		print('diagnol right to left')
		print('game over, ', _turn, ' wins')
		_game_over = true
		timer.start()
	else:
		print("proceed with game")

func change_turn():
	match _turn:
		State.Team.BLUE:
			_turn = State.Team.RED
		State.Team.RED:
			_turn = State.Team.BLUE

func update_board(pnts):
	# board update
	for idx in range(9):
		if points[idx]['position'] == _actvite_position:
			points[idx]['item'] = 0
		if points[idx]['position'] == pnts:
				points[idx]['item'] = _turn + 1
				_using_touch = false
	# call player animation
	for cld in players.get_children():
		if cld.position == _actvite_position:
			cld.play_move(pnts)
	win_check()
	if _game_over:
		return
	change_turn()

func ai_play():
	pass

func highlight_piece(location):
	_using_touch = true
	for child in players.get_children():
		if child.position == location:
			child.scale = Vector2(1.2, 1.2)
			_actvite_position = location
		else:
			child.scale = Vector2(1, 1)

func options_check():
	#print('checking options')
	var tmp = []
	match _actvite_position:
		Vector2(-120, 150):
			# options Vector2(0, 150), Vector2(-120, 0), Vector2(0, 0)
			if points[1]['item'] == 0:
				tmp.append(Vector2(0, 150))
			if points[3]['item'] == 0:
				tmp.append(Vector2(-120, 0))
			if points[4]['item'] == 0:
				tmp.append(Vector2(0, 0))
		Vector2(0, 150):
			# options Vector2(0, 0) (120,150)(-120,150)
			if points[4]['item'] == 0:
				tmp.append(Vector2(0, 0))
			if points[2]['item'] == 0:
				tmp.append(Vector2(120, 150))
			if points[0]['item'] == 0:
				tmp.append(Vector2(-120, 150))
		Vector2(120, 150):
			# options Vector2(0, 150), Vector2(120, 0), Vector2(0, 0)
			if points[5]['item'] == 0:
				tmp.append(Vector2(120, 0))
			if points[1]['item'] == 0:
				tmp.append(Vector2(0, 150))
			if points[4]['item'] == 0:
				tmp.append(Vector2(0, 0))
		Vector2(-120, 0):
			# (-120, 150) (-120, -150) (0,0)
			if points[6]['item'] == 0:
				tmp.append(Vector2(-120, -150))
			if points[0]['item'] == 0:
				tmp.append(Vector2(-120, 150))
			if points[4]['item'] == 0:
				tmp.append(Vector2(0, 0))
		Vector2(0,0):
			# (120,0)(-120,0)(0,150)(0,-150)(120,150)(120,-150)(-120,-150)(-120,150)
			if points[5]['item'] == 0:
				tmp.append(Vector2(120, 0))
			if points[1]['item'] == 0:
				tmp.append(Vector2(0, 150))
			if points[3]['item'] == 0:
				tmp.append(Vector2(-120, 0))
			if points[7]['item'] == 0:
				tmp.append(Vector2(0, -150))
			if points[2]['item'] == 0:
				tmp.append(Vector2(120, 150))
			if points[8]['item'] == 0:
				tmp.append(Vector2(120, -150))
			if points[6]['item'] == 0:
				tmp.append(Vector2(-120, -150))
			if points[0]['item'] == 0:
				tmp.append(Vector2(-120, 150))
		Vector2(120, 0):
			#(120,-150)(120,150)(0,0)
			if points[8]['item'] == 0:
				tmp.append(Vector2(120, -150))
			if points[2]['item'] == 0:
				tmp.append(Vector2(120, 150))
			if points[4]['item'] == 0:
				tmp.append(Vector2(0, 0))
		Vector2(-120, -150):
			# (-120,0) (0,0) (0,-150)
			if points[7]['item'] == 0:
				tmp.append(Vector2(0, -150))
			if points[3]['item'] == 0:
				tmp.append(Vector2(-120, 0))
			if points[4]['item'] == 0:
				tmp.append(Vector2(0, 0))
			pass
		Vector2(0, -150):
			# (120,-150)(0,0)(-120,-150)
			if points[8]['item'] == 0:
				tmp.append(Vector2(120, -150))
			if points[6]['item'] == 0:
				tmp.append(Vector2(-120, -150))
			if points[4]['item'] == 0:
				tmp.append(Vector2(0, 0))
			pass
		Vector2(120, -150):
			# (0,-150)(0,0)(120,0)
			if points[7]['item'] == 0:
				tmp.append(Vector2(0, -150))
			if points[5]['item'] == 0:
				tmp.append(Vector2(120, 0))
			if points[4]['item'] == 0:
				tmp.append(Vector2(0, 0))
	#return list of available options
	#print('options from options check:',tmp)
	return tmp

func _on_player_piece_active(position, player):
	if check_turn(player):
		highlight_piece(position)
		return

func _on_player2_piece_active(position, player):
	if check_turn(player):
		highlight_piece(position)
		return

func _on_player3_piece_active(position, player):
	if check_turn(player):
		highlight_piece(position)
		return

func _on_player4_piece_active(position, player):
	if check_turn(player):
		highlight_piece(position)
		return

func _on_player5_piece_active(position, player):
	if check_turn(player):
		highlight_piece(position)
		return

func _on_player6_piece_active(position, player):
	if check_turn(player):
		highlight_piece(position)
		return

func _on_0_touch_event(at_position):
	if _using_touch:
		# check options
		var _opt = options_check()
		if len(_opt) < 1:
			return
		# check if touch point is in options
		for pnts in _opt:
			if pnts == at_position:
				# if true make move
				update_board(pnts)
			# else do nothing

func _on_1_touch_event(at_position):
	if _using_touch:
		# check options
		var _opt = options_check()
		if len(_opt) < 1:
			return
		# check if touch point is in options
		for pnts in _opt:
			if pnts == at_position:
				# if true make move
				update_board(pnts)
			# else do nothing

func _on_2_touch_event(at_position):
	if _using_touch:
		# check options
		var _opt = options_check()
		if len(_opt) < 1:
			return
		# check if touch point is in options
		for pnts in _opt:
			if pnts == at_position:
				# if true make move
				update_board(pnts)
			# else do nothing

func _on_3_touch_event(at_position):
	if _using_touch:
		# check options
		var _opt = options_check()
		if len(_opt) < 1:
			return
		# check if touch point is in options
		for pnts in _opt:
			if pnts == at_position:
				# if true make move
				update_board(pnts)
			# else do nothing

func _on_4_touch_event(at_position):
	if _using_touch:
		# check options
		var _opt = options_check()
		if len(_opt) < 1:
			return
		# check if touch point is in options
		for pnts in _opt:
			if pnts == at_position:
				# if true make move
				update_board(pnts)
			# else do nothing

func _on_5_touch_event(at_position):
	if _using_touch:
		# check options
		var _opt = options_check()
		if len(_opt) < 1:
			return
		# check if touch point is in options
		for pnts in _opt:
			if pnts == at_position:
				# if true make move
				update_board(pnts)
			# else do nothing

func _on_6_touch_event(at_position):
	if _using_touch:
		# check options
		var _opt = options_check()
		if len(_opt) < 1:
			return
		# check if touch point is in options
		for pnts in _opt:
			if pnts == at_position:
				# if true make move
				update_board(pnts)
			# else do nothing

func _on_7_touch_event(at_position):
	if _using_touch:
		# check options
		var _opt = options_check()
		if len(_opt) < 1:
			return
		# check if touch point is in options
		for pnts in _opt:
			if pnts == at_position:
				# if true make move
				update_board(pnts)
			# else do nothing

func _on_8_touch_event(at_position):
	if _using_touch:
		# check options
		var _opt = options_check()
		if len(_opt) < 1:
			return
		# check if touch point is in options
		for pnts in _opt:
			if pnts == at_position:
				# if true make move
				update_board(pnts)
			# else do nothing

func _on_Hud_next_game():
	var _err = get_tree().reload_current_scene()

func _on_Timer_timeout():
	if _turn == State.Team.BLUE:
		State.increase_tally('Blue')
	else:
		State.increase_tally('Red')
	emit_signal("end_game", _turn)
