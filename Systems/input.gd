extends Node

var dragging: bool
var start_position: Vector2
var drag_vector: Vector2
var preview_vector: Vector2

var direction: Hole.Direction

var deadzone: float = 5

func _unhandled_input(event):
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
			
			direction = vector_to_direction(drag_vector)
			var direction_name = Hole.Direction.keys()[direction]
			print(direction_name)
			Input.action_press(direction_name)
			Input.action_release(direction_name)
			drag_vector = Vector2.ZERO
	
	if event is InputEventMouseMotion and dragging:
		drag_vector = event.position - start_position
		preview_vector = drag_vector.normalized()

func vector_to_direction(vector: Vector2) -> Hole.Direction:
	vector = vector.normalized().snapped(Vector2.ONE)
	return Hole.DIRECTION_VECTORS.find_key(vector)
