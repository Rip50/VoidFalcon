class_name HealthComponent
extends Node

@export var max_health: int = 1

signal health_depleted
signal health_changed(value: int)

var current_health: int:
	set(value): 
		current_health = clampi(value, 0, max_health)
		if current_health <= 0:
			emit_signal('health_depleted')
		else:
			emit_signal('health_changed', current_health)

func _ready():
	current_health = max_health

func take_damage():
	current_health -= 1

func restore_health(value: int):
	current_health += value

func get_destroyed():
	current_health = 0
