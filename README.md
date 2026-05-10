# 🎲 <span style="color:red">LFSR-Project</span>

***An academic verification project using Verilog, SystemVerilog, and UVM***  

Welcome to the **<span style="color:red">LFSIR-Project</span>**! This project demonstrates a **full Linear Feedback Shift Register (LFSR) verification environment** 🛠️, showcasing **UVM best practices** and modular verification design. Perfect for **academic learning** or hands-on **verification practice**! 🎓💻

---

## ✨ <span style="color:red">Features</span>

- **Verilog LFSR Module** 🖥️  
  Implements a **32-bit LFSR** with selectable polynomials and customizable seed values.  

- **UVM Testbench** 🚀  
  Structured **UVM components**:
  - **Driver**: Sends transactions to the LFSR module 🔄  
  - **Sequencer**: Generates randomized sequences 🎲  
  - **Monitor**: Observes outputs and collects transactions 👀  
  - **Scoreboard**: Compares **expected vs actual outputs** ✅  
  - **Agent**: Encapsulates driver, monitor, and sequencer 🧩  
  - **Environment**: Combines agents and scoreboard for complete verification 🌐  

- **Randomized Verification** 🎰  
  - Random **seed values** and **polynomial selection** for robust testing.  

- **Data Validation & Reporting** 📝  
  - Logs detailed **match/mismatch information**  
  - Tracks **transaction history** for debugging and analysis 🔍  

---

## 📂 <span style="color:red">Project Structure</span>
 - **LFSR_if.sv**: // Interface defining LFSR signals
 - **LFSR_seq_item.sv**: // Sequence item class for transactions
 - **LFSR_sequencer.sv**: // UVM sequencer
 - **LFSR_sequence.sv**: // Sequence generation
 - **LFSR_seq_lib.sv**: // Sequence library
 - **LFSR_monitor.sv**: // Monitor for capturing signals
 - **LFSR_driver.sv**: // Driver for sending transactions
 - **LFSR_scoreboard.sv**: // Scoreboard to check results
 - **LFSR_agent.sv**: // Agent combining driver, monitor, sequencer
 - **LFSR_env.sv**: // Environment wrapping agents and scoreboard
 - **LFSR_test.sv**: // Top-level UVM test

   Each component is **modular**, making it easy to **extend or reuse** in other projects. 🔧

---

## 💡 <span style="color:red">Notes & Tips</span>
**Seed Loading:** Randomized for robust verification 🎲
**Polynomials:** Selectable via 3-bit polynomial_select (0–3) 🔢
**Data Valid Signals:** Ensures correct timing and transaction validation ⏱️
Designed as an **academic project,** ideal for learning UVM methodology 🎓
Compatible with any **SystemVerilog/UVM** simulator 💻

---

## 🧩 <span style="color:red">Learning Outcomes</span>
By exploring this project, I learned:
- Building a **modular UVM testbench** from scratch 🛠️
- Structuring **agent, environment, and scoreboard** architecture 🧩
- Generating **randomized sequences and transactions** 🎲
- Performing **expected vs actual verification** ✅
- Working with **waveforms and simulation logs** 🌊

---

## 🤖 <span style="color:red">Final Thoughts</span>
All done!! ✅  
This project proves that **UVM verification** can be fun 🎲🛠️. 
Remember: in the world of verification, **every mismatch is just another mystery to solve** 🔍✨
