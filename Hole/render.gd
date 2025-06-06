extends Node

@export_range(0,1,0.05) var lerp_weight: float
@export_category("Fill")
@export var min_scale: float
@export var max_scale: float
@export var fill_steps: int
@export_category("Background")
@export var bg_default_color: Color
@export var bg_complete_color: Color

var fill_level: int
var bg_target_color: Color
var fill_target_scale

func _ready():
	bg_default_color = Global.color_palette[Global.ColorKey.HOLE]
	bg_complete_color = Global.color_palette[Global.ColorKey.SUBTLE]
	
	bg_target_color = bg_default_color
	%Background.modulate = bg_default_color
	
func _process(delta):
	bg_target_color = bg_complete_color if fill_level > 0 else bg_default_color
	%Background.modulate = lerp(%Background.modulate, bg_target_color, lerp_weight)
	
	fill_target_scale = remap(fill_level, 1, fill_steps, min_scale, max_scale)
	if fill_level == 0: fill_target_scale = 0
	%Fill.scale = lerp(%Fill.scale, Vector2.ONE * fill_target_scale, lerp_weight)
