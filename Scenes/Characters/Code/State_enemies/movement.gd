extends Node2D;

const meter : int = GlobalVariables.meter;
var speed : int = 11;
var direction : Vector2;

@onready var character : Enemy = $"../..";
@onready var AI : AI_Enemy = $"../../AI_Enemy";

func local_physics_process(delta: float) -> void:
	direction = AI.direction;
	if (direction.x != 0 and direction.y != 0):
		general_movement(delta);
	else:
		idle_movement(delta);

func general_movement(delta: float) -> void:
	
	character.velocity.x = lerp(character.velocity.x,meter*speed*delta*direction.x,0.05);
	character.velocity.y = lerp(character.velocity.y,-meter*speed*delta*direction.y,0.05);
	
func idle_movement(delta: float) -> void:
	character.velocity.x = lerp(character.velocity.x,0.0,0.1);
	character.velocity.y = lerp(character.velocity.y,0.0,0.1);
	pass
