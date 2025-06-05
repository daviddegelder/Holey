@tool
class_name Puzzle extends CollisionShape2D

@export var title: String
@export_tool_button("Update") var update_action = update
@export var holes: Array[Hole]

signal finished

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(_delta):
	if Engine.is_editor_hint(): return
	if is_complete():
		$AnimationPlayer.play("Complete")

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


func _on_editor_state_changed():
	update()
