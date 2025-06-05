extends Control

enum LayoutMode{
	LANDSCAPE,
	PORTRAIT
}

@export var landscape_layout: Control
@export var portrait_layout: Control

@export var landscape_positions: Dictionary[NodePath,Control]
@export var portrait_positions: Dictionary[NodePath,Control]

@onready var current_layout: Control = landscape_layout

func _process(delta):
	var target_layout: Control = current_layout
	
	if size.x > size.y:
		target_layout = landscape_layout
	if size.y > size.x:
		target_layout = portrait_layout
		
	if target_layout != current_layout:
		switch_to_layout(target_layout)
		current_layout = target_layout
		
	target_layout.visible = true
	
	
func switch_to_layout(layout: Control):
	match layout:
		landscape_layout:
			for item in landscape_positions:
				get_node(item).reparent(landscape_positions[item],false)
		portrait_layout:
			for item in portrait_positions:
				get_node(item).reparent(portrait_positions[item],false)
	current_layout.visible = false
