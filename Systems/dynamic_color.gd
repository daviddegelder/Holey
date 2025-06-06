extends CanvasItem

@export var color: Global.ColorKey

func _process(_delta):
	modulate = Global.color_palette[color]
