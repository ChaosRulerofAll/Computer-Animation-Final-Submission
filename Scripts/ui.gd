extends Control


@export var type_ui : Label

var type : String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	type = $"../To Aim At/Curve setup/Curve Manager".get_curve_type()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	type_ui.text = "Current Curve Type:\n" + type
	type = $"../To Aim At/Curve setup/Curve Manager".get_curve_type()
