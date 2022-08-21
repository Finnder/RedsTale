extends Node
# GLOBAL VARIABLES


# LEVEL DATA
var CurrentLevel : int = 0 # Current level gets loaded and saved
var CurrentZone : int = 0 # unused for now

# SPEED RUN
var SpeedRunTimerEnabled : bool = false

const BEST_DEFAULT : float = 100000.0
var SpeedRunTimerBest : float = BEST_DEFAULT
var SpeedRunTimerCurrent : float = 0.00 # Current Time
