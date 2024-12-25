extends Node

signal enemy_destroyed(position: Vector3)

func emit_enemy_destroyed(position: Vector3):
	emit_signal('enemy_destroyed', position)

signal player_destroyed

func emit_player_destroyed():
	emit_signal('player_destroyed')
