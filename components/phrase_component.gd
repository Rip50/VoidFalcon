class_name PhraseComponent
extends Node

@export var phrase: String = ''

var typed_count: int = 0

var next_letter: String:
	get:
		if typed_count >= phrase.length():
			return ''
		return phrase[typed_count]

var phrase_left: String:
	get:
		return phrase.substr(typed_count)

func type():
	typed_count += 1
