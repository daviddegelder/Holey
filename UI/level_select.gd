extends Node2D

@export var levels: Array[LevelSelector]
@onready var camera: Camera2D = $Camera2D
signal level_selected(level: PackedScene)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for level in levels:
		if level.is_selected():
			camera.position = level.position
			if Input.is_action_just_released("ui_accept"):
				level_selected.emit(level.scene)
				#get_tree().change_scene_to_packed(level.scene)
