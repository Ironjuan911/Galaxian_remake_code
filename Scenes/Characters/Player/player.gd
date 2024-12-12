extends CharacterBody2D;
class_name Player;

@onready var admin_states: Admin_states_player = $Admin_States;

var states: Dictionary = { #Indica los estados posibles para el jugador
	"in_game":true,"movement":true,"dash_mode":false,
	"dead":false
	};
	
var all_state_node: Dictionary = states.duplicate(); #Contiene los nodos que trata con los diversos estados del jugador (Se añaden en la funcion ready)
var avaidable_states_node : Array[Node2D];

func _ready() -> void:
	var i = 0;
	for name_state in states: #Se añaden los nodos de estados al array :D
		all_state_node[name_state] = get_state_node(name_state);
		i += 1;
	avaidable_states_node = set_avaidable_states();

func _physics_process(delta: float) -> void:
	var Delta = delta*58.86; ## un delta que no afecta el movimiento si es que olvidas ponerlo
	
	for state in avaidable_states_node:
		state.local_physics_process(Delta);
	
	move_and_slide();
	
func get_state_node(node_name) -> Node:
	var stateNode = get_tree().get_first_node_in_group(node_name);
	return stateNode;

func set_avaidable_states() -> Array[Node2D]: ## Funcion que retorna los nodos de los estados que se encuentran en true en un array :D
	var output_array : Array[Node2D];
	output_array.resize(0);
	var i = 0;
	for node_name in all_state_node:
		if states[node_name]:
			output_array.resize(output_array.size()+1); #Ampliar el espacio del array en 1
			output_array[i] = all_state_node[node_name]; # si se encuentra en true, añadirlo al output
			print(output_array);
			i += 1;
			
			#LLamar funcion activate, a cada nodo que se añada al output
			if all_state_node[node_name].has_method("activated"):
				all_state_node[node_name].activated();
	
	return output_array;
