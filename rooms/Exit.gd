tool
extends Resource
class_name Exit


var room_1 = null
var room_is_locked := false

var room_2 = null
var room_2_is_locked := false


func get_other_room(current_room):
	if current_room == room_1:
		return room_2
	elif current_room == room_2:
		return room_1
	else:
		printerr("That is not possible.")
		return null
