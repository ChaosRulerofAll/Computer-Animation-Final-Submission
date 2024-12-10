extends CharacterBody3D


@export var launch_force : float = 8
@export var mesh : CharacterBody3D
@export var mesh2 : CharacterBody3D
#@export var colour : Color

#@export_group("Emotions")
#@export var happy_face : Texture2D
#@export var sad_face : Texture2D
var sad_face : Node3D
var happy_face : Node3D

var prev_vel : Vector3 = Vector3(0, 0, 0)

#Here is a small FSM to help with the slime's behaviour AI
enum states {following, flying}
var current_state : int = states.following

var move_target : Node3D = null
var move_speed : float = 3

var anim_jump_time : float
var animator1 : AnimationPlayer
var animator2 : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#$MeshInstance3D.mesh.material.albedo_color = col#our
	anim_jump_time = 2
	animator1 = $"SlimeMesh Happr/AnimationPlayer"
	animator1.play("Armature|IdleAnimation")
	animator2 = $"SlimeMesh Sad/AnimationPlayer"
	animator2.play("Armature|IdleAnimation")
	move_target = get_tree().get_first_node_in_group("Player")
	sad_face = $"SlimeMesh Sad"
	sad_face.hide()
	happy_face = $"SlimeMesh Happr"
	happy_face.show()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	anim_jump_time -= delta
	
	if anim_jump_time < 0:
		anim_jump_time = 2
		animator1.play("Armature|IdleAnimation")
		animator2.play("Armature|IdleAnimation")
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	prev_vel = velocity
	
	if velocity.length() < 1:
		current_state = states.following
	
	if current_state == states.following and is_on_floor():
		move_target = get_tree().get_first_node_in_group("Player")
		var mov_dir = (move_target.position - self.position + Vector3(0, -0.5, 0)).normalized() * move_speed
		velocity = mov_dir
		mesh.look_at(move_target.position - Vector3(0, 0.5, 0))
		mesh2.look_at(move_target.position - Vector3(0, 0.5, 0))
	elif current_state == states.flying and velocity != Vector3.UP:
		mesh.look_at(self.position + velocity)
		mesh2.look_at(self.position + velocity)
	
	if current_state == states.following:
		sad_face.hide()
		happy_face.show()
	else:
		sad_face.show()
		happy_face.hide()
	
	
	move_and_slide()


#to be called when hit by stick
func launch(dir: Vector3) -> void:
	dir = (dir.normalized() + Vector3(0, 0.7, 0)) * launch_force
	velocity += dir
	current_state = states.flying


#Paint the walls!
#func get_colour() -> Color:
#	print("getting the colour")
#	return colour

func get_vel() -> Vector3:
	return prev_vel

#if I collide with a wall at a fast enough speed, i bounce
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.has_method("Bounce"):
		body.Bounce(self)
