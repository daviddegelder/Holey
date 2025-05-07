extends Control

@export var landscape_mode_container: Container
@export var portrait_mode_container: Container
@onready var current_container: Container = landscape_mode_container


func _process(delta):
	var target_container: Container = current_container
	
	if size.x > size.y:
		target_container = landscape_mode_container
	if size.y > size.x:
		target_container = portrait_mode_container
		
	if target_container != current_container:
		for child in current_container.get_children():
			child.reparent(target_container)
			
	current_container = target_container
