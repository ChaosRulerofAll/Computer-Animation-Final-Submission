extends Node3D

@export var Lerper : Node3D

@export_group("Nodes")
@export var P1 : Node3D
@export var P2 : Node3D
@export var P3 : Node3D
@export var P4 : Node3D
@export var Target : Node3D

var DP1 : Node3D
var DP2 : Node3D
var DP3 : Node3D
var DP4 : Node3D

var is_going_forward : bool = true

@export_group("Stats")
#@export var speed : float
@export var loop_time : float

enum CurveTypes {Linear, Bezier, Catmull_Rom}
var current_type : CurveTypes = CurveTypes.Linear

var timer : float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	timer += delta
	
	if timer > loop_time:
		is_going_forward = !is_going_forward
		timer -= loop_time
	
	if is_going_forward:
		DP1 = P1
		DP2 = P2
		DP3 = P3
		DP4 = P4
	else:
		DP1 = P4
		DP2 = P3
		DP3 = P2
		DP4 = P1
	
	
	match current_type:
		CurveTypes.Linear:
			Target.position = Lin_Interp(timer/loop_time)
			#print("Linear")
		CurveTypes.Bezier:
			Target.position = Bez_Interp(timer/loop_time)
			#print("Bezier")
		CurveTypes.Catmull_Rom:
			Target.position = Cat_Interp(timer/loop_time)
			#print("Catmull-Rom")
	
	#if Input.is_action_just_pressed("Jump"):
	#	change_type()
	
	#match current_type:
	#	CurveTypes.Linear:
	#		print("Linear")
	#	CurveTypes.Bezier:
	#		print("Bezier")
	#	CurveTypes.Catmull_Rom:
	#		print("Catmull-Rom")
	
	#Target.position = lerp(P1.position, P4.position, timer)

func Lin_Interp(weight: float) -> Vector3:
	var pointA : Node3D = null
	var pointB : Node3D = null
	
	var offset : float = 0
	
	if weight < 0.333:
		pointA = DP1
		pointB = DP2
	elif weight < 0.666:
		pointA = DP2
		pointB = DP3
		offset = 0.333
	else:
		pointA = DP3
		pointB = DP4
		offset = 0.666
	
	return Lerper.my_lerp(pointA.position, pointB.position, (3* (weight - offset)))

func Bez_Interp(weight: float) -> Vector3:
	var pointA : Node3D = null
	var pointB : Node3D = null
	var pointC : Node3D = null
	var pointD : Node3D = null
	
	pointA = DP1
	pointB = DP2
	pointC = DP3
	pointD = DP4
	
	var L1P1 : Vector3 = Lerper.my_lerp(pointA.position, pointB.position, weight)
	var L1P2 : Vector3 = Lerper.my_lerp(pointB.position, pointC.position, weight)
	var L1P3 : Vector3 = Lerper.my_lerp(pointC.position, pointD.position, weight)
	
	var L2P1 : Vector3 = Lerper.my_lerp(L1P1, L1P2, weight)
	var L2P2 : Vector3 = Lerper.my_lerp(L1P2, L1P3, weight)
	
	return Lerper.my_lerp(L2P1, L2P2, weight)

func Cat_Interp(weight: float) -> Vector3:
	var pointA : Node3D = null
	var pointB : Node3D = null
	var pointC : Node3D = null
	var pointD : Node3D = null
	
	pointA = DP1
	pointB = DP2
	pointC = DP3
	pointD = DP4
	
	var w : Vector3 = ((-1* pointA.position) + (3* pointB.position) + (-3* pointC.position) + (1* pointD.position))
	var x : Vector3 = ((2* pointA.position) + (-5* pointB.position) + (4* pointC.position) + (-1* pointD.position))
	var y : Vector3 = ((-1* pointA.position) + (1* pointC.position))
	var z : Vector3 = ((2* pointB.position))
	
	return (0.5 * ((w * weight * weight * weight) + (x * weight * weight) + (y * weight) + (z)))

func change_type() -> void:
	current_type = ((current_type + 1) % CurveTypes.size()) as CurveTypes

func get_curve_type() -> String:
	match current_type:
		CurveTypes.Linear:
			return "Linear"
		CurveTypes.Bezier:
			return "Bezier"
		CurveTypes.Catmull_Rom:
			return "Catmull-Rom"
	return "Error"

func going_forward() -> bool:
	return is_going_forward

func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.get_parent().is_in_group("Slime"):
		change_type()
