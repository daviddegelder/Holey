@tool
class_name Puzzle extends CollisionShape2D

@export var title: String
@export_tool_button("Update") var update_action = update
@export var holes: Array[Hole]

var moves: int = 0

signal finished

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(_delta):
	if Engine.is_editor_hint(): return
	var input_direction = get_input_direction()
	if input_direction != Hole.Direction.Null && has_moved():
		moves += 1
		play_sfx(input_direction)
	if is_complete():
		$AnimationPlayer.play("Complete")
		for hole in holes: hole.active = false;

func get_holes():
	holes = []
	for child in get_children():
		if child is Hole:
			holes.append(child)

func update():
	holes = []
	for child in get_children():
		if child is Hole:
			holes.append(child)
			child.detect_neighbours()

func is_complete() -> bool:
	for hole in holes:
		if !hole.is_complete():
			return false
	return true

func on_complete_animation_finished():
	finished.emit()
	
func has_moved():
	for hole in holes:
		if hole.has_flowed: 
			hole.has_flowed = false
			return true
	return false

func play_sfx(direction):
	$AudioStreamPlayer.pitch_scale = 0.6 + direction * 0.1
	$AudioStreamPlayer.play()


func get_input_direction():
	if Input.is_action_just_pressed("North"):
		return Hole.Direction.North
	if Input.is_action_just_pressed("NorthEast"):
		return Hole.Direction.NorthEast
	if Input.is_action_just_pressed("East"):
		return Hole.Direction.East
	if Input.is_action_just_pressed("SouthEast"):
		return Hole.Direction.SouthEast
	if Input.is_action_just_pressed("South"):
		return Hole.Direction.South
	if Input.is_action_just_pressed("SouthWest"):
		return Hole.Direction.SouthWest
	if Input.is_action_just_pressed("West"):
		return Hole.Direction.West
	if Input.is_action_just_pressed("NorthWest"):
		return Hole.Direction.NorthWest
	#no input:
	return Hole.Direction.Null
