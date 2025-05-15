@tool
class_name Puzzle extends CollisionShape2D

@export_tool_button("Update") var update_action = update
@export var holes: Array[Hole]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

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
	print_debug("puzzle complete")
	return true

		
