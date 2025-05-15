class_name LevelSelector extends Node2D

@export var scene: PackedScene
@onready var hole = $Hole
@onready var animation_player = $AnimationPlayer

var selected: bool = false
	
func is_selected() -> bool:
	return hole.is_complete()
	
func _process(delta):
	if (is_selected() and !selected):
		animation_player.play("Select")
		selected = true
	if (!is_selected() and selected):
		animation_player.play("Deselect")
		selected = false
