extends Node

@onready var puzzle_ui_layer: CanvasLayer = $Puzzle
@onready var level_select_layer: CanvasLayer = $LevelSelect

@onready var puzzle_ui: Control = $Puzzle/PuzzleUI

var active_layer: CanvasLayer = level_select_layer

func _ready():
	deactivate_layer(puzzle_ui_layer)
	activate_layer(level_select_layer)
	
func activate_layer(layer: CanvasLayer):
	if active_layer:
		deactivate_layer(active_layer)
	layer.show()
	layer.process_mode = Node.PROCESS_MODE_INHERIT
	active_layer = layer
	
func deactivate_layer(layer: CanvasLayer):
	layer.hide()
	layer.process_mode = Node.PROCESS_MODE_DISABLED
	
func _on_puzzle_ui_puzzle_complete(puzzle):
	activate_layer(level_select_layer)


func _on_level_select_level_selected(level):
	puzzle_ui.load_puzzle(level)
	activate_layer(puzzle_ui_layer)
