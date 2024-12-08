class_name EnemySpawnManager
extends Node

@export var player: CharacterBody3D
@export var enemy_scene: PackedScene  # Сцена врага
@export var spawn_distance: float = 500.0  # Расстояние линии спауна перед игроком
@export var spawn_range_x: Vector2 = Vector2(-50, 50)  # Диапазон случайного положения по X
@export var spawn_interval: float = 1.5  # Интервал между спаунами
@export var max_enemy_count: int = 5

var spawn_timer: Timer

func _ready():
	# Создаём и настраиваем таймер
	spawn_timer = Timer.new()
	spawn_timer.wait_time = spawn_interval
	spawn_timer.one_shot = false
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	add_child(spawn_timer)
	spawn_timer.start()

func _on_spawn_timer_timeout():
	spawn_enemy()

func _count_enemies() -> int:
	return get_children().filter(func(node: Node): return node.is_in_group('enemies')).size()

func spawn_enemy():
	if not enemy_scene:
		return
	
	if _count_enemies() >= max_enemy_count:
		return

	# Создаём врага
	var enemy = enemy_scene.instantiate() as Enemy
	add_child(enemy)

	# Устанавливаем позицию спауна
	var spawn_position = player.global_transform.origin
	spawn_position.z -= spawn_distance  # Линия перед игроком
	spawn_position.x = randi_range(spawn_range_x.x, spawn_range_x.y)  # Случайное положение по X
	spawn_position.y = player.global_transform.origin.y  # Высота совпадает с высотой игрока

	enemy.global_transform.origin = spawn_position
