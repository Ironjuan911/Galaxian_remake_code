extends Node;
class_name Admin_states_enemy;

"""
var states: Dictionary = { #Indica los estados posibles para el jugador
	"in_game":true,"movement":true,"dash_mode":false,
	"dead":false
	};
"""

@onready var enemy : Enemy = $"..";

func save_states() -> void:
	enemy.available_states_node = enemy.set_available_states();

"""
Estado in_game
"""

func in_game() -> void:
	enemy.states["in_game"] = true;
	enemy.states["movement"] = false;
	enemy.states["dash_mode"] = false;
	
	enemy.states["dead"] = false;
	save_states();

func movement() -> void:
	enemy.states["in_game"] = true;
	enemy.states["movement"] = true;
	enemy.states["dash_mode"] = false;
	
	enemy.states["dead"] = false;
	save_states();

func dash_mode() -> void:
	enemy.states["in_game"] = true;
	enemy.states["movement"] = false;
	enemy.states["dash_mode"] = true;
	
	enemy.states["dead"] = false;
	save_states();

"""
Estado dead
"""

func dead() -> void:
	enemy.states["in_game"] = false;
	enemy.states["movement"] = false;
	enemy.states["dash_mode"] = false;
	
	enemy.states["dead"] = true;
	save_states();
