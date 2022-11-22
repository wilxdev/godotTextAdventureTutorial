extends Node


var current_room = null
var player = null


func initialize(starting_room, player) -> String:
	self.player = player
	return change_room(starting_room)


func process_command(input: String):
	var words = input.split(" ", false)
	if words.size() == 0:
		return "Error: no words were parsed."
		
	var first_word = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()
	match first_word:
		"go":
			return go(second_word)
		"take":
			return take(second_word)
		"help":
			return help()
		_:
			return "Command not valid. Please try again or type help for possible commands."


func go(second_word: String) -> String:
	if second_word == "":
		return "Go where?"
		
	if current_room.exits.keys().has(second_word):
		var exit = current_room.exits[second_word]
		var change_response = change_room(exit.get_other_room(current_room))
		return PoolStringArray(["You go %s. " % second_word, change_response]).join("\n")
	else:
		return "There's no exit in that direction!"


func take(second_word: String) -> String:
	if second_word == "":
		return "Take what?"
	for item in current_room.items:
		if second_word.to_lower() == item.item_name.to_lower():
			return "You take the " + item.item_name
	return "No such thing to take.";


func help() -> String:
	return "Possible commands are as follows: go [location], help"


func change_room(new_room: GameRoom) -> String:
	current_room = new_room
	return new_room.get_full_description()
	
