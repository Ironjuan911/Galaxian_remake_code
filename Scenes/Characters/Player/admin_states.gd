extends Node;
class_name Admin_states_player;

"""
var states: Dictionary = { #Indica los estados posibles para el jugador
	"in_game":true,"movement":true,"dash_mode":false,
	"dead":false
	};
"""

@onready var player : Player = $"..";

func save_states() -> void:
	player.avaidable_states_node = player.set_avaidable_states();

"""
Estado in_game
"""

func in_game() -> void:
	player.states["in_game"] = true;
	player.states["movement"] = false;
	player.states["dash_mode"] = false;
	
	player.states["dead"] = false;
	save_states();

func movement() -> void:
	player.states["in_game"] = true;
	player.states["movement"] = true;
	player.states["dash_mode"] = false;
	
	player.states["dead"] = false;
	save_states();

func dash_mode() -> void:
	player.states["in_game"] = true;
	player.states["movement"] = false;
	player.states["dash_mode"] = true;
	
	player.states["dead"] = false;
	save_states();

"""
Estado dead
"""

func dead() -> void:
	player.states["in_game"] = false;
	player.states["movement"] = false;
	player.states["dash_mode"] = false;
	
	player.states["dead"] = true;
	save_states();
