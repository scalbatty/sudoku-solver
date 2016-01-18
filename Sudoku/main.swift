//
//  main.swift
//  Sudoku
//
//  Created by Pascal Batty on 12/01/2016.
//  Copyright © 2016 Scalbatty. All rights reserved.
//

import Foundation

while (true) {
    
    print("Would you like to: (Enter 1 or 2) \n1. Generate a Sudoku puzzle \n2. Solve a Sudoku puzzle \n3. Exit")
    
    let x = Int(readLine(stripNewline: true)!)!
    
    if (x == 3) {
        break;
    }
    
    let annealingSolver = SimulatedAnnealingSolver()
    
    if (x == 1) {
        print("Select difficulty level: \n1. Easy \n2. Medium \n3. Hard");
        let y = Int(readLine(stripNewline: true)!)!
        
        let difficulty:SudokuDifficulty
        switch y {
        case 1: difficulty = .Easy
        case 2: difficulty = .Medium
        case 3: difficulty = .Hard
        default: difficulty = .Medium
        }
        
        var sudoku = SudokuGenerator.newSudoku(difficulty)

        displaySudoku(sudoku)
    }
    else { // that is, x == 2 Solve
        print("\nWould you like to: (Enter 1 or 2) \n1. Input a Sudoku puzzle to Solve \n2. Generate a Sudoku puzzle to Solve");
        let y = Int(readLine(stripNewline: true)!)!
        
        
        if (y == 1) {
            var temp = SudokuBoard()
            print("\nEnter rows 1 to 9. Represent blanks as 0s.")
            
            for i in 0..<9 {
                print("Enter row \(i + 1): ");
                if let a:String = readLine(stripNewline: true)! {
                    for j in 0..<9 {
                        temp[i,j] = Int(String(a[a.startIndex.advancedBy(j)]))!
                    }
                }
            }
            
            let solver = DeepFirstSearchSolver()
            let solution = solver.solve(board: temp)
            
            print("Solution Found")
            displaySudoku(solution)
            print("Original puzzle was")
            displaySudoku(temp)
        }
        else { // that is, y==2, ie. Generate puzzle to Solve
            let sudoku = SudokuGenerator.newSudoku(.Easy)
            print("\nWould you like to Solve this puzzle using: (Enter 1 or 2) \n1. Backtracking \n2. Simulated Annealing")
            
            let x1 = Int(readLine(stripNewline: true)!)!
            if (x1 == 1) {
                let solver = DeepFirstSearchSolver()
                let solution = solver.solve(board: sudoku)
            }
            else {
                annealingSolver.simulatedAnnealingSolve(sudoku)
            }
        }
    }
}






























