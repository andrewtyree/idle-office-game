extends Control

# UI References
@onready var money_label = $MainLayout/GameUI/StatsRow/MoneyLabel
@onready var efficiency_label = $MainLayout/GameUI/StatsRow/EfficiencyLabel
@onready var upgrade_btn = $MainLayout/GameUI/StatsRow/UpgradeEfficiencyBtn
@onready var component_option = $MainLayout/GameUI/BuildingRow/ComponentsBox/ComponentOption
@onready var build_btn = $MainLayout/GameUI/BuildingRow/BuildBox/BuildBtn
@onready var build_progress = $MainLayout/GameUI/BuildingRow/BuildBox/BuildProgress
@onready var status_label = $MainLayout/GameUI/InfoRow/StatusLabel
# UI References for quality panel
@onready var rush_btn = $MainLayout/QualityPanel/QualityButtons/RushBtn
@onready var normal_btn = $MainLayout/QualityPanel/QualityButtons/NormalBtn
@onready var careful_btn = $MainLayout/QualityPanel/QualityButtons/CarefulBtn
@onready var perfect_btn = $MainLayout/QualityPanel/QualityButtons/PerfectBtn

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

# Quality settings [time_multiplier, price_multiplier, display_name]
var quality_settings = [
	[0.5, 0.7, "Rush"],      # 50% time, 70% price
	[1.0, 1.0, "Normal"],    # Base time, base price
	[1.5, 1.25, "Careful"],  # 150% time, 125% price
	[2.0, 1.6, "Perfect"]    # 200% time, 160% price
]

var selected_quality: int = 1  # Default to Normal (index 1)

func _ready():
	# Create and setup build timer
	build_timer = Timer.new()
	add_child(build_timer)
	build_timer.one_shot = true
	build_timer.timeout.connect(_on_build_complete)
	
	# Connect existing buttons
	build_btn.pressed.connect(_on_build_pressed)
	upgrade_btn.pressed.connect(_on_upgrade_pressed)
	
	# Connect quality buttons
	rush_btn.pressed.connect(func(): _on_quality_selected(0))
	normal_btn.pressed.connect(func(): _on_quality_selected(1))
	careful_btn.pressed.connect(func(): _on_quality_selected(2))
	perfect_btn.pressed.connect(func(): _on_quality_selected(3))
	
	# Update UI
	update_ui()

func _on_build_pressed():
	if is_building:
		return
	
	var selected_component = component_option.selected
	var base_cost = components[selected_component][0]
	
	# Check if we can afford it
	if money < base_cost:
		status_label.text = "Not enough money!"
		return
	
	# Start building
	money -= base_cost
	is_building = true
	
	# Calculate build time with quality modifier
	var base_build_time = components[selected_component][2] / efficiency
	var quality_time_multiplier = quality_settings[selected_quality][0]
	var final_build_time = base_build_time * quality_time_multiplier
	
	# Start timer and progress bar
	build_timer.start(final_build_time)
	build_progress.value = 0
	build_progress.max_value = final_build_time
	
	# Show what quality we're building
	var quality_name = quality_settings[selected_quality][2]
	status_label.text = "Building " + quality_name + " quality widget..."
	
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
	# Calculate selling price with quality modifier
	var selected_component = component_option.selected
	var base_price = components[selected_component][1]
	var quality_price_multiplier = quality_settings[selected_quality][1]
	var final_price = int(base_price * quality_price_multiplier)
	
	# Add profit
	money += final_price
	is_building = false
	
	# Show result with quality info
	var quality_name = quality_settings[selected_quality][2]
	status_label.text = quality_name + " widget sold for $" + str(final_price) + "!"
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

func _on_quality_selected(quality_index: int):
	selected_quality = quality_index
	update_quality_buttons()
	update_ui()

func update_quality_buttons():
	# Reset all buttons to normal style
	var quality_buttons = [rush_btn, normal_btn, careful_btn, perfect_btn]
	
	for i in range(quality_buttons.size()):
		if i == selected_quality:
			quality_buttons[i].modulate = Color.GREEN  # Highlight selected
		else:
			quality_buttons[i].modulate = Color.WHITE   # Normal color

func update_ui():
	money_label.text = "Money: $" + str(int(money))
	efficiency_label.text = "Efficiency: " + str("%.1f" % efficiency)
	
	var upgrade_cost = 100 * efficiency
	upgrade_btn.text = "Upgrade Efficiency ($" + str(int(upgrade_cost)) + ")"
	
	# Disable build button if building or broke
	var selected_component = component_option.selected
	var can_build = not is_building and money >= components[selected_component][0]
	build_btn.disabled = not can_build
	
	# Disable dropdown and quality buttons while building
	component_option.disabled = is_building
	rush_btn.disabled = is_building
	normal_btn.disabled = is_building
	careful_btn.disabled = is_building
	perfect_btn.disabled = is_building
	
	# Update build button text
	if is_building:
		build_btn.text = "Building..."
	else:
		build_btn.text = "Build Widget"
	
	# Update quality button highlighting
	update_quality_buttons()
