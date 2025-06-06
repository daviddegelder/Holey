@tool
extends Puzzle

@onready var camera: Camera2D = $Camera2D
signal level_selected(level: PackedScene)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func level_completed(completed_scene: PackedScene):
	for level in holes:
		if level is not LevelSelector: return
		if level.scene == completed_scene:
			level.finished = true
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
		if level is not LevelSelector: return
		if level.is_selected():
			camera.position = level.position
			%RichTextLabel.text = level.name
			if Input.is_action_just_released("Select") && !level.locked:
				level_selected.emit(level.scene)


func _on_visibility_changed():
	%CanvasLayer.visible = is_visible_in_tree()
