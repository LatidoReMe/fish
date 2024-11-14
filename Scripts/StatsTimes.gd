extends Control

@onready var season : Label = $SeasonTimes/Season
@onready var tod : Label = $SeasonTimes/Time

@onready var lvl : Label = $FishXP/Level
@onready var expbar : ProgressBar = $FishXP/EXPBar
@onready var rexp : Label = $FishXP/EXPBar/RequiredEXP
@onready var cexp : Label = $FishXP/EXPBar/CurrentEXP

func _ready() -> void:
  _update_season()
  _update_tod()
  _leveled_up()
  _update_fishxp()
  Globals.season_timer.timeout.connect(_update_season)
  Globals.time_timer.timeout.connect(_update_tod)
  Globals.add_exp.connect(_update_fishxp)
  Globals.level_up.connect(_leveled_up)

func _update_season() -> void:
  season.text = str("Season ", Globals.current_season.capitalize())

func _update_tod() -> void:
  tod.text = str("Time ", Globals.current_time.capitalize())

func _update_fishxp() -> void:
  expbar.value = Globals.fisher_experience
  cexp.text = str(Globals.fisher_experience)

func _leveled_up() -> void:
  lvl.text = str("Level ", Globals.fisher_level)
  expbar.max_value = Globals.fisher_experience_required
  rexp.text = str(Globals.fisher_experience_required)