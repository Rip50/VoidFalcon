class_name Enemy
extends CharacterBody3D

@export var associated_phrase: String = ''

var symbols_left: int:
	get:
		return phrase_componet.phrase.length() - phrase_componet.typed_count

@onready var health_componet: HealthComponent = get_node('HealthComponent')
@onready var phrase_componet: PhraseComponent = get_node('PhraseComponent')
const DYNAMIC_LABEL = preload("res://scenes/dynamic_label.tscn") as PackedScene

signal phrase_changed
var label: DynamicLabel

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
	emit_signal('phrase_changed')

func _destroy():
	health_componet.health_depleted.disconnect(_destroy)
	queue_free()
