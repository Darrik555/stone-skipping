extends Node

signal score_updated(new_score: int)
signal skip_count_udated(new_skip_count: int)
signal multiplier_changed(new_multiplier: float)

var current_score: int = 0
var skip_count: int = 0
var score_multiplier: float = 1.0
var base_points_per_skip: int = 100

func _ready() -> void:
	pass

func register_skip(throwable_controller: CharacterBody3D) -> void:
	if throwable_controller.is_sunk:
		return
	
	skip_count += 1
	
	var points_gained = int(base_points_per_skip * score_multiplier)
	current_score += points_gained
	
	print("skip %s | gained %s | total %s" % [skip_count, points_gained, current_score])
	
	score_updated.emit(current_score)
	skip_count_udated.emit(skip_count)

func add_score_multiplier(factor: float) -> void:
	if factor > score_multiplier:
		score_multiplier = factor
	
	multiplier_changed.emit(score_multiplier)
	
	#mult timer maybe?
	

func _reset_multiplier():
	score_multiplier = 1.0
	multiplier_changed.emit(score_multiplier)

func reset_score():
	current_score = 0
	skip_count = 0
	score_multiplier = 1.0
	skip_count_udated.emit(skip_count)
	score_updated.emit(current_score)
	multiplier_changed.emit(score_multiplier)
