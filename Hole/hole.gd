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

@export var neighbours: Dictionary[Direction, Hole]
@export var fill_level: int

var queue_fill: int = 0

func _process(_delta):
	var input_direction: Direction = get_input_direction()
	if input_direction != Direction.Null:
		flow(input_direction)
	render_fill()
	
func flow(direction: Direction):
	if fill_level > 0 and neighbours.has(direction):
		fill_level -= 1
		neighbours.get(direction).fill.call_deferred()

func fill():
	fill_level += 1

func render_fill():
	%Fill.scale = Vector2.ONE * (fill_level * 0.3)

func get_input_direction():
	if Input.is_action_just_released("North"):
		return Direction.North
	if Input.is_action_just_released("NorthEast"):
		return Direction.NorthEast
	if Input.is_action_just_released("East"):
		return Direction.East
	if Input.is_action_just_released("SouthEast"):
		return Direction.SouthEast
	if Input.is_action_just_released("South"):
		return Direction.South
	if Input.is_action_just_released("SouthWest"):
		return Direction.SouthWest
	if Input.is_action_just_released("West"):
		return Direction.West
	if Input.is_action_just_released("NorthWest"):
		return Direction.NorthWest
	#no input:
	return Direction.Null
