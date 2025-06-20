@tool
extends Puzzle

#@onready var camera: Camera2D = $Camera2D
signal level_selected(level: PackedScene)
signal all_completed(position: Vector2)

var all_levels_completed: bool = false
var selected_level

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func level_completed(completed_scene: PackedScene, level_moves: int):
	for level in holes:
		if level.scene == completed_scene:
			level.finished = true
			level.moves = min(level_moves, level.moves)
			print_debug("finished " + level.name)
			for neighbour in level.neighbours.values():
				if neighbour is LevelSelector:
					neighbour.locked = false
					print_debug("unlocked " + neighbour.name)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	super(_delta)
	if Engine.is_editor_hint(): return

	for level in holes:
		if level.is_selected():
			#camera.position = level.position
			%RichTextLabel.text = level.name
			if level.finished:
				%MoveLabel.text = "Completed in %s moves" % level.moves
			else:
				%MoveLabel.text = ""
			selected_level = level
			if Input.is_action_just_released("Select") && !level.locked:
				level_selected.emit(level.scene)
				
	if !all_levels_completed:
		check_all_levels_completed()


func _on_visibility_changed():
	%CanvasLayer.visible = is_visible_in_tree()


func _on_puzzle_ui_puzzle_complete(puzzle, level_moves):
	level_completed(puzzle, level_moves)
	
func check_all_levels_completed():
	for level in holes:
		if !level.finished: return false
		
	all_levels_completed = true
	all_completed.emit(selected_level.global_position)
	return true
	
