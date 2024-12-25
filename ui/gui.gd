class_name Gui
extends Control

func set_score(score: int):
	%ScoreLabel.text = str(score)

func set_health(health: int):
	%HealthLabel.text = str(health)
