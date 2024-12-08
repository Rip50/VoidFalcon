class_name GrowEffectComponent
extends Node

@export var target_object: Node3D  # Ссылка на целевой объект
@export var duration: float = 2.0  # Продолжительность анимации
@export var start_scale: float = 0.1  # Начальный масштаб
@export var end_scale: float = 1.0  # Конечный масштаб

func _ready():
	if not target_object:
		target_object = get_parent()  # Если объект не задан, используется родитель
	if not target_object:
		push_error("Target object is not set for ScaleComponent!")
		return

	# Устанавливаем начальный масштаб
	target_object.scale = Vector3(start_scale, start_scale, start_scale)

	# Создаём Tween
	var tween = create_tween()

	# Настраиваем анимацию
	tween.tween_property(
		target_object,
		"scale",
		Vector3(end_scale, end_scale, end_scale),
		duration
	).set_trans(Tween.TRANS_SINE)
	
	tween.play()
