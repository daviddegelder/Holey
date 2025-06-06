extends Node

const HOLE_DISTANCE: int = 64

enum ColorKey{
	MAIN,
	SUBTLE,
	HOLE,
	BACKGROUND
}

var color_palette: Dictionary[ColorKey,Color] = {
	ColorKey.MAIN: Color("ffbe33"),
	ColorKey.SUBTLE: Color("ffeccb"),
	ColorKey.HOLE: Color("ffffff"),
	ColorKey.BACKGROUND: Color(0.933, 0.933, 0.933, 1.0)
}


func _ready():
	var current_scene = get_tree().current_scene
	if current_scene is Puzzle:
		current_scene.position = get_viewport().get_visible_rect().get_center()
