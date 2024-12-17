extends Node2D
class_name SpawnEnemies;

var data_enemy : Array[PackedScene] = [
	preload("res://Scenes/Characters/Enemies/Enemy_1/Enemy_1.tscn"),
	preload("res://Scenes/Characters/Enemies/Enemy_2/Enemy_2.tscn")
]

const available_enemies = 2;

@onready var manager_enemies: ManagerEnemies = $".."



func spawn(point_reference : Vector2) -> Enemy:
	var id_enemy = GlobalVariables.create_random_number1(available_enemies) - 1;
	var enemy : Enemy = data_enemy[id_enemy].instantiate();
	get_parent().add_sibling(enemy);
	enemy.position = global_position;
	
	enemy.AI.point_reference = point_reference;
	enemy.AI.point_objective = point_reference;
	return enemy;
