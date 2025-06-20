extends Node2D

func play():
	$AnimationPlayer.play("Grow")

func _on_return_pressed():
	$AnimationPlayer.play("Shrink")
