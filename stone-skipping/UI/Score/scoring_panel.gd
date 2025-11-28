class_name ScoringUI
extends PanelContainer

@onready var base_score: Label = %BaseScore
@onready var mult_score: Label = %MultScore

var scoring_system: ScoringSystem
var tween_score : Tween
var tween_mult : Tween

func _ready() -> void:
	scoring_system = get_node("/root/ScoringSystem")
	
	scoring_system.score_updated.connect(_on_score_updated)
	scoring_system.multiplier_changed.connect(_on_multiplier_changed)
	
	_on_score_updated(scoring_system.current_score)
	_on_multiplier_changed(scoring_system.score_multiplier)
	
	#animate_value(100,scoring_system.current_score)

func _on_score_updated(new_score: int):
	#base_score.text = "Points: %s " % new_score
	#animate value
	if tween_score:
		tween_score.kill()
	tween_score = get_tree().create_tween()
	tween_score.set_parallel().tween_property(base_score,"text","Points: %s " % new_score,0.3).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)

func _on_multiplier_changed(new_multiplier: float):
	mult_score.text = "Mult: x%s " % new_multiplier
	
	if new_multiplier >= 2.0:
		mult_score.modulate = Color.RED
	elif new_multiplier >= 1.5:
		mult_score.modulate = Color.YELLOW
	else:
		mult_score.modulate = Color.WHITE
	
	if tween_mult: 
		tween_mult.kill()
	tween_mult = get_tree().create_tween()
	tween_mult.set_parallel().tween_property(mult_score,"text", "Mult: x%s " % new_multiplier,0.3).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	

func animate_value(start:float,end:float)->void:
	var tween = get_tree().create_tween()
	#tween.tween_property($TextureProgressBar,"tint_progress",Color(0.5,0,0),0.2).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	#tween.set_parallel().tween_property($TextureProgressBar,"value",end,0.3).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	tween.set_parallel().tween_method(_on_score_updated,start,end,5).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	#tween.chain().tween_property($TextureProgressBar,"tint_progress",Color(1,0,0),0.3).set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_OUT)
	
