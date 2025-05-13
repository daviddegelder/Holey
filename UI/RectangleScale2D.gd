@tool
class_name RectangleScale2D
extends Area2D

@export var container: Control
@export var target: CollisionShape2D
var bounds: RectangleShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	update()
	pass
	
	
func update():
	if target.shape is not RectangleShape2D:
		push_warning("Shape is not a RectangleShape2D")
		return
	
	bounds = target.shape
	var x_scale = container.size.x / bounds.size.x
	var y_scale = container.size.y / bounds.size.y
	scale = Vector2.ONE * min(x_scale, y_scale)
	position = container.size / 2
	target.position = Vector2.ZERO

	
func _get_configuration_warnings():
	if target.shape is not RectangleShape2D:
		return ["Shape must be a RectangleShape2D"]
	return []
