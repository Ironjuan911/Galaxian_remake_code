extends Node2D;
class_name ManagerEnemies;

@onready var spawn_enemies: SpawnEnemies = $SpawnEnemies;
@onready var all_zones : Array[Node] = get_tree().get_nodes_in_group("Zones");
@onready var timer_ready: Timer = $TimerReady

@onready var available_zones : int = all_zones.size();

func get_random_zone_enemy() -> int:
	return GlobalVariables.create_random_number(available_zones) - 1;

func _ready() -> void:
	pass;

func new_enemy(id_zone : int)-> void:
	var node_objective : Node2D = all_zones[id_zone];
	var _enemy = spawn_enemies.spawn(node_objective.global_position);


var i = 0;
func _ready_timer() -> void:
	if i >= available_zones:
		timer_ready.autostart = false;
	else:
		new_enemy(i);
		i += 1;
	
	
