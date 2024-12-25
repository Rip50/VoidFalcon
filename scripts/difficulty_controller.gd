class_name DifficultyController
extends Node

@export var player: Player
@export var enemy_spawn_manager: EnemySpawnManager
@export var difficulty_increase_period_sec: int = 30
@export var enemy_count_increase_period_sec: int = 120
@export var velocity_increase_step: float = 1.0

var timer: Timer
var enemy_update_timer: Timer

func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = false
	timer.timeout.connect(_increase_difficulty)
	add_child(timer)
	timer.start(difficulty_increase_period_sec)
	
	enemy_update_timer = Timer.new()
	enemy_update_timer.one_shot = false
	enemy_update_timer.timeout.connect(_update_enemy_spawn)
	add_child(enemy_update_timer)
	enemy_update_timer.start(enemy_count_increase_period_sec)

func _increase_difficulty():
	# TODO: make sign-agnostic
	player.velocity -= velocity_increase_step

func _update_enemy_spawn():
	enemy_spawn_manager.max_enemy_count += 1
	var spawn_time_period = enemy_spawn_manager.spawn_interval - 0.1
	enemy_spawn_manager.spawn_interval = clamp(spawn_time_period, 0.5, 2.0)
