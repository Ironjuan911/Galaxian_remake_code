extends Area2D;
class_name CrashManager;

@onready var character : Character = get_parent();
@onready var isFromPlayer : bool;

const maxImpactSpeed : int = 25;

func _ready() -> void:
	if character is Player:
		isFromPlayer = true;
	elif character is Enemy:
		isFromPlayer = false;


func _on_area_entered(area: Area2D) -> void:
	if area is CrashManager and area.isFromPlayer != isFromPlayer:
		CrashEnabled(area);

func CrashEnabled(area : Area2D) -> void:
	character.all_state_node["hit"].directionHit = GlobalVariables.get_vector(area.character.velocity,Vector2(0,0));
	area.character.all_state_node["hit"].impactSpeed = sqrt((character.velocity.x**2+character.velocity.y**2)/16);
	if area.character.all_state_node["hit"].impactSpeed >= maxImpactSpeed:
		area.character.all_state_node["hit"].impactSpeed = maxImpactSpeed;
	area.character.admin_states.hit();
	
