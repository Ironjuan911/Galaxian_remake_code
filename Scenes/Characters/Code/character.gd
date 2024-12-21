extends CharacterBody2D;
class_name Character;

@onready var admin_states: Node = $Admin_States;
@onready var sprite: Sprite2D = $Sprite

var states: Dictionary = { #Indica los estados posibles para el jugador
	"in_game":true,"movement":true,"hit":false,
	"dead":false
	};
	
var all_state_node: Dictionary = states.duplicate(); #Contiene los nodos que trata con los diversos estados del jugador (Se añaden en la funcion ready)
var available_states_node : Array[Node2D];

func extend_ready():
	pass;
#AYUDA, no entiendo nada
func _ready() -> void:
	extend_ready();
	var i = 0;
	for name_state in states: #Se añaden los nodos de estados al array :D
		all_state_node[name_state] = get_state_node(name_state);
		i += 1;
	available_states_node = set_available_states(available_states_node);


func _physics_process(delta: float) -> void:
	delta = delta*58.86; ## un delta que no afecta el movimiento si es que olvidas ponerlo
	
	for state in available_states_node:
		if state.has_method("local_physics_process"):
			state.local_physics_process(delta);
	
	move_and_slide();
	
func get_state_node(node_name) -> Node: # Funcion que debe de ser reescrita en player y enemy
	var stateNode;
	return stateNode;

func set_available_states(old_array : Array[Node2D]) -> Array[Node2D]: ## Funcion que retorna los nodos de los estados que se encuentran en true en un array :D
	var output_array : Array[Node2D];
	output_array.resize(0);
	var i = 0;
	for node_name in all_state_node:
		if states[node_name]:
			output_array.resize(output_array.size()+1); #Ampliar el espacio del array en 1
			output_array[i] = all_state_node[node_name]; # si se encuentra en true, añadirlo al output
			
			i += 1;
			
			#LLamar funcion activate, a cada nodo que se añada al output
			if all_state_node[node_name].has_method("start_state"):
				all_state_node[node_name].start_state();
				
	end_states(old_array,output_array);
	return output_array;

func end_states(old_array : Array[Node2D], new_array : Array[Node2D]) -> void:
	print(new_array);
	for NodeState : Node in old_array:
		if !(NodeState in new_array) and NodeState.has_method("end_state"):
			print("End state: " + str(NodeState));
			NodeState.end_state();
