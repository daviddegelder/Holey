@tool
class_name LevelSelector extends Hole

@export var scene: PackedScene
@export var locked: bool = true
var finished: bool = false

@export var title: String
@export_tool_button("Rename") var rename_action = func(): 
	name = title
	scene.resource_name

var selected: bool = false



func is_selected() -> bool:
	return is_complete()
	
func _process(delta):
	super(delta)
	$Lock.visible = locked
