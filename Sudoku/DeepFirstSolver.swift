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
        
        var visited =  sourceBoard.filter(hasValue)
        var toVisit = [Cell]()
        
        var sudoku = SudokuBoard(cells: visited)
        
        
        guard sudoku.contains(isEmpty) else { return sudoku }
        
        let firstEmpty = sudoku.emptyCells().first!
        let start = Array(1...9)
            .shuffle()
            .filter({ x in sudoku.isValid(Cell(row: firstEmpty.row, col: firstEmpty.col, val: x))}).first!
        
        toVisit.append(Cell(row: firstEmpty.row, col: firstEmpty.col, val: start))
        
        while (!toVisit.isEmpty) {
            var current = toVisit.popLast()!
            visited.append(current)
            
            sudoku = SudokuBoard(cells: visited)
            guard sudoku.contains(isEmpty) else { return sudoku }
            
            current = sudoku.emptyCells().first!
            
            let neighbours = Array(1...9)
                .shuffle()
                .filter({ x in sudoku.isValid(Cell(row: current.row, col: current.col, val: x))})
                .map({x -> Cell in return Cell(row: current.row, col: current.col, val: x)})
            
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
        return sudoku
    }
    
}