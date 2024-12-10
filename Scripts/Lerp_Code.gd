extends Node3D

func my_lerp(first : , second : , weight : float):
	if type_string(typeof(first)) == type_string(typeof(second)):
		#I that a lerp is not supposed to have a weight that is greater than 1 or less than 0
		#but the math still works and in nieche senarios it might come in handy
		return ((first * (1 - weight)) + (second * weight))

#I realized that the whole thing could be made into one line and thought it was funny so I did it
func my_lerp_one_line_version(first : , second : , weight : float): if type_string(typeof(first)) == type_string(typeof(second)): return ((first * (1 - weight)) + (second * weight))

#How small can I make the code and still have it be functional?
func L(f:,s:,w:float):return((f*(1-w))+(s*w)) #I lose the typeof safety check here but it should still work
