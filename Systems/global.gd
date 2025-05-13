extends Node

const HOLE_DISTANCE: int = 64

func _ready():
	var current_scene = get_tree().current_scene
	if current_scene is Puzzle:
		current_scene.position = get_viewport().get_visible_rect().get_center()
