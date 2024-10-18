# Stone Paper Scissors Smart Contract

## Overview
The Stone Paper Scissors smart contract is a digital implementation of the classic hand game, allowing two players to compete against each other in a transparent and fair environment. Built on the StarkNet blockchain, this contract ensures that all game outcomes are verifiable and secure.

## Features
- **Classic Gameplay:** Players choose between Rock, Paper, or Scissors, with results determined by traditional game rules.
- **Score Tracking:** The contract keeps track of the total wins for each player, allowing for ongoing competitions.
- **Transparency:** All game results and scores are recorded on the blockchain, ensuring trust and fairness.

## How It Works

### Choices
- Each player submits their choice represented by an integer:
  - **0**: Rock
  - **1**: Paper
  - **2**: Scissors

### Game Logic
- The contract determines the outcome based on player choices:
  - If both players choose the same option, it results in a draw.
  - Rock beats Scissors, Scissors beat Paper, and Paper beats Rock.
- The winning player's score is incremented.

### Functions
- `play(player1_choice: u8, player2_choice: u8) -> (u8, u128, u128)`: Executes a game round, returning the result and current scores.
- `get_results() -> (u128, u128)`: Retrieves the current scores for both players.

## Setup and Deployment

### Prerequisites
- Ensure you have the following installed:
  - [StarkNet CLI](https://starknet.io/docs/getting_started/)
  - [Rust](https://www.rust-lang.org/tools/install)
  
### Building the Contract
1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd <repository-directory>
cargo build --release
starknet-compile <path-to-your-contract> --output <output-path>
# Example invocation
result, player1_score, player2_score = contract.play(0, 1)  # Player 1 chooses Rock, Player 2 chooses Paper
