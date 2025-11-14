class_name ScoringUI
extends PanelContainer

@onready var base_score: Label = %BaseScore
@onready var mult_score: Label = %MultScore

var scoring_system: ScoringSystem

func _ready() -> void:
	scoring_system = get_node("/root/ScoringSystem")
	
	scoring_system.score_updated.connect(_on_score_updated)
	scoring_system.multiplier_changed.connect(_on_multiplier_changed)
	
	_on_score_updated(scoring_system.current_score)
	_on_multiplier_changed(scoring_system.score_multiplier)

func _on_score_updated(new_score: int):
	base_score.text = "Points: %s " % new_score

func _on_multiplier_changed(new_multiplier: float):
	mult_score.text = "Mult: x%s " % new_multiplier
	
	if new_multiplier >= 2.0:
		mult_score.modulate = Color.YELLOW
	elif new_multiplier >= 1.5:
		mult_score.modulate = Color.RED
	else:
		mult_score.modulate = Color.WHITE
