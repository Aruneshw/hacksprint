<div align="center">

# Intelligent Battery-Pack Safety and Early-Fault Detection System

<!-- Optional hero asset: add a real image at docs/banner.png or assets/banner.png. -->

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&amp;weight=600&amp;size=24&amp;duration=3000&amp;pause=1000&amp;color=00C2FF&amp;center=true&amp;vCenter=true&amp;width=850&amp;lines=Predicting+battery+failure+days+before+it+happens;Not+another+reactive+BMS;7-sensor+fusion+%2B+3-model+AI+ensemble;HACKSPRINT+2026+%7C+Team+SL_ES_MP_07" alt="Animated project tagline" />

<br />

<img src="https://img.shields.io/badge/TRL-3%20%E2%80%94%20Experimental%20Proof%20of%20Concept-6C5CE7?style=for-the-badge" alt="TRL 3" />
<img src="https://img.shields.io/badge/Domain-Energy%20Security-00B894?style=for-the-badge" alt="Energy Security" />
<img src="https://img.shields.io/badge/License-MIT%20%E2%80%94%20confirm%20before%20release-64748B?style=for-the-badge" alt="MIT to be confirmed" />
<img src="https://img.shields.io/badge/HACKSPRINT-Phase%201%20%E2%80%94%20Ideathon%202026-F59E0B?style=for-the-badge" alt="HACKSPRINT 2026" />

<br />

<img src="https://img.shields.io/badge/ESP32--S3-Embedded%20Control-E7352C?style=for-the-badge&amp;logo=espressif&amp;logoColor=white" alt="ESP32-S3" />
<img src="https://img.shields.io/badge/NXP%20i.MX%208M%20Plus-On--device%20AI-0055A4?style=for-the-badge&amp;logo=nxp&amp;logoColor=white" alt="NXP i.MX 8M Plus" />
<img src="https://img.shields.io/badge/Python-AI%20workflow-3776AB?style=for-the-badge&amp;logo=python&amp;logoColor=white" alt="Python" />
<img src="https://img.shields.io/badge/TensorFlow%20%2F%20PyTorch-Framework%20TBD-FF6F00?style=for-the-badge" alt="Framework TBD" />
<img src="https://img.shields.io/badge/scikit--learn-Workflow%20TBD-F7931E?style=for-the-badge&amp;logo=scikitlearn&amp;logoColor=white" alt="scikit-learn TBD" />

<br />

<a href="https://github.com/Aruneshw/hacksprint/commits"><img src="https://img.shields.io/github/last-commit/Aruneshw/hacksprint?style=for-the-badge&amp;label=Last%20commit" alt="Last commit" /></a>
<a href="https://github.com/Aruneshw/hacksprint"><img src="https://img.shields.io/github/repo-size/Aruneshw/hacksprint?style=for-the-badge&amp;label=Repository%20size" alt="Repository size" /></a>
<a href="https://github.com/Aruneshw/hacksprint/issues"><img src="https://img.shields.io/github/issues/Aruneshw/hacksprint?style=for-the-badge&amp;label=Open%20issues" alt="Open issues" /></a>

<br /><br />

**An AI-powered, sensor-fused Battery Management System add-on that aims to predict Li-ion battery failures days before they happen—not seconds—using one embedded PCB and a three-model AI ensemble.**

</div>

---

## 60-Second Overview

| | Reactive BMS today | This system — design intent |
| --- | --- | --- |
| **Fault timing** | Often detected only after the fault begins, leaving seconds to respond | Detect precursor patterns with a goal of days of warning |
| **Signals** | Primarily reactive operating signals | Seven sensing modalities across electrical, thermal, mechanical, acoustic, and gas behaviour |
| **Accuracy** | ~70% baseline | ≥95% target at TRL 3 — not yet a measured result |
| **Response** | Alarm after detection | Weighted risk score drives GREEN, YELLOW, or RED protection |
| **Operations** | Manual inspection can miss silent degradation | On-board analysis plus cloud status and mobile/email/SMS alerting |

<details>
<summary><strong>Contents</strong></summary>

