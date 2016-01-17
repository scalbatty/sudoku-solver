//
//  SudokuGenerator.swift
//  Sudoku
//
//  Created by Pascal Batty on 13/01/2016.
//  Copyright © 2016 Scalbatty. All rights reserved.
//

import Foundation

public class SudokuGenerator {
    public static var solverGenerator:SudokuSolver!
    
    public static func newSudoku(difficulty:SudokuDifficulty, solverGenerator:SudokuSolver? = nil) -> SudokuBoard {
        SudokuGenerator.solverGenerator = solverGenerator ?? DeepFirstSearchSolver()
        
        let blankBoard = SudokuBoard();
        blankBoard.difficulty = difficulty
        

        return SudokuGenerator.solverGenerator.solve(board: blankBoard).createBlankCells();
    }
    
}



extension SudokuBoard {
    public func createBlankCells() -> SudokuBoard {
        let clone = self.clone()
        
        let cellToClean = self.difficulty.rawValue * 5
        
        while(clone.emptyCells().count < cellToClean) {
            let row = (random() % 9)
            let col = (random() % 9)
            
            guard !clone.isCellEmpty(row, col: col) else {
                continue
            }
            
            let oldVal = clone[row, col]
            clone[row, col] = Cell.emptyValue
            
            let possible = Array(1...9).filter({[clone] x in clone.isValid(Cell(row:row, col:col, val:x))})

            if (possible.count != 1) {
                clone[row, col] = oldVal
            }
        }
        
        return clone
    }
}