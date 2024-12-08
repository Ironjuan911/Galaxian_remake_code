extends CharacterBody2D;
class_name Player;

const avaidable_state = [ #Indica los estados posibles para el jugador
	"in_game","movement","dash_mode",
	"dead"
	];

var index_state = 0; #El indice de los estados en el que se encuentra

func _ready() -> void:
	
	pass;


func _physics_process(delta: float) -> void:
	var Delta = delta*58.86; ## un delta que no afecta el movimiento si es que olvidas ponerlo
	
	match avaidable_state[index_state]:
		"in_game": 
			pass;
		"movement":
			pass;
		"dash_mode":
			pass;
		"dead":
			pass;
		_:
			pass; #No jodas cuidado le hechan ganas al default
	
	
	move_and_slide();
	
func get_state_node(node_name):
	var stateNodeGroup = get_tree().get_nodes_in_group(node_name);
	var stateNode = stateNodeGroup[0];
	return stateNode;
