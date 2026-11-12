# EcoPolicy — Economic Policy Optimization Simulator (C++ Engine + Dashboard)

EcoPolicy is a high-performance C++ simulator and optimization engine that models macroeconomic policy interventions across 12 quarters under baseline conditions and macroeconomic stress scenarios.

---

## 🚀 Quick Start on Windows (Your Laptop)

### Option 1: 1-Click Build Script (Recommended)
Simply open PowerShell or Command Prompt and run:
```cmd
build.bat
```
This automatically:
1. Detects your installed C++ compiler (`g++` / MSYS2 / MinGW).
2. Compiles `ecopolicy.exe` (main engine) and `ecopolicy_tests.exe` (test suite).
3. Runs all 18 verification unit tests to ensure everything is operating correctly.

### Option 2: Using VS Code
- **Build**: Press `Ctrl + Shift + B` (runs the default build task).
- **Run / Debug**: Press `F5` (launches `ecopolicy.exe` with interactive or configured args).

### Option 3: Using Make (`mingw32-make` or `make`)
```cmd
mingw32-make
mingw32-make test
mingw32-make run
```

### Option 4: Plain g++ Compiler Command
```cmd
g++ -O2 -Iinclude src/*.cpp -o ecopolicy.exe
```

---

## 💻 Running the C++ Engine

### Interactive Mode:
```cmd
.\ecopolicy.exe
```
(Prompts you to select a goal: 1: Maximize GDP, 2: Minimize Inflation, 3: Reduce Unemployment, 4: Balanced, and budget).

### CLI Flags Mode:
```cmd
.\ecopolicy.exe --goal gdp --budget 30 --top 5 --csv output/history.csv
```
Available flags:
- `--goal <gdp|inflation|unemployment|balanced>` (default: `balanced`)
- `--budget <B_max per quarter>` (default: `30`)
- `--min-budget <minimum spend>` (default: `0`)
- `--step <search step>` (default: `5`)
- `--max-sector <max per sector>` (default: `20`)
- `--top <plans to list>` (default: `5`)
- `--stress-weight <0..1>` (default: `0.5`)
- `--debt-penalty <weight>` (default: `0`)
- `--csv <output path>` (default: `output/history.csv`)
- `--help`

---

## 🌐 Running the Web Frontends

You have **two** frontend options available:

### Option 1: Modern Interactive Web Application (Recommended)
```cmd
run_web.bat
```
*(or `python frontend/server.py`)*
- Sleek dark cyber-finance dashboard (HTML5 + Tailwind CSS + Chart.js + Flask REST API).
- Live interactive parameter sliders & preset strategies.
- 4-grid macroeconomic trajectory charts (GDP, Inflation, Unemployment, Debt).
- Sector budget allocation donut/bar graphs.
- Top ranked policy allocations leaderboard.
- Live raw C++ engine log stream.
- Opens automatically in your default browser at `http://localhost:8080`.

### Option 2: Streamlit Dashboard
```cmd
run_dashboard.bat
```
*(or `streamlit run frontend/app.py`)*
- Clean Streamlit dashboard with interactive widgets and CSV downloads.

---

## 🏛️ Object-Oriented Architecture (OOP)

- **`Policy` (Abstract Base Class)**: Pure virtual interface defining policy cost and impact.
  - **`FiscalPolicy`**: Derived class managing infrastructure, education, and employment interventions.
  - **`SubsidyPolicy`**: Derived class managing targeted consumer/producer subsidies and price relief.
- **`Shock` (Abstract Base Class)**: Polymorphic macroeconomic shocks.
  - **`OilPriceShock`**: Models supply-side cost inflation shocks.
  - **`DemandCollapseShock`**: Models sudden demand collapse and spikes in unemployment.
- **`Economy`**: Encapsulates macroeconomic state (GDP, Inflation, Unemployment, Public Debt).
- **`EconomicModel`**: Computes quarterly quarterly dynamics, tax receipts, deficit, and debt accumulation.
- **`BudgetOptimizer`**: Performs exhaustive grid search under strict budget constraints.
- **`PolicyAnalyzer`**: Multi-objective utility scorer based on specified policy priorities and debt penalties.
- **`SimulationEngine`**: Orchestrates 12-quarter timeline, shocks, and robust multi-scenario evaluations.
- **`ReportGenerator`**: Formats console reporting and outputs CSV time-series logs.
