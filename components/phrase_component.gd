class_name PhraseComponent
extends Node

@export var phrase: String = ''
var typed_count: int = 0

func type():
	typed_count += 1