- [Project Overview](#project-overview)
- [The Problem](#the-problem)
- [System Architecture](#system-architecture)
- [Methodology: The Learning Loop](#methodology-the-learning-loop)
- [AI Decision Logic](#ai-decision-logic)
- [Sensing & Compute](#sensing--compute)
- [Tech Stack](#tech-stack)
- [Impact Snapshot](#impact-snapshot)
- [Applications & Standards](#applications--standards)
- [Repository Structure](#repository-structure)
- [Getting Started](#getting-started)
- [Roadmap](#roadmap)
- [Team](#team)
- [References](#references)
- [License](#license)

</details>

## Project Overview

Battery packs rarely fail without leaving clues. A small voltage imbalance, unusual thermal behaviour, mechanical swelling, vibration, an acoustic signature, or early electrolyte off-gassing can each be a weak signal on its own. This project brings those signals together on one embedded PCB so they can be assessed as a coherent picture of pack health.

At the centre is a three-model ensemble: an LSTM follows degradation over time, a Random Forest classifies known patterns, and anomaly detection searches for what known models have not seen. Their outputs are fused into a real-time risk score for remaining useful life (RUL), failure probability, degradation trend, and anomaly score.

The proposed 36-cell prototype is intentionally framed as **TRL 3 — experimental proof of concept**. The ambition is a practical retrofit or OEM safety module for EVs, energy-storage systems, and industrial battery equipment—not a claim that the finished product has already been validated in the field.

<div align="center">
<br>
<img src="battery_safety_assets/intelligent_battery_safety_explainer.gif"
     alt="Animated battery safety explainer"
     width="900">
<br>
<img src="https://img.shields.io/badge/Target%20accuracy-%E2%89%A595%25-00B894?style=flat-square" alt="Target accuracy at least 95 percent" />
<img src="https://img.shields.io/badge/Sensor%20modalities-7-0284C7?style=flat-square" alt="Seven modalities" />
<img src="https://img.shields.io/badge/Prototype%20scope-3%20modules%20%2F%2036%20cells-7C3AED?style=flat-square" alt="36-cell prototype" />
<img src="https://img.shields.io/badge/Hardware%20cost%20target-~%24500%20%2F%20200%20cells-F59E0B?style=flat-square" alt="Cost target" />
</div>

## The Problem

The most dangerous battery event is often already moving too quickly by the time a conventional safety system reacts. The challenge is separating meaningful early degradation signatures from noise without creating a costly, false-alarm-prone system.

- Commercial BMS units are reactive: they generally identify a fault only after it starts, giving operators seconds rather than hours to react.
- Current baseline fault-detection accuracy is approximately 70%.
- Acoustic and gas sensing have research value, but can be costly and prone to false alarms when not combined intelligently.
- Manual inspection is slow, labour-intensive, and can miss silent cell degradation.
- Once thermal runaway begins, it can propagate through a pack within seconds.

```mermaid
flowchart LR
    W[["Aim: identify precursor patterns<br/>with days of warning"]] -. early signals .-> A
    A["Silent degradation"] --> B["Micro-cracking / early off-gassing"]
    B --> C["Thermal runaway onset"]
    C --> D["Pack propagation"]
    D --> E["Failure<br/>⏱ escalation can occur in seconds"]
    classDef warning fill:#E0F2FE,stroke:#0284C7,color:#0C4A6E,stroke-width:2px;
    classDef hazard fill:#FFF7ED,stroke:#EA580C,color:#7C2D12,stroke-width:2px;
    classDef critical fill:#FEE2E2,stroke:#DC2626,color:#7F1D1D,stroke-width:3px;
    class W warning;
    class A,B,C,D hazard;
    class E critical;
```

## System Architecture

```mermaid
flowchart TD
    subgraph SL["Sensing Layer — 7 modalities"]
        V["Per-cell voltage<br/>0–5 V"]
        I["Hall current<br/>0–1000 A"]
        T["NTC temperature<br/>−40 °C to 85 °C"]
        S["4-channel strain / bridge<br/>Swelling & deformation"]
        X["3-axis accelerometer<br/>Vibration"]
        M["Acoustic microphone<br/>Micro-crack / venting"]
        G["Gas sensor<br/>Early off-gassing"]
    end
    subgraph SP["Signal Path"]
        SC["Signal conditioning<br/>& isolation"] --> ADC["Multiplexed ADC"]
    end
    subgraph CP["Compute"]
        MCU["ESP32-S3 BMS control unit<br/>Acquisition • timestamping • calibration<br/>Safety state machine"]
        NPU["NXP i.MX 8M Plus<br/>Quad Cortex-A53 + 4-TOPS NPU<br/>On-board inference"]
    end
    subgraph AI["AI Ensemble"]
        LSTM["LSTM<br/>Time-series trend"] & RF["Random Forest<br/>Pattern classification"] & AD["Anomaly detection<br/>Novel-fault search"]
        F["Weighted fusion"] --> R["Risk score + RUL<br/>Failure probability • trend • anomaly score"]
    end
    subgraph DR["Decision & Response"]
        DE{"GREEN / YELLOW / RED<br/>Decision engine"} --> PH["Fuse • breaker • contactor<br/>Cooling • fire suppression"]
    end
    subgraph VO["Visibility"]
        CD["Cloud dashboard<br/>SOC • SOH • V • I • T • status"] & AL["Mobile • email • SMS alerts"] & DL["Data logging<br/>Weekly retraining feedback"]
    end
    V & I & T & S & X & M & G --> SC
    ADC --> MCU
    MCU <--> NPU
    NPU --> LSTM & RF & AD
    LSTM & RF & AD --> F
    R --> DE & CD & DL
    DE --> AL
    DL -. labelled outcomes .-> NPU
    classDef sensing fill:#E0F2FE,stroke:#0284C7,color:#0C4A6E,stroke-width:1.5px;
    classDef signal fill:#ECFDF5,stroke:#059669,color:#064E3B,stroke-width:1.5px;
    classDef compute fill:#EDE9FE,stroke:#7C3AED,color:#4C1D95,stroke-width:2px;
    classDef ai fill:#F3E8FF,stroke:#9333EA,color:#581C87,stroke-width:1.5px;
    classDef decision fill:#FFF7ED,stroke:#F59E0B,color:#78350F,stroke-width:2px;
    classDef protection fill:#FEE2E2,stroke:#DC2626,color:#7F1D1D,stroke-width:2px;
    classDef output fill:#DCFCE7,stroke:#16A34A,color:#14532D,stroke-width:1.5px;
    class V,I,T,S,X,M,G sensing;
    class SC,ADC signal;
    class MCU,NPU compute;
    class LSTM,RF,AD,F,R ai;
    class DE decision;
    class PH protection;
    class CD,AL,DL output;
```

**Data flow in plain English:** sense → condition → analyse → score → protect → learn. Fast acquisition and safety control stay close to the pack while the AI processor builds an operator-facing risk picture.

## Methodology: The Learning Loop

```mermaid
flowchart LR
    A["01<br/>Data Acquisition"] --> B["02<br/>Feature Extraction"] --> C["03<br/>AI / ML Analysis"] --> D["04<br/>Decision & Action"] --> E["05<br/>Feedback & Learning"]
    E -->|Labelled outcomes + weekly retraining| A
    classDef stage fill:#E0F2FE,stroke:#0284C7,color:#0C4A6E,stroke-width:2px;
    classDef analyse fill:#F3E8FF,stroke:#9333EA,color:#581C87,stroke-width:2px;
    classDef action fill:#FFF7ED,stroke:#F59E0B,color:#78350F,stroke-width:2px;
    classDef learn fill:#DCFCE7,stroke:#16A34A,color:#14532D,stroke-width:2px;
    class A,B stage;
    class C analyse;
    class D action;
    class E learn;
```

<details><summary><strong>01 — Data Acquisition</strong></summary>
All seven sensor signals are sampled by cell or module as applicable, then filtered and scaled before analysis.
</details>

<details><summary><strong>02 — Feature Extraction</strong></summary>
Features include cell imbalance, voltage-drop rate, SOC, SOH, and indicators relevant to RUL.
</details>

<details><summary><strong>03 — AI / ML Analysis</strong></summary>
The LSTM models time-series degradation, Random Forest classifies patterns, and anomaly detection searches for unfamiliar behaviour before weighted fusion.
</details>

<details><summary><strong>04 — Decision & Action</strong></summary>
The decision engine maps risk to GREEN, YELLOW, or RED actions, scaling from normal operation to shutdown and isolation.
</details>

<details><summary><strong>05 — Feedback & Learning</strong></summary>
Field and lab fault-injection outcomes (overcharge, over-discharge, and thermal abuse) are labelled for planned weekly retraining. NASA Li-ion and CALCE data support the training approach.
</details>

## AI Decision Logic

```mermaid
stateDiagram-v2
    [*] --> GREEN
    GREEN: GREEN | 0.0–0.3<br/>Normal operation
    YELLOW: YELLOW | 0.3–0.7<br/>Reduced rate + active cooling
    RED: RED | 0.7–1.0<br/>Shutdown + isolation + suppression
    GREEN --> YELLOW: risk rises above 0.3
    YELLOW --> RED: risk rises above 0.7
    YELLOW --> GREEN: risk returns to GREEN range
    RED --> GREEN: verified safe recovery
```

| State | Risk score | Automatic action |
| --- | --- | --- |
| 🟢 **GREEN** | 0.0–0.3 | Normal operation. |
| 🟡 **YELLOW** | 0.3–0.7 | Reduce charge/discharge rate and activate cooling. |
| 🔴 **RED** | 0.7–1.0 | Immediate shutdown, isolation, and fire-suppression response. |

> RED-to-GREEN represents recovery only after the system has been verified safe; it is not an automatic bypass of a critical event.

## Sensing & Compute

<details>
<summary><strong>Full sensor specification</strong></summary>

| Sensor | Contribution | Range / implementation |
| --- | --- | --- |
| Per-cell voltage | Cell health and imbalance | 0–5 V |
| Hall-effect current | Pack-level draw | 0–1000 A |
| NTC temperature | Per-module thermal monitoring | −40 °C to 85 °C |
| 4-channel strain / bridge | Swelling and deformation | 4 channels |
| 3-axis vibration accelerometer | Structural anomaly detection | 3 axes |
| Acoustic microphone | Micro-crack and venting sound | Single channel |
| Gas sensor | Electrolyte off-gassing | Single channel |

</details>

| Layer | Planned responsibility |
| --- | --- |
| **AI processor** | NXP i.MX 8M Plus (Quad Cortex-A53 + 4-TOPS NPU) for on-board inference. |
| **Control MCU** | ESP32-S3 with Wi-Fi/BLE for acquisition, timestamping, calibration, and safety state machine. |
| **Production path** | STM32 upgrade path planned for production-grade determinism. |
| **Communications** | Ethernet, CAN, and LTE. |
| **Power / protection** | 5 V, 3.3 V, 1.8 V rails; main fuse, circuit breaker, and contactor. |

## Tech Stack

<!-- CONFIRM before removing TBD labels: the supplied workspace contains no source code, manifests, or build configuration. -->

| Category | Confirmed or planned platform |
| --- | --- |
| ⚙️ **Hardware** | <img src="https://img.shields.io/badge/NXP-i.MX%208M%20Plus-0055A4?style=for-the-badge&amp;logo=nxp&amp;logoColor=white" alt="NXP" /> <img src="https://img.shields.io/badge/ARM-Cortex--A53-0091BD?style=for-the-badge&amp;logo=arm&amp;logoColor=white" alt="ARM Cortex-A53" /> <img src="https://img.shields.io/badge/ESP32--S3-E7352C?style=for-the-badge&amp;logo=espressif&amp;logoColor=white" alt="ESP32-S3" /> |
| 🧩 **Embedded** | <img src="https://img.shields.io/badge/Wi--Fi%20%2F%20BLE-ESP32--S3-0284C7?style=for-the-badge" alt="Wi-Fi BLE" /> <img src="https://img.shields.io/badge/CAN-Planned-475569?style=for-the-badge" alt="CAN planned" /> <img src="https://img.shields.io/badge/STM32-Upgrade%20path-03234B?style=for-the-badge&amp;logo=stmicroelectronics&amp;logoColor=white" alt="STM32 upgrade path" /> |
| 🧠 **AI / ML** | <img src="https://img.shields.io/badge/LSTM-Time--series-7C3AED?style=for-the-badge" alt="LSTM" /> <img src="https://img.shields.io/badge/Random%20Forest-Classification-7C3AED?style=for-the-badge" alt="Random Forest" /> <img src="https://img.shields.io/badge/Anomaly%20Detection-Outliers-7C3AED?style=for-the-badge" alt="Anomaly detection" /> <img src="https://img.shields.io/badge/Python-Workflow%20planned-3776AB?style=for-the-badge&amp;logo=python&amp;logoColor=white" alt="Python planned" /> |
| ☁️ **Cloud / dashboard** | <img src="https://img.shields.io/badge/Cloud%20dashboard-Planned-16A34A?style=for-the-badge" alt="Cloud dashboard planned" /> <img src="https://img.shields.io/badge/Mobile%20%2F%20Email%20%2F%20SMS-Alerting-16A34A?style=for-the-badge" alt="Alerting" /> <img src="https://img.shields.io/badge/Provider%20%2F%20framework-TBD-64748B?style=for-the-badge" alt="Provider TBD" /> |

## Impact Snapshot

### 🎯 Design targets — not measured results

| Metric | Target |
| --- | --- |
| Fault-detection accuracy | ≥95% (vs. ~70% baseline) |
| Incremental hardware cost | ~$500 per 200-cell pack |
| Battery-fire reduction | Up to 80% |
| Unplanned-downtime reduction | Up to 60% |
| Battery-life extension | 15–25% |
| Payback period | Under 1 month |

```mermaid
xychart-beta
    title "Fault-detection accuracy: baseline vs. design target"
    x-axis ["Reactive BMS baseline", "System target"]
    y-axis "Accuracy (%)" 0 --> 100
    bar [70, 95]
```

The chart communicates the stated baseline and target only; it does **not** represent completed validation.

## Applications & Standards

| Intended applications | Standards alignment |
| --- | --- |
| Electric vehicles (EVs) | AIS-156 (India) |
| Grid-scale Energy Storage Systems (ESS) | IEC 62619 |
| Industrial battery equipment | UL 1973 |
|  | UL 2580 |
|  | BIS requirements, where applicable |

**Core subjects:** Embedded Systems · BMS · AI/ML · IoT · Power Electronics

## Repository Structure

The supplied workspace currently contains only this README; no firmware, model code, hardware files, package manifest, or build configuration is present. This tree reflects the actual workspace rather than inventing folders that do not exist.

```text
.
└── README.md
```

## Getting Started

There are no build or runtime files in the supplied workspace, so it would be inaccurate to publish installation, flashing, training, or dashboard commands. Add this section when the repository contains the corresponding real tooling.

## Roadmap

These are planning-stage estimates to communicate direction at TRL 3, not test evidence or release milestones.

| Phase | Planning signal | Status |
| --- | --- | --- |
| System design & sensor selection | `████████░░` 80% | Architecture defined; subject to prototype review |
| PCB integration | `████░░░░░░` 40% | In development |
| AI ensemble development | `████░░░░░░` 40% | In development |
| 36-cell prototype validation | `██░░░░░░░░` 20% | Planned |
| Field pilot | `░░░░░░░░░░` 0% | Planned after prototype validation |
| Patent filing | `░░░░░░░░░░` 0% | Potential outcome |
| Ensemble RUL publication | `░░░░░░░░░░` 0% | Potential outcome |

**Intended progression:** working 36-cell prototype → market-ready retrofit/OEM safety module → potential patent and publication → Safety-as-a-Service for EV fleets and ESS operators.

## Team

**Team ID:** <code>SL_ES_MP_07</code>    
**Institution:** Bannari Amman Institute of Technology (Autonomous, Affiliated to Anna University, Chennai)

| Name | Role |
| --- | --- |
| Aruneshwaran K | **Team Leader** |
| Harinisri M | Team Member |
| Hemavarthini V B | Team Member |
| Varunraj V K | Team Member |
| Praveen A | Team Member |
| Mukesh S | Team Member |
| Sundar S (EE1908) | Faculty Mentor |

## References

1. Hannan, M. A., Lipu, M. S. H., Hussain, A., and Mohamed, A. “A Review of Lithium-Ion Battery State of Charge Estimation and Management System in Electric Vehicle Applications.” *Renewable and Sustainable Energy Reviews*, vol. 78, 2017.
2. Severson, K. A., et al. “Data-Driven Prediction of Battery Cycle Life Before Capacity Degradation.” *Nature Energy*, vol. 4, 2019.
3. Government of India, Ministry of Road Transport and Highways. *AIS-156: Electric Vehicles Battery Pack Safety Requirements.*
4. UL. *UL 1973: Standard for Batteries for Use in Stationary, Vehicle Auxiliary Power and Light Electric Rail Applications.*
5. IEC. *IEC 62619: Secondary Cells and Batteries Containing Alkaline or Other Non-Acid Electrolytes — Safety Requirements.*

## License

<img src="https://img.shields.io/badge/License-MIT-00B894?style=flat-square" alt="MIT license" />

This README is prepared for an MIT-licensed repository, as requested. A <code>LICENSE</code> file was not present in the supplied workspace—add the official MIT license text and confirm the license choice before publishing or distributing the project.

---

<div align="center">

Built for <strong>HACKSPRINT Phase 1 — Ideathon Hackathon, 2026</strong><br />
at Bannari Amman Institute of Technology

<br />

<img src="https://komarev.com/ghpvc/?username=Aruneshw&amp;repo=hacksprint&amp;label=Repository%20views&amp;color=00C2FF&amp;style=flat" alt="Repository visitor counter" />

<br /><br />

<em>Turning a silent battery hazard into a system that speaks up—days before it matters.</em>

</div>
