//
//  SudokuBoard.swift
//  Sudoku
//
//  Created by Pascal Batty on 12/01/2016.
//  Copyright © 2016 Scalbatty. All rights reserved.
//

import Foundation

public class SudokuBoard {
    
    public static let SIZE = 9
    
    private var grid = [[Int]]()
    
    public var difficulty:SudokuDifficulty = .Easy
    
    private func setup() {
        let emptyRow = Array<Int>(count: SudokuBoard.SIZE, repeatedValue: 0)
        grid = Array<[Int]>(count: SudokuBoard.SIZE, repeatedValue: emptyRow)
    }
    
    public init(cells:[Cell]) {
        setup()
        for cell in cells {
            grid[cell.row][cell.col] = cell.val
        }
    }
    
    public init() {
        setup()
    }
    
    public func emptyCells() -> [Cell] {
        return self.filter({ cell in cell.isEmpty })
    }
    
    public func rows() -> [[Int]] {
        return grid
    }
    
    public func columns() -> [[Int]] {
        return grid[0].indices.map { col in
            grid.indices.map { row in
                grid[row][col]
            }
        }
    }

    public func isCellEmpty(row:Int, col:Int) -> Bool {
        let cell = Cell(row:row, col:col, val:self[row, col])
        return cell.isEmpty
    }
    

    public func clone() -> SudokuBoard {
        return SudokuBoard(cells: Array(self))
    }
    
    
    public func isCompleted() -> Bool {
        return self.filter({ cell in !isValid(cell) }).count == 0
    }
    
    public func isValid(cell:Cell) -> Bool {
        return checkRow(cell.row, num: cell.val)
            && checkCol(cell.col, num: cell.val)
            && checkBox(row: cell.row, col: cell.col, num: cell.val)
    }

    private func checkRow(row: Int, num: Int) -> Bool {
        for col in 0..<SudokuBoard.SIZE {
            if (self[row, col] == num) {
                return false
            }
        }
        return true
    }

    private func checkCol(col: Int, num: Int) -> Bool {
        for row in 0..<SudokuBoard.SIZE {
            if (self[row, col] == num) {
                return false
            }
        }
        return true
    }
    
    private func checkBox(row row:Int, col:Int, num:Int) -> Bool {
        let row = (row / 3) * 3
        let col = (col / 3) * 3
        
        for (var r = 0; r < 3; r++) {
            for (var c = 0; c < 3; c++) {
                if (self[row + r, col + c] == num) {
                    return false
                }
            }
        }
        return true
    }

}

extension SudokuBoard {
    
    subscript(row:Int, col:Int) -> Int {
        get {
            return grid[row][col]
        }
        set (value) {
            grid[row][col] = value < 0 || value > 9 ? 0 : value
        }
    }
    
}

extension SudokuBoard : SequenceType {
    public typealias Generator = AnyGenerator<Cell>
    
    public func generate() -> Generator {
        var index = 0
        var cells = [Cell]()
        for row in 0..<SudokuBoard.SIZE {
            for col in 0..<SudokuBoard.SIZE {
                let value = self[row, col] ?? 0
                cells.append(Cell(row:row, col:col, val:value))
            }
        }
        
        return anyGenerator({
            if index < cells.count {
                let cell = cells[index]
                index += 1
                return cell
            }
            return nil
        })
    }
}