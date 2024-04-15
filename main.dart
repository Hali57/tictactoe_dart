// This is a tic tac toe game
import "dart:io";
// Define the number of slots on the board. Which will be a multidimensional one i.e 3by 3 matrix
List<List<String>> slots = List.generate(3, (_) => List.generate(3, (_) => ' '));



// create the game board
void printBoard(List<List<String>> board) {
  for (int i = 0; i < board.length; i++) {
    // Print horizontal line
    print('---+---+---');

    // Print row content
    print(' ${board[i][0]} | ${board[i][1]} | ${board[i][2]} ');
  }

  // Print horizontal line after the last row
  print('---+---+---');
}
//create the checkWinner function
bool checkWin(List<List<String>> board, String player) {
  // Check rows
  for (int i = 0; i < 3; i++) {
    if (board[i][0] == player && board[i][1] == player && board[i][2] == player) {
      return true;
    }
  }

  // Check columns
  for (int i = 0; i < 3; i++) {
    if (board[0][i] == player && board[1][i] == player && board[2][i] == player) {
      return true;
    }
  }

  // Check diagonals
  if (board[0][0] == player && board[1][1] == player && board[2][2] == player) {
    return true;
  }
  if (board[0][2] == player && board[1][1] == player && board[2][0] == player) {
    return true;
  }

  return false;
}
// create a playAgain function
void playAgain(){
   // ask if the user wants to play again
      stdout.write("Do you want to play again? (y/n):  ");
      String? res = stdin.readLineSync();
      if(res?.toLowerCase() == "y"){
        startGame();
      }
      return;
}
// create the game function
void startGame(){
    
 try {
  bool player1Turn = true;
  bool gameOver = false;
  print("***TIC TAC TOE***");
  print('Welcome to the game!\n');

  while (!gameOver) {
    printBoard(slots);
       // define current player
    String currentPlayer = player1Turn ? 'X' : 'O';

    print('\nPlayer ${currentPlayer}, enter your move (Pick a number between 1-9:');

    // Read player's move from the console
    String? input = stdin.readLineSync();
    int num = int.parse(input!);
    
    // define rows and columns
    int row =0;
    int col= 0;
    //validate the input
    if(num != 0 && num >= 1 && num<=9){
       row = (num-1) ~/ slots.length;
       col = (num-1)% slots.length;
    }

    // Check if the chosen slot is already occupied
    if (slots[row][col] != ' ') {
      print('Slot is already occupied! Please choose another slot.');
      continue;
    }
    // Make the move
    slots[row][col] = currentPlayer;

    // Check for win
    if (checkWin(slots, currentPlayer)) {
      printBoard(slots);

      print('\nPlayer ${currentPlayer} wins!');

      playAgain();

      gameOver = true;

    } else if (!slots.any((row) => row.any((cell) => cell == ' '))) {
      // Check for draw
      printBoard(slots);

      print('\nThe game is a draw!');
      playAgain();
     
      gameOver = true;
    } else {
      // Switch player turn
      player1Turn = !player1Turn;
    }
}
 } catch (e) {
  print("Please input a number between 1-9. \n");
  startGame(); 
 }
   
}
void main(){
  startGame();
}