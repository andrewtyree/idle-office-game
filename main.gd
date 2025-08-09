extends Control

# UI References
@onready var money_label = $GameUI/StatsRow/MoneyLabel
@onready var efficiency_label = $GameUI/StatsRow/EfficiencyLabel
@onready var upgrade_btn = $GameUI/StatsRow/UpgradeEfficiencyBtn
@onready var component_option = $GameUI/BuildingRow/ComponentsBox/ComponentOption
@onready var build_btn = $GameUI/BuildingRow/BuildBox/BuildBtn
@onready var build_progress = $GameUI/BuildingRow/BuildBox/BuildProgress
@onready var status_label = $GameUI/InfoRow/StatusLabel

# Game State
var money: float = 1000.0
var efficiency: float = 1.0
var is_building: bool = false

# Component data [cost, base_price, build_time]
var components = [
	[10, 15, 5.0],   # Basic - costs $10, sells for $15, takes 5 seconds
	[25, 40, 8.0],   # Good - costs $25, sells for $40, takes 8 seconds  
	[50, 85, 12.0],  # Great - costs $50, sells for $85, takes 12 seconds
	[100, 180, 18.0], # Premium - costs $100, sells for $180, takes 18 seconds
	[200, 380, 25.0]  # Luxury - costs $200, sells for $380, takes 25 seconds
]

var building_component: int = -1  # Stores which component we're actually building

# Timer for building
var build_timer: Timer

func _ready():
	# Create and setup build timer
	build_timer = Timer.new()
	add_child(build_timer)
	build_timer.one_shot = true
	build_timer.timeout.connect(_on_build_complete)
	
	# Connect buttons
	build_btn.pressed.connect(_on_build_pressed)
	upgrade_btn.pressed.connect(_on_upgrade_pressed)
	
	# Update UI
	update_ui()

func _on_build_pressed():
	if is_building:
		return
	
	var selected = component_option.selected
	var cost = components[selected][0]
	
	# Check if we can afford it
	if money < cost:
		status_label.text = "Not enough money!"
		return
	
	# LOCK IN the component choice
	building_component = selected
	
	
	# Start building
	money -= cost
	is_building = true
	
	# Calculate build time (reduced by efficiency)
	var build_time = components[selected][2] / efficiency
	
	# Start timer and progress bar
	build_timer.start(build_time)
	build_progress.value = 0
	build_progress.max_value = build_time
	
	status_label.text = "Building widget..."
	update_ui()

func _process(delta):
	# Update progress bar during building
	if is_building and build_timer.time_left > 0:
		build_progress.value = build_progress.max_value - build_timer.time_left
	
	# always keep UI updated
	var selected = component_option.selected
	var can_build = not is_building and money >= components[selected][0]
	build_btn.disabled = not can_build

func _on_build_complete():
	# Calculate selling price (base price * sophistication would go here)
	var selected = component_option.selected
	var selling_price = components[selected][1]
	
	# Add profit
	money += selling_price
	is_building = false
	building_component = -1 # reset for next build
	
	status_label.text = "Widget sold for $" + str(selling_price) + "!"
	build_progress.value = 0
	
	update_ui()

func _on_upgrade_pressed():
	var upgrade_cost = 100 * efficiency  # Gets more expensive each time
	
	if money >= upgrade_cost:
		money -= upgrade_cost
		efficiency += 0.2
		status_label.text = "Efficiency upgraded!"
		update_ui()
	else:
		status_label.text = "Can't afford efficiency upgrade!"

func update_ui():
	money_label.text = "Money: $" + str(int(money))
	efficiency_label.text = "Efficiency: " + str("%.1f" % efficiency)
	
	var upgrade_cost = 100 * efficiency
	upgrade_btn.text = "Upgrade Efficiency ($" + str(int(upgrade_cost)) + ")"
	
	# Disable build button if building or broke
	var selected = component_option.selected
	var can_build = not is_building and money >= components[selected][0]
	build_btn.disabled = not can_build
	
	# disable component dropdown while building
	component_option.disabled = is_building
	
	# Update build button text
	if is_building:
		build_btn.text = "Building..."
	else:
		build_btn.text = "Build Widget"
