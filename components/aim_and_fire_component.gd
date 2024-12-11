class_name AimAndFireComponent
extends Node

@export var player: Player

var target: Enemy = null 

func process_input(letter: String):
	if target != null:
		try_shoot(letter)
	else:
		target = try_aim(letter)
		try_shoot(letter)

func try_shoot(letter: String):
	if target == null:
		return
	
	if target.next_letter == letter:
		player.shoot()
		target.take_damage()
	
	if target.next_letter == '':
		target = null

func try_aim(letter: String) -> Enemy:
	var enemy = EnemyTracker.find_enemy_by_letter(letter)
	if enemy == null:
		return null
	
	player.steer(enemy)
	
	return enemy
