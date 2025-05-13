extends Node

var dragging: bool
var start_position: Vector2
var drag_vector :Vector2
var direction: Hole.Direction

func _input(event):
	if event is InputEventMouseButton:
		#Just pressed
		if !dragging:
			start_position = event.position
			
		dragging = event.pressed
		
		#Released
		if !dragging:
			var direction_name = Hole.Direction.keys()[vector_to_direction(drag_vector)]
			print(direction_name)
			Input.action_press(direction_name)
			Input.action_release(direction_name)
	
	if event is InputEventMouseMotion and dragging:
		drag_vector = event.position - start_position

func vector_to_direction(vector: Vector2) -> Hole.Direction:
	vector = vector.normalized().snapped(Vector2.ONE)
	return Hole.DIRECTION_VECTORS.find_key(vector)
