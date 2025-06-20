extends Node2D
signal return_pressed

func play():
	$AnimationPlayer.play("Grow")

func _on_return_pressed():
	$AnimationPlayer.play("Shrink")
	return_pressed.emit()
