extends Node2D;
class_name ManagerEnemies;

@onready var spawn_enemies: SpawnEnemies = $SpawnEnemies;
@onready var all_zones : Array[Node] = get_tree().get_nodes_in_group("Zones");
@onready var timer_ready: Timer = $TimerReady
@onready var timer_game: Timer = $TimerGame

@onready var available_zones : int = all_zones.size();

var enemy_list : Array[Enemy];

func get_random_zone_enemy() -> int:
	return GlobalVariables.create_random_number1(available_zones) - 1;

func _ready() -> void:
	enemy_list.resize(available_zones);
	timer_game.paused = true;
	pass;

func new_enemy(id_zone : int)-> Enemy:
	var node_objective : Node2D = all_zones[id_zone];
	var _enemy = spawn_enemies.spawn(node_objective.global_position);
	return _enemy


var i = 0;
func _ready_timer() -> void:
	if i >= available_zones:
		timer_ready.autostart = false;
		#await get_tree().create_timer(2.0).timeout;
		await get_tree().process_frame;
		timer_game.paused = false;
	else:
		enemy_list[i] = new_enemy(i);
		i += 1;


func _process_timer() -> void:
	print("true")
	enemy_list[get_random_zone_enemy()].AI.start();
