extends Node

var enemies: Array[Enemy]

func find_enemy_by_letter(letter: String) -> Enemy:
	var starting_with_letter = enemies.filter(_search_enemy.bind(letter))
	if starting_with_letter.size() > 0:
		return starting_with_letter[0]
	
	# Bad practice, refactor later
	return null

func add_enemy(enemy: Enemy):
	enemies.append(enemy)

func remove_enemy(enemy: Enemy):
	enemies.erase(enemy)

func _search_enemy(enemy: Enemy, letter: String) -> bool:
	var match = enemy.associated_phrase.begins_with(letter)
	return match
