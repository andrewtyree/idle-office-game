# Idle Office Management Game

An incremental office management game built in Godot 4.4.1 where players build widgets, hire employees, and grow from a garage operation to a corporate empire.

## 🎮 Current Game Features

### Core Widget Building System ✅
- **Component Selection**: Choose from 5 quality levels (Basic to Luxury)
- **Build Process**: Real-time progress bars with efficiency-based timing
- **Economics**: Material costs, selling prices, and profit calculations
- **Player Competencies**: Efficiency upgrades that reduce build times

### Speed vs Quality System ✅
- **Strategic Building Choices**: 4 quality modes for each widget
  - 🏃 **Rush**: 50% time, 70% price (quick cash flow)
  - ⚡ **Normal**: Base time and price (balanced approach)
  - 🎯 **Careful**: 150% time, 125% price (quality focus)
  - 💎 **Perfect**: 200% time, 160% price (maximum profit)
- **Risk/Reward Balance**: Trade build time for selling price
- **Visual Feedback**: Selected quality highlighted, disabled during building

### Basic Economics ✅
- **Money Management**: Track earnings and expenses
- **Component Costs**: Material costs vary by quality level
- **Upgrade System**: Efficiency improvements with escalating costs
- **Exploit Prevention**: UI controls disabled during building

## 🗺️ Development Roadmap

### ✅ Phase 1: Core Foundation (COMPLETED)
- [x] Solo widget building with basic economics
- [x] Player competencies (efficiency system)
- [x] Basic UI and progress tracking
- [x] Speed vs quality strategic choices

### 🔄 Phase 2: First Employee System (IN PROGRESS)
**Goal**: Hire and manage your first employee
- [ ] Employee hiring with random stats and needs
- [ ] Employee satisfaction affecting productivity
- [ ] Dual production (player + employee building simultaneously)
- [ ] Enhanced economics with salary costs

### 📋 Phase 3: Business Loan & Pressure (PLANNED)
**Goal**: Add core tension with debt management
- [ ] Starting business loan with compound interest
- [ ] Weekly payment schedule (real-time)
- [ ] Enhanced offline calculation system
- [ ] Supplier system for component unlocks

### 📱 Phase 4: Mobile Optimization (PLANNED)
**Goal**: Make it properly playable on mobile
- [ ] Touch-friendly UI with responsive layouts
- [ ] Performance optimization for mobile devices
- [ ] Ad integration preparation

### 🎯 Phase 5: Polish & Balance (PLANNED)
**Goal**: Refine gameplay and prepare for testing
- [ ] Gameplay balance tuning
- [ ] Save/load system implementation
- [ ] Quality of life improvements

### ⭐ Phase 6: First Prestige System (PLANNED)
**Goal**: Add the garage → warehouse transition
- [ ] Prestige unlock conditions
- [ ] Reset mechanics with permanent bonuses
- [ ] Expanded employee capacity

## 🚀 How to Run

1. **Install Godot 4.4.1** from [godotengine.org](https://godotengine.org/download)
2. **Clone this repository**: `git clone https://github.com/andrewtyree/idle-office-game.git`
3. **Open project in Godot**: Import the project folder
4. **Run the game**: Press F5 or click the play button
5. **Main scene**: Ensure `Main.tscn` is set as the main scene

## 🎯 Current Game Loop

1. **Select Components**: Choose quality level for your widget parts
2. **Choose Build Quality**: Rush for quick cash or Perfect for maximum profit
3. **Build Widget**: Watch the progress bar and wait for completion
4. **Earn Money**: Sell completed widgets for profit
5. **Upgrade Efficiency**: Reduce build times with earned money
6. **Repeat & Optimize**: Find the best strategy for your playstyle

## 🛠️ Technical Details

- **Engine**: Godot 4.4.1
- **Language**: GDScript
- **Platform**: Desktop (mobile optimization planned)
- **Version Control**: Git with GitHub
- **Architecture**: Scene-based with modular scripts

## 📈 Game Balance

### Component Tiers
| Quality | Cost | Sell Price | Build Time |
|---------|------|------------|------------|
| Basic   | $10  | $15        | 5 seconds  |
| Good    | $25  | $40        | 8 seconds  |
| Great   | $50  | $85        | 12 seconds |
| Premium | $100 | $180       | 18 seconds |
| Luxury  | $200 | $380       | 25 seconds |

### Quality Modifiers
| Mode     | Time Multiplier | Price Multiplier |
|----------|----------------|------------------|
| Rush     | 0.5x           | 0.7x             |
| Normal   | 1.0x           | 1.0x             |
| Careful  | 1.5x           | 1.25x            |
| Perfect  | 2.0x           | 1.6x             |

## 🤝 Contributing

This is a learning project following an incremental development approach. Each phase builds upon the previous foundation, focusing on solid core mechanics before adding complexity.

## 📝 Development Notes

- **Design Philosophy**: Simple mechanics with strategic depth
- **Mobile-First**: UI designed for eventual mobile deployment
- **Incremental Complexity**: Each phase adds new systems without breaking existing ones
- **Player Agency**: Meaningful choices at every step of the game loop

---

*Ready to build your widget empire? Start in the garage and work your way up to corporate success!*
