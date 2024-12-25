class_name Enemy
extends CharacterBody3D

const EXPLOSION = preload("res://scenes/particles/explosion.tscn")
@export var associated_phrase: String = ''

var symbols_left: int:
	get:
		return phrase_componet.phrase.length() - phrase_componet.typed_count

var next_letter: String:
	get:
		return phrase_componet.next_letter

@onready var health_componet: HealthComponent = get_node('HealthComponent')
@onready var phrase_componet: PhraseComponent = get_node('PhraseComponent')
const DYNAMIC_LABEL = preload("res://scenes/dynamic_label.tscn") as PackedScene

signal phrase_changed

var label: DynamicLabel

func _enter_tree() -> void:
	EnemyTracker.add_enemy(self)

func _exit_tree() -> void:
	EnemyTracker.remove_enemy(self)

func _ready() -> void:
	health_componet.max_health = associated_phrase.length()
	health_componet.restore_health(associated_phrase.length())
	health_componet.health_depleted.connect(_destroy)
	phrase_componet.phrase = associated_phrase
	_add_label(associated_phrase)

func _add_label(text: String):
	label = DYNAMIC_LABEL.instantiate() as DynamicLabel
	add_child(label)
	label.position = Vector3(0, 3, 0)
	label.label.text = text

func take_damage():
	health_componet.take_damage()
	phrase_componet.type()
	label.label.text = phrase_componet.phrase_left
	emit_signal('phrase_changed')

func _destroy():
	health_componet.health_depleted.disconnect(_destroy)
	_explode()
	SignalBus.emit_enemy_destroyed(self.position)
	queue_free()

func _explode():
	var explosion = EXPLOSION.instantiate()
	explosion.emitting = true
	explosion.one_shot = true
	get_parent().add_child(explosion)
	explosion.global_position = self.global_position

func crash_with(body: Node3D):
	_destroy()
