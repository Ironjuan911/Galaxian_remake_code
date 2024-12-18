extends Character;
class_name Player;


func extend_ready() -> void:
	states = { #Indica los estados posibles para el jugador
	"in_game":true,"movement":true,"dash_mode":false,
	"dead":false
	}

func get_state_node(node_name) -> Node:
	var stateNodes = get_tree().get_nodes_in_group(node_name);
	var stateNode;
	for node_ in stateNodes:
		if node_.get_parent().get_parent() == $".":
			stateNode = node_;
			break;
	return stateNode;
