//
//  DeepFirstSolver.swift
//  Sudoku
//
//  Created by Pascal Batty on 13/01/2016.
//  Copyright © 2016 Scalbatty. All rights reserved.
//

import Foundation

public protocol SudokuSolver {
    func solve(board sourceBoard: SudokuBoard) -> SudokuBoard
}

public class DeepFirstSearchSolver : SudokuSolver {
    
    public func solve(board sourceBoard: SudokuBoard) -> SudokuBoard {
        var visited = [Cell]()
        var toVisit = [Cell]()
        
        let start = (random() % 10) + 1
        toVisit.append(Cell(row: 0, col: 0, val: start))
        
        while (!toVisit.isEmpty) {
            var current = toVisit.popLast()!
            visited.append(current)
            
            if (current.row == SudokuBoard.SIZE - 1 && current.col == SudokuBoard.SIZE - 1) {
                return SudokuBoard(cells: visited)
            }
            
            current = current.col < SudokuBoard.SIZE - 1
                ? Cell(row: current.row, col: current.col + 1)
                : Cell(row: current.row + 1, col: 0)
            
            let sudoku = SudokuBoard(cells: visited)
            let neighbours = Array(1...9).shuffle().filter({ x in sudoku.isValid(Cell(row: current.row, col: current.col, val: x))}).map({x -> Cell in return Cell(row: current.row, col: current.col, val: x)})
            
            if (neighbours.isEmpty) {
                if (toVisit.isEmpty) {
                    break;
                }
                
                let next = toVisit.last!
                while (!visited.filter({cell in cell.row == next.row && cell.col == next.col}).isEmpty) {
                    visited.popLast()
                }
            }
            else {
                neighbours.forEach({ cell in toVisit.append(cell) })
            }
        }
        return SudokuBoard()
    }
    
}