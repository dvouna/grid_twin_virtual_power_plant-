# SmartGrid-AI: Predictive Resilience & Arbitrage Platform

<<<<<<< HEAD
<pre>
Bash
python src/vpp/intelligence/producer.py
python src/vpp/intelligence/consumer.py
python src/vpp/intelligence/feature_engineering.py
python src/vpp/intelligence/xgboost.py
</pre>

Overview
SmartGrid-AI is an advanced energy management system that bridges the gap between raw grid data and actionable intelligence. It combines real-time monitoring, predictive analytics, and autonomous control to maintain grid stability while maximizing economic efficiency.
=======
[![CI Build](https://img.shields.io/github/actions/workflow/status/dvouna/grid_twin_virtual_power_plant-/ci.yml?label=CI%20Build)](https://github.com/dvouna/grid_twin_virtual_power_plant-/actions)
[![Unit Tests](https://img.shields.io/github/actions/workflow/status/dvouna/grid_twin_virtual_power_plant-/tests.yml?label=Unit%20Tests)](https://github.com/dvouna/grid_twin_virtual_power_plant-/actions)
[![Codecov](https://img.shields.io/codecov/c/github/dvouna/grid_twin_virtual_power_plant-)](https://codecov.io/gh/dvouna/grid_twin_virtual_power_plant-)
[![Python Version](https://img.shields.io/badge/python-3.8%2B-blue)](https://www.python.org/)
[![Docker Ready](https://img.shields.io/badge/docker-ready-0db7ed)](https://www.docker.com/)
[![Status](https://img.shields.io/badge/status-active-success)](#)
[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-orange)](#)
[![License: MIT](https://img.shields.io/badge/license-MIT-green)](https://opensource.org/licenses/MIT)
>>>>>>> d99191d7c84d63b18e83e8c198f9e8e0202cfa3e

SmartGrid‑AI is an intelligent virtual power plant (VPP) platform that transforms raw grid telemetry into real‑time operational decisions. It blends streaming ingestion, stateful feature engineering, predictive modeling, and autonomous control agents to stabilize the grid and optimize economic outcomes.

## 🌐 A. Core Capabilities
#### 1. Real-Time Gride Intelligence 
- Continuous ingestion of Net Load, Solar Generation, and related telemetry
- Stateful feature engineering with temporal lags, rolling statistics, and interaction terms
- Predictive modeling to detect instability, ramps, and arbitrage opportunities

#### 2. MCP-Driven Decision Engine ("The Brain")
Hosted on an MCP server, the SmartGrid‑AI agent can:
- Forecast short‑term load changes
- Trigger resilience actions (e.g., dispatch peakers or batteries)
- Execute arbitrage strategies (buy low, sell high)
- Reason over grid state and call tools autonomously

#### 3. Autonomous Controls Agents 
- ***Grid Response Actor***: Detects instability events and dispatches assets to maintain frequency and avoid penalties.
- ***Arbitrage Trader***: Executes charge/discharge cycles based on predicted price differentials.

<<<<<<< HEAD
Key Capabilities:

Predictive Analysis: Forecasts grid instability (sudden ramps or drops).
Resilience Control: Dispatches Gas Peaker Plants or Battery Storage to counteract predicted changes.
Arbitrage Trading: Monitors price differentials to buy low (during surplus) and sell high (during shortage).
3. Autonomous Agents
Grid Response Actor: Monitors the grid for "Instability Events" (rapid changes in load). If detected, it automatically dispatches generation assets to stabilize the grid and prevent penalties.
Arbitrage Trader: A financial agent that uses the predictive model to execute "Buy Low, Sell High" strategies with the battery storage system.
Technical Stack
Data Layer: InfluxDB (Time-Series Database)
AI/ML: Python (Scikit-learn, Pandas)
Control Logic: Python Agents
Communication: MCP (Micro-Computer Protocol)
Getting Started
Prerequisites
Ensure you have Python 3.8+ installed.

Installation
Clone the repository:

Bash
git clone <repository-url>
cd atl_pr
Install dependencies:

Bash
pip install -r requirements.txt
Running the System
Start the InfluxDB server (if not already running).

Start the MCP Server (The Brain):

Bash
python src/vpp/mcp/mcp_server.py
Start the Grid Response Actor:

Bash
python src/vpp/agents/grid_response_actor.py
Start the Arbitrage Trader:

Bash
python src/vpp/agents/arbitrage_trader.py
Verification
Check the console output for logs from the agents.

Verify data is being written to InfluxDB by querying the database.

Architecture Diagram
[Grid Data] -> [InfluxDB] -> [Feature Store] -> [MCP Agent] -> [Response/Trading Agents] -> [Grid Output]

## System Architecture

[Grid Data] -> [InfluxDB] -> [Feature Store] -> [MCP Agent] -> [Response/Trading Agents] -> [Grid Output]
=======
## 🧱 B. System Architecture 
**1. High-Level Flow**
```Code
[Grid Data] 
   → [InfluxDB] 
   → [Feature Store] 
   → [MCP Agent] 
   → [Response & Trading Agents] 
   → [Grid Output]
```
>>>>>>> d99191d7c84d63b18e83e8c198f9e8e0202cfa3e

**2. Detailed Architecture** 
<pre>
graph TD

classDef infra fill:#FFF2CC,stroke:#D6B656,stroke-width:2px;
classDef ai fill:#EAD1DC,stroke:#741B47,stroke-width:2px;

subgraph "Ingestion"
    CSV[Historical Data] --> Producer(Producer.py)
    Producer --> RP((Redpanda Broker)):::infra
end

subgraph "Intelligence"
    RP --> Consumer(Consumer.py)

    subgraph "In-Stream ML"
        Consumer --> FE[Feature Engineering]
        FE --> XGB[XGBoost Model]
    end
end

subgraph "Storage & Viz"
    XGB --> IDB[(InfluxDB)]
    IDB --> Grafana(Grafana Dashboards):::infra
end

subgraph "Control & Agents"
    IDB --> Actor(Grid Actor)
    IDB --> Trader(Arbitrage Trader)
    IDB --> MCP(MCP Server):::ai
    AI[AI Agent] <--> MCP
end
</pre> 

## 🧠 C. Feature Engineering: The Stateful Intelligence Layer 
Real‑time grid data is noisy and insufficient on its own. The platform uses a stateful feature pipeline to transform raw telemetry into a rich predictive feature space. 

### 1. Cyclical Time Encoding 
To preserve the circular nature of time:
<pre>
### 🔄 Cyclical Time Encoding
To ensure the model understands the periodic nature of time, we transform the hourly data using sine and cosine encodings:

$$\text{Hour}_{sin} = \sin\left(\frac{2\pi \cdot \text{Hour}}{24}\right)$$
$$\text{Hour}_{cos} = \cos\left(\frac{2\pi \cdot \text{Hour}}{24}\right)$$
</pre>

### 2. Temporal Logs
A rolling buffer (Python deque) maintains the last 50 observations:
- 𝐿𝑡−1 … 𝐿𝑡−12 capture short‑term momentum
- Enables autoregressive reasoning about ramps and volatility

### 3. Rolling Window Statistics 
Used to smooth transient spikes:
- Rolling mean (baseline trend)
- Rolling standard deviation (local volatility)

### 4. Grid Interaction Features
Captures non‑linear system behavior:
- Renewable Penetration Ratio
- Net Load Gradient
- Combined indicators for critical ramp detection


## C. 🛠 Technical Stack
| Layer | Technology |
| :--- | :--- |
| **Streaming** | Redpanda (Kafka-compatible) |
| **Storage** | InfluxDB (time-series) |
| **AI/ML** | XGBoost, Scikit-Learn, Pandas |
| **Control** | Python Agents |
| **Communication** | MCP (Model Context Protocol) |
| **Visualization** | Grafana |
| **Virtualization** | Docker, Docker Compose |


## D. Getting Started
### 1. Prerequisites
- Python 3.8+
- InfluxDB running locally or remotely

### 2. Installation 
<pre>git clone https://github.com/dvouna/grid_twin_virtual_power_plant-
cd grid_twin_virtual_power_plant-
pip install -r requirements.txt
</pre>

## Running the System
### 1. Start Core Services
<pre># InfluxDB (if not already running)
# MCP Server (The Brain)
python src/vpp/mcp/mcp_server.py
</pre> 

### 2. Run Intelligence Pipeline
<pre>python src/vpp/intelligence/producer.py
python src/vpp/intelligence/consumer.py
python src/vpp/intelligence/feature_engineering.py
python src/vpp/intelligence/xgboost.py
</pre>

<<<<<<< HEAD
Bash
python src/vpp/agents/arbitrage_trader.py
=======
### 3. Verification 
- Check console logs for agent activity
- Query InfluxDB to confirm data ingestion
- View dashboards in Grafana
>>>>>>> d99191d7c84d63b18e83e8c198f9e8e0202cfa3e

```
src/vpp/
│
├── intelligence/
│   ├── producer.py
│   ├── consumer.py
│   ├── feature_engineering.py
│   └── xgboost.py
│
├── agents/
│   ├── grid_response_actor.py
│   └── arbitrage_trader.py
│
└── mcp/
    └── mcp_server.py
```
**Module Responsibilties**
```
Module Purpose 
producer.py	Streams historical or synthetic grid data into Redpanda
consumer.py	Consumes messages, applies feature engineering, triggers model inference
feature_engineering.py	Stateful pipeline: lags, rolling stats, cyclical encodings, interaction terms
xgboost.py	Loads model, performs predictions, writes results to InfluxDB
grid_response_actor.py	Detects instability events, dispatches peakers/batteries
arbitrage_trader.py	Executes buy‑low/sell‑high cycles based on predicted deltas
mcp_server.py	Hosts the SmartGrid‑AI agent and exposes MCP tools
```

### 3. Architecture 
```
[Grid Data]
   → [Redpanda Producer]
   → [Redpanda Broker]
   → [Consumer + Feature Engineering]
   → [XGBoost Prediction]
   → [InfluxDB]
   → [MCP Agent + Control Actors]
   → [Grid Output]
```

```
graph TD

classDef infra fill:#FFF2CC,stroke:#D6B656,stroke-width:2px;
classDef ai fill:#EAD1DC,stroke:#741B47,stroke-width:2px;

subgraph "Ingestion"
    CSV[Historical Data] --> Producer(Producer.py)
    Producer --> RP((Redpanda Broker)):::infra
end

subgraph "Intelligence"
    RP --> Consumer(Consumer.py)

    subgraph "In-Stream ML"
        Consumer --> FE[Feature Engineering Class]
        FE --> XGB[XGBoost Model]
    end
end

subgraph "Storage & Viz"
    XGB --> IDB[(InfluxDB)]
    IDB --> Grafana(Grafana Dashboards):::infra
end

subgraph "Control & Agents"
    IDB --> Actor(Grid Actor)
    IDB --> Trader(Arbitrage Trader)
    IDB --> MCP(MCP Server):::ai
    AI[AI Agent] <--> MCP
end
```


Autonomous resilience and arbitrage agents
python src/vpp/intelligence/producer.py
python src/vpp/intelligence/consumer.py
python src/vpp/intelligence/feature_engineering.py
<<<<<<< HEAD
python src/vpp/intelligence/xgboost.py
=======
python src/vpp/intelligence/xgboost.py   
</pre>
>>>>>>> d99191d7c84d63b18e83e8c198f9e8e0202cfa3e

The system functions as a closed‑loop intelligence layer:
Grid → Ingestion → Feature Store → AI Decision Engine → Control Agents → Grid

<<<<<<< HEAD
python src/vpp/agents/grid_response_actor.py
python src/vpp/agents/arbitrage_trader.py
python src/vpp/mcp/mcp_server.py

## Future Roadmap
=======
## System Architecture 
### High Level Flow 
[Grid Data] 
   → [InfluxDB] 
   → [Feature Store] 
   → [MCP Agent] 
   → [Response & Trading Agents] 
   → [Grid Output]

>>>>>>> d99191d7c84d63b18e83e8c198f9e8e0202cfa3e



<<<<<<< HEAD
Cognitive Ops (RAG): Integrating Retrieval-Augmented Generation to allow the AI agent to cross-reference grid actions with NERC/FERC regulatory PDF manuals.

Tech Stack

- Streaming: Redpanda (Kafka Compatible)
- Storage: InfluxDB (Time-Series Database)
- AI/ML: XGBoost, Scikit-Learn, Pandas, MCP SDK
- Control: Python Agents
- Communication: MCP (Micro-Computer Protocol)
- Virtualization: Docker, Docker Compose, GitHub Actions

🧠 Feature Engineering: The Stateful Intelligence Layer
In a real-time smart grid, raw sensor data is often too "noisy" and "flat" for accurate forecasting. This project utilizes a Stateful Feature Pipeline within the consumer.py script to transform simple telemetry into a high-dimensional feature space.

1. Cyclical Time EncodingsTime is not a linear progression from 0 to 23; it is circular. To prevent the model from seeing "Hour 23" as mathematically distant from "Hour 0," we project time onto a 2D coordinate system using trigonometric transformations:$$Hour_{sin} = \sin\left(\frac{2\pi \cdot Hour}{24}\right)$$$$Hour_{cos} = \cos\left(\frac{2\pi \cdot Hour}{24}\right)$$This ensures the model recognizes that 11:59 PM and 12:01 AM are adjacent, capturing the natural daily rhythm of the grid.

2. Temporal Lags ($t-n$)To capture the "momentum" of the grid, the pipeline maintains an in-memory buffer (using Python's collections.deque) to generate historical lags. These features allow the model to perform Auto-Regressive analysis:$L_{t-1}$ to $L_{t-12}$: Captures immediate short-term trends over the last minute (at a 5s pulse).Significance: These features inform the XGBoost model if the current ramp is accelerating or stabilizing.

3. Rolling Window StatisticsRaw electricity load is prone to transient spikes. We smooth these out using Rolling Statistics calculated over various horizons (e.g., 5-minute and 30-minute windows):Rolling Mean: Captures the moving baseline.Rolling Std Dev: Measures local volatility, signaling the model to "watch out" for unpredictable weather-driven solar shifts.

4. Grid Interaction FeaturesThe grid is a complex system of dependencies. We calculate Interaction Terms to highlight non-linear relationships:Renewable Penetration Ratio: $$\frac{Solar + Wind}{Gross Load}$$Net Load Gradient: The instantaneous rate of change between $t$ and $t-1$.Significance: A high penetration ratio combined with a high gradient is a leading indicator of a Critical Ramp Event.Feature Importance SummaryBy providing these engineered features, the XGBoost model can distinguish between a routine evening ramp and a catastrophic frequency excursion.

%%{init: {'theme': 'base', 'themeVariables': { 'primaryColor': '#007ACC', 'edgeLabelBackground':'#ffffff', 'tertiaryColor': '#E6F3FF'}}}%%
graph TD
    %% Define styles
    classDef storage fill:#D9EAD3,stroke:#274E13,stroke-width:2px;
    classDef infra fill:#FFF2CC,stroke:#D6B656,stroke-width:2px;
    classDef python fill:#E6F3FF,stroke:#007ACC,stroke-width:2px;
    classDef ai fill:#EAD1DC,stroke:#741B47,stroke-width:2px;

    subgraph "Data Ingestion Layer"
        CSV[Historical_Data.csv] -- "Read Row" --> Producer(Producer.py):::python
        Producer -- "Inject Current Timestamp (5s pulse)" --> RP((Redpanda Broker)):::infra
    end

    subgraph "Intelligence & Control Layer (Microservices)"
        RP -- "Sub: grid-stream" --> Consumer(Consumer.py):::python
        RP -- "Sub: grid-stream" --> Actor(Response_Actor.py):::python
        RP -- "Sub: grid-stream" --> Trader(Arbitrage_Trader.py):::python

        subgraph "In-Stream AI"
            Consumer -- "1. Buffer & Feature Engineer" --> FE[Stateful Features]
            FE -- "2. Inference Vector" --> XGB[XGBoost Model.ubj]
            XGB -- "3. Predicted Ramp (MW/min)" --> Consumer
        end
    end

    subgraph "Storage & Visualization Layer"
        Consumer -- "Write: Net Load + Predictions" --> IDB[(InfluxDB)]:::storage
        Actor -- "Write: Battery Actions" --> IDB
        Trader -- "Write: PnL & Trades" --> IDB
        IDB -- "Query: Flux" --> Grafana(Grafana Dashboards):::infra
    end

    subgraph "Agentic Interface Layer (MCP)"
        IDB -.->|"Read Resource (grid://status)"| MCP(MCP_Server.py):::ai
        XGB -.->|"Run Tool (predict_ramp)"| MCP
        Human[Human / AI Agent] <==>|"Natural Language Queries"| MCP
    end

    %% Define arrow styles for clarity
    linkStyle 4,5,6,7 stroke:#007ACC,stroke-width:2px,fill:none;
    linkStyle 11,12,13 stroke:#274E13,stroke-width:2px;
=======
9. Roadmap
  - GCP
  - FDIA detection via predictive residuals
  - RAG‑based compliance reasoning
>>>>>>> d99191d7c84d63b18e83e8c198f9e8e0202cfa3e
