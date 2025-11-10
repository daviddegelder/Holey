extends Node

var dragging: bool
var start_position: Vector2
var drag_vector: Vector2
var preview_vector: Vector2

var direction: Hole.Direction

var deadzone: float = 5

func _unhandled_input(event):
	if event is InputEventKey:
		for key in Hole.Direction.keys():
			if !InputMap.has_action(key): continue
			if event.is_action(key): 
				direction = Hole.Direction.get(key)
				send_directional_input(direction, event.pressed)
	
	if event is InputEventMouseButton:
		#Just pressed
		if !dragging:
			start_position = event.position
			
		dragging = event.pressed
		
		#Released
		if !dragging && event.pressed == false:
			if drag_vector.length() < deadzone:
				Input.action_press("Select")
				Input.action_release("Select")
				return
			
			send_directional_input(direction,false)
			drag_vector = Vector2.ZERO
	
	if event is InputEventMouseMotion and dragging:
		drag_vector = event.position - start_position
		if drag_vector.length() > deadzone:
			direction = vector_to_direction(drag_vector)
			send_directional_input(direction,true)
		else:
			direction = Hole.Direction.Null
		
func send_directional_input(direction: Hole.Direction, pressed: bool):
	var event = InputEvent8Directional.new()
	event.direction = direction
	event.pressed = pressed
	
	Input.parse_input_event(event)

func vector_to_direction(vector: Vector2) -> Hole.Direction:
	vector = vector.normalized().snapped(Vector2.ONE)
	return Hole.DIRECTION_VECTORS.find_key(vector)
