extends Node;
class_name Admin_states;


"""
var states: Dictionary = { #Indica los estados posibles para el jugador
	"in_game":true,"movement":true,"dash_mode":false,
	"dead":false
	};
"""

@onready var character : Character = $"..";

func save_states() -> void:
	character.available_states_node = character.set_available_states();

"""
Estado in_game
"""

func in_game() -> void:
	character.states["in_game"] = true;
	character.states["movement"] = false;
	character.states["dash_mode"] = false;
	character.states["hit"] = false;
	
	character.states["dead"] = false;
	save_states();

func movement() -> void:
	character.states["in_game"] = true;
	character.states["movement"] = true;
	character.states["dash_mode"] = false;
	character.states["hit"] = false;
	
	character.states["dead"] = false;
	save_states();

func dash_mode() -> void:
	character.states["in_game"] = true;
	character.states["movement"] = false;
	character.states["dash_mode"] = true;
	character.states["hit"] = false;
	
	character.states["dead"] = false;
	save_states();

func hit() -> void:
	character.states["in_game"] = true;
	character.states["movement"] = false;
	character.states["dash_mode"] = false;
	character.states["hit"] = true;
	
	character.states["dead"] = false;
	save_states();

"""
Estado dead
"""

func dead() -> void:
	character.states["in_game"] = false;
	character.states["movement"] = false;
	character.states["dash_mode"] = false;
	character.states["hit"] = false;
	
	character.states["dead"] = true;
	save_states();
