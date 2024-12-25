extends Node

signal enemy_destroyed(position: Vector3)
signal player_destroyed
signal player_health_changed(value: int)

func emit_enemy_destroyed(position: Vector3):
	emit_signal('enemy_destroyed', position)

func emit_player_destroyed():
	emit_signal('player_destroyed')

func emit_player_health_changed(value: int):
	emit_signal('player_health_changed', value)
