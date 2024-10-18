#[starknet::interface]
trait IStonePaperScissors<TContractState> {
    fn play(ref self: TContractState, player1_choice: u8, player2_choice: u8) -> (u8, u128, u128); // (result, player1_score, player2_score)
    fn get_results(ref self: TContractState) -> (u128, u128); // (player1_score, player2_score)
}

#[starknet::contract]
mod StonePaperScissors {
    #[storage]
    struct Storage {
        player1_score: u128,
        player2_score: u128,
        last_result: u8, // Store the result of the last game played
    }

    #[constructor]
    fn constructor(ref self: ContractState) {
        // Initialize scores and last result
        self.player1_score.write(0);
        self.player2_score.write(0);
        self.last_result.write(0); // 0 can signify no game played yet
    }

    #[abi(embed_v0)]
    impl StonePaperScissors of super::IStonePaperScissors<ContractState> {
        fn play(ref self: ContractState, player1_choice: u8, player2_choice: u8) -> (u8, u128, u128) {
            // Choices: 0 = Rock, 1 = Paper, 2 = Scissors
            // Determine the winner
            let result = if player1_choice == player2_choice {
                0 // Draw
            } else if (player1_choice == 0 && player2_choice == 2) || // Rock beats Scissors
                      (player1_choice == 1 && player2_choice == 0) || // Paper beats Rock
                      (player1_choice == 2 && player2_choice == 1) { // Scissors beats Paper
                // Increment player1 score
                let score = self.player1_score.read() + 1;
                self.player1_score.write(score);
                1 // Player 1 wins
            } else {
                // Increment player2 score
                let score = self.player2_score.read() + 1;
                self.player2_score.write(score);
                2 // Player 2 wins
            };

            // Store the last result
            self.last_result.write(result);
            (result, self.player1_score.read(), self.player2_score.read())
        }

        fn get_results(ref self: ContractState) -> (u128, u128) {
            // Return the current scores of both players
            (self.player1_score.read(), self.player2_score.read())
        }
    }
}