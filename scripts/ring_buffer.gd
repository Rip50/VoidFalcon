class_name RingBuffer
extends Node

var buffer: Array[Variant]  # Internal storage for strings
var max_size: int  # Maximum number of strings

# Constructor to initialize the buffer
func _init(size: int):
	max_size = size

# Push a string into the buffer
func push(value: Variant):
	if not value:
		return  # Ignore null or empty strings
		
	while buffer.size() >= max_size:
		buffer.pop_back()
	
	buffer.push_front(value)

# Pop the oldest string from the buffer
func pop() -> Variant:
	return buffer.pop_back()

# Check if any string in the buffer satisfies the given condition
func contains(callback: Callable) -> bool:
	for i in range(buffer.size()):
		if callback.call(buffer[i]):
			return true
	return false

# Debug helper to print the buffer's current state
func debug_print():
	print("Buffer:", buffer)
