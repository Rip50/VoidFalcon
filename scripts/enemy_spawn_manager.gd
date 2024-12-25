class_name EnemySpawnManager
extends Node

@export var player: Player
@export var enemy_scene: PackedScene  # Сцена врага
@export var spawn_distance: float = 500.0  # Расстояние линии спауна перед игроком
@export var spawn_range_x: Vector2 = Vector2(-50, 50)  # Диапазон случайного положения по X
@export var spawn_interval: float = 1.5  # Интервал между спаунами
@export var max_enemy_count: int = 5

@export var dictionary: Array[String] = [
	"vivid", "cascade", "luminous", "whisker", "ponder", "azure", "orbit", "quaint", "flicker", "glimmer",
	"ripple", "ember", "sizzle", "breeze", "crystal", "harmony", "whisper", "zephyr", "quasar", "prism",
	"galaxy", "serene", "voyage", "meadow", "eclipse", "spectrum", "nebula", "stellar", "mirage", "twilight",
	"velvet", "cinder", "solace", "radiant", "chimera", "aether", "thistle", "sparkle", "blossom", "lattice",
	"amber", "mystic", "pebble", "flourish", "silken", "verdant", "dusk", "petal", "wisp", "glacier",
	"haven", "tranquil", "bramble", "tapestry", "frost", "aurora", "zenith", "parchment", "crescent", "horizon",
	"labyrinth", "quiver", "serenade", "ember", "willow", "glisten", "meander", "realm", "spire", "murmur",
	"plume", "spire", "harbor", "elegant", "grotto", "whimsy", "ascent", "canopy", "brook", "solitude",
	"rift", "fern", "opal", "sapphire", "blizzard", "ebony", "fable", "moondust", "celestial", "pinnacle",
	"serenity", "gossamer", "silhouette", "embers", "dewdrop", "verve", "luminary", "petal", "wistful", "quaint"
]

var spawn_timer: Timer
var used_phrases_buffer: RingBuffer = RingBuffer.new(max_enemy_count)

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

func _get_next_phrase() -> String:
	var result: String = ''
	while result == '':
		var phrase = dictionary.pick_random()
		# TODO: Потенциальный баг - бесконечный цикл
		# Фраза уже присутствует в буфере или начинается с той же буквы, что одна из фраз в буфере
		if used_phrases_buffer.contains(func(existing_phrase): return existing_phrase == phrase or (existing_phrase as String).begins_with(phrase[0])):
			continue
		result = phrase
		
	return result

func spawn_enemy():
	if not enemy_scene:
		return
	
	if _count_enemies() >= max_enemy_count:
		return

	# Создаём врага
	var enemy = enemy_scene.instantiate() as Enemy
	var phrase = _get_next_phrase()
	enemy.associated_phrase = phrase
	add_child(enemy)
	used_phrases_buffer.push(phrase)
	
	# Устанавливаем позицию спауна
	var spawn_position = player.global_transform.origin
	spawn_position.z -= spawn_distance  # Линия перед игроком
	spawn_position.x = randi_range(spawn_range_x.x, spawn_range_x.y)  # Случайное положение по X
	spawn_position.y = player.global_transform.origin.y  # Высота совпадает с высотой игрока

	enemy.global_transform.origin = spawn_position
