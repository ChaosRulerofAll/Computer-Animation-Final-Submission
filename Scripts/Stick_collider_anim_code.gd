extends StaticBody3D


var timer : float = 0
var is_attacking : bool = false
var angle : float = (35*PI/180)

@export var camera : Camera3D

var slime : Area3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	camera = $"../Head/CameraContainer/Camera3D"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if is_attacking and timer >= 0:
		timer -= delta
	
	if Input.is_action_just_pressed("Attack"):
		timer = 0.333
		is_attacking = true
	
	if timer < 0:
		is_attacking = false
		timer = 0.333
	
	self.rotation.y = lerp(-angle, 2* angle, (1 - timer * 3))
	
	if is_attacking and slime != null:
		slime.get_parent().launch(-camera.get_camera_transform().basis.z)


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.get_parent().has_method("launch"):
		slime = area


func _on_area_3d_area_exited(area: Area3D) -> void:
	if area.get_parent().has_method("launch"):
		slime = null
