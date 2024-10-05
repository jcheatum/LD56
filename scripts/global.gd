extends Node

# More correct lerp smoothing. Useful range for `decay` around 1 to 25 for slow
# to fast.
# https://youtu.be/LSNQuFEDOyQ
func exp_decay(from, to, decay: float, dt: float):
	return to+(from-to)*exp(-decay*dt)