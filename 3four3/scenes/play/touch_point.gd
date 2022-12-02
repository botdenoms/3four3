extends Area2D

signal touch_event(at_position)

func _on_0_input_event(_viewport, event, _shape_idx):
	if not event is InputEventScreenTouch:
		return
	else:
		if event.is_pressed():
			#print('touch point clicked')
			emit_signal("touch_event", position)
