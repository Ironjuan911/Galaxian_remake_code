extends CharacterBody2D;
class_name Bullet;

var focused : Dictionary = {
	"player" : false,
	"enemy" : false
}

var color_type : int = 0;

var up_direction_ : bool = true;
var direction : float;

var speed : int = 30;
var meter : int = GlobalVariables.meter;
var impact : bool = false;

@onready var sprite: Sprite2D = $Sprite

func _ready() -> void:
	await get_tree().process_frame;
	if 0 <= color_type and color_type <= 4:
		sprite.frame = color_type;
	else:
		sprite.frame = 1;
	
	if (up_direction_):
		direction = -1;
	else:
		direction = 1;

func _physics_process(delta: float) -> void:
	delta = delta*58.86;
	if not impact:
		velocity.y = speed*meter*delta*direction;
		move_and_slide();
	checkDelete();


func _impact_character(body: Node2D) -> void:
	if (focused["player"]):
		if body is Player:
			impact = true;
			body.all_state_node["hit"].directionHit = Vector2(0,direction);
			body.admin_states.hit();
			queue_free();


	if (focused["enemy"]):
		if body is Enemy:
			impact = true;
			body.all_state_node["hit"].directionHit = Vector2(0,direction);
			body.admin_states.hit();
			queue_free();

func checkDelete() -> void:
	if GlobalVariables.in_world(global_position):
		queue_free();
