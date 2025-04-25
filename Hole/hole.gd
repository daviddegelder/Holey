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

func _process(_delta):
	if not Engine.is_editor_hint():
		var input_direction: Direction = get_input_direction()
		if input_direction != Direction.Null:
			flow(input_direction)
		%Render.fill_level = fill_level
	else:
		render_editor()
	
func flow(direction: Direction):
	if fill_level > 0 and has_neighbour(direction):
		fill_level -= 1
		neighbours[direction].fill.call_deferred()

func fill():
	fill_level += 1

func get_input_direction():
	if Input.is_action_just_pressed("North"):
		return Direction.North
	if Input.is_action_just_pressed("NorthEast"):
		return Direction.NorthEast
	if Input.is_action_just_pressed("East"):
		return Direction.East
	if Input.is_action_just_pressed("SouthEast"):
		return Direction.SouthEast
	if Input.is_action_just_pressed("South"):
		return Direction.South
	if Input.is_action_just_pressed("SouthWest"):
		return Direction.SouthWest
	if Input.is_action_just_pressed("West"):
		return Direction.West
	if Input.is_action_just_pressed("NorthWest"):
		return Direction.NorthWest
	#no input:
	return Direction.Null

func has_neighbour(direction: Direction):
	return neighbours[direction] != null

func detect_neighbours():
	for direction in Direction.values():
		neighbours[direction] = detect_neighbour_in_direction(direction)

func detect_neighbour_in_direction(direction: Direction) -> Hole:
	%RayCast2D.target_position = Global.HOLE_DISTANCE * DIRECTION_VECTORS[direction]
	%RayCast2D.force_raycast_update()
	var collider = %RayCast2D.get_collider()
	if collider == null or !collider.is_in_group("Hole"):
		return null
	return collider.get_parent()

func render_editor():
	%Fill.scale = Vector2.ONE * (fill_level * 0.1)

func is_complete() -> bool:
	return fill_level > 0
