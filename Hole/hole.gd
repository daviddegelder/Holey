@tool
class_name Hole
extends Node2D


enum Direction {
	Null,
	North,
	NorthEast,
	East,
	SouthEast,
	South,
	SouthWest,
	West,
	NorthWest,
}
const DIRECTION_VECTORS: Dictionary[Direction, Vector2] = {
	Direction.Null      : Vector2(0,0),
	Direction.North     : Vector2(0,-1),
	Direction.NorthEast : Vector2(1,-1),
	Direction.East      : Vector2(1,0),
	Direction.SouthEast : Vector2(1,1),
	Direction.South     : Vector2(0,1),
	Direction.SouthWest : Vector2(-1,1),
	Direction.West      : Vector2(-1,0),
	Direction.NorthWest : Vector2(-1,-1),
}


@export_tool_button("Detect Neighbours") var detect_neighbours_action = detect_neighbours;
@export var neighbours: Dictionary[Direction, Hole]
@export var fill_level: int
var has_flowed: bool = false

var active = true
var preview_direction: Direction

func _process(_delta):	
	if not Engine.is_editor_hint():
		%Render.fill_level = fill_level
		preview_input(preview_direction)
	else:
		render_editor()
		
func _input(event):
	preview_direction = Direction.Null
	if event is InputEvent8Directional:
		if event.pressed:
			preview_direction = event.direction
		else:
			flow(event.direction)
	
func flow(direction: Direction):
	if fill_level > 0 and has_neighbour(direction):
		fill_level -= 1
		neighbours[direction].fill.call_deferred()
		has_flowed = true
		

func fill():
	fill_level += 1

func get_input_direction():
	if !active: return Direction.Null
	#no input:
	return Direction.Null
	
func preview_input(direction: Direction):
	#temporary preview visualisation
	%Fill.position = DIRECTION_VECTORS[direction] * 10

func has_neighbour(direction: Direction):
	return neighbours[direction] != null

func detect_neighbours():
	for direction in Direction.values():
		neighbours[direction] = detect_neighbour_in_direction(direction)

func detect_neighbour_in_direction(direction: Direction) -> Hole:
	%RayCast2D.target_position = Global.HOLE_DISTANCE * DIRECTION_VECTORS[direction].normalized()
	%RayCast2D.force_raycast_update()
	var collider = %RayCast2D.get_collider()
	if collider == null or !collider.is_in_group("Hole"):
		return null
	return collider.get_parent()

func render_editor():
	%Fill.scale = Vector2.ONE * (fill_level * 0.1)

func is_complete() -> bool:
	return fill_level > 0
