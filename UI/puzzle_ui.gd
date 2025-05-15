extends Node

@export var puzzle: PackedScene
@onready var puzzle_scaler: RectangleScale2D = $Control/HBoxContainer/PuzzleContainer/RectScale2D
@onready var current_puzzle: Puzzle = $Control/HBoxContainer/PuzzleContainer/RectScale2D/Puzzle

signal puzzle_complete(puzzle: Puzzle)

func _ready():
	load_puzzle(puzzle.instantiate())

func load_puzzle(new_puzzle: Puzzle):
	current_puzzle.queue_free()
	puzzle_scaler.add_child(new_puzzle)
	puzzle_scaler.target = new_puzzle
	current_puzzle = new_puzzle

func _process(_delta):
	if current_puzzle.is_complete():
		puzzle_complete.emit(current_puzzle)
