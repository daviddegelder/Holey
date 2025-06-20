extends Node

@export var puzzle_scene: PackedScene
@onready var puzzle_scaler: RectangleScale2D = %RectScale2D
@onready var current_puzzle: Puzzle = %Puzzle

signal puzzle_complete(puzzle: Puzzle, moves: int)

func _ready():
	if puzzle_scene:
		load_puzzle(puzzle_scene)

func load_puzzle(puzzle: PackedScene):
	var new_puzzle: Puzzle = puzzle.instantiate()
	current_puzzle.queue_free()
	puzzle_scaler.add_child(new_puzzle)
	puzzle_scaler.target = new_puzzle
	new_puzzle.finished.connect(on_puzzle_finished)
	current_puzzle = new_puzzle
	puzzle_scene = puzzle
	%LevelTitle.text = current_puzzle.title

func on_puzzle_finished(moves: int):
	puzzle_complete.emit(puzzle_scene, moves)


func _on_reset_pressed():
	load_puzzle(puzzle_scene)


func _on_back_pressed():
	puzzle_complete.emit(null,0)
