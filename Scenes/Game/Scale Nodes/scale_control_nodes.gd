extends Node;
class_name Scale_control_nodes;

enum SubViewports_list {
	Center_Viewport,
}
@export var scale_x : bool = true;
@export var scale_y : bool = true;
@export_category("SubViewport")
@export var SubViewport_select_index : SubViewports_list;
@onready var Scaleable_Nodes = get_tree().get_nodes_in_group("Scaleable_node");

var SubViewport_Node : SubViewport;
var base_resolution : Vector2 = GlobalVariables.base_resolution_center_viewport;

var exist_SubViewport : bool;
var real_resolution : Vector2;


func _ready() -> void:
	await get_tree().create_timer(0.1).timeout;
	var SubViewport_select : String = SubViewports_list.find_key(SubViewport_select_index);
	exist_SubViewport = get_tree().has_group(SubViewport_select);
	if (exist_SubViewport):
		SubViewport_Node = get_tree().get_first_node_in_group(SubViewport_select);
	
	for Control_Node : Control in Scaleable_Nodes:
		Control_Node.set_meta("real_scale",Control_Node.scale);#Crear una especie de variable desde otro nodo
	

func _physics_process(delta: float) -> void:
	if (exist_SubViewport and (real_resolution.x != SubViewport_Node.size.x or real_resolution.y != SubViewport_Node.size.y)):
		zoom_resolution_camara();

func zoom_resolution_camara() -> void:
	real_resolution = SubViewport_Node.size;

	for Control_Node : Control in Scaleable_Nodes:
		#Control_Node.scale =(Control_Node.real_scale*real_resolution)/base_resolution;
		Control_Node.scale =(Control_Node.get_meta("real_scale") *real_resolution)/base_resolution;
		
		if not scale_x:
			Control_Node.scale.x = Control_Node.scale.y;
		if not scale_y:
			Control_Node.scale.y = Control_Node.scale.x;
