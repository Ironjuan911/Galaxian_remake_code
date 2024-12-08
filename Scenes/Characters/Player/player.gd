extends CharacterBody2D;
class_name Player;

const avaidable_state: Array[String] = [ #Indica los estados posibles para el jugador
	"in_game","movement","dash_mode",
	"dead"
	];
	
var avaidable_state_node: Array[Node]; #Contiene los nodos que trata con los diversos estados del jugador (Se añaden en la funcion ready)
var index_state = 0; #El indice de los estados en el que se encuentra

func _ready() -> void:
	avaidable_state_node.resize(avaidable_state.size()); #Se le pone el tamaño (COMO SI FUERA JAVA NMMS)
	var i = 0;
	while i <= avaidable_state.size() - 1: #Se añaden los nodos de estados al array :D
		avaidable_state_node[i] = get_state_node(avaidable_state[i]);
		print(avaidable_state_node);
		i += 1;


func _physics_process(delta: float) -> void:
	var Delta = delta*58.86; ## un delta que no afecta el movimiento si es que olvidas ponerlo
	
	avaidable_state_node[index_state].local_physics_process(Delta);
	
	move_and_slide();
	
func get_state_node(node_name):
	var stateNodeGroup = get_tree().get_nodes_in_group(node_name);
	var stateNode = stateNodeGroup[0];
	return stateNode;
