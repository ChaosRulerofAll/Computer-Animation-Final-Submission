extends StaticBody3D


var reflect_axis : Vector3

@export var colour : Color

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reflect_axis = self.global_basis.z.normalized()


func change_colour() -> void:
	self.get_child(0).mesh.material.albedo_color = colour


func Bounce(slime: CharacterBody3D):
	var vel = slime.get_vel()
	var vel_l = vel.length()
	
	#print(vel_l)
	
	if vel_l > 1:
		#print("is fast enough!")
		var new_vel = -0.9 * vel.normalized().rotated(reflect_axis, PI) * vel_l
		slime.velocity = new_vel
		#colour = slime.get_colour()
	else:
		#print("wasn't fast enough")
		pass
	


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.get_parent_node_3d().name == "Slime":
		#change_colour()
		pass
