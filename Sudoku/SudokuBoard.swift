//
//  SudokuBoard.swift
//  Sudoku
//
//  Created by Pascal Batty on 12/01/2016.
//  Copyright © 2016 Scalbatty. All rights reserved.
//

import Foundation

public let SudokuSize = 9
public let SudokuColumnSize = 3

public class SudokuBoard {
    
    public let SIZE = 9
    public let COLSIZE = 3
    
    private var grid = [[Int]](count: SudokuSize, repeatedValue: [Int](count: SudokuSize, repeatedValue: 0))
    
    public var difficulty:SudokuDifficulty = .Easy
    
    
    public init(cells:[Cell]) {
        for cell in cells {
            grid[cell.row][cell.col] = cell.val
        }
    }
    
    public convenience init() {
        self.init(cells: [])
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
        let previous = self[cell.row, cell.col]
        defer { self[cell.row, cell.col] = previous }
        
        return checkRow(cell.row, num: cell.val)
            && checkCol(cell.col, num: cell.val)
            && checkBox(row: cell.row, col: cell.col, num: cell.val)
    }

    private func checkRow(row: Int, num: Int) -> Bool {
        for col in 0..<SudokuSize {
            if (self[row, col] == num) {
                return false
            }
        }
        return true
    }

    private func checkCol(col: Int, num: Int) -> Bool {
        for row in 0..<SudokuSize {
            if (self[row, col] == num) {
                return false
            }
        }
        return true
    }
    
    private func checkBox(row row:Int, col:Int, num:Int) -> Bool {
        let startRow = (row / SudokuColumnSize) * SudokuColumnSize
        let startCol = (col / SudokuColumnSize) * SudokuColumnSize
        
        for rowOffset in 0..<SudokuColumnSize {
            for colOffset in 0..<SudokuColumnSize {
                if (self[startRow + rowOffset, startCol + colOffset] == num) {
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
        for (rowIndex ,row) in grid.enumerate() {
            for (colIndex, cellValue) in row.enumerate() {
                cells.append(Cell(row:rowIndex, col:colIndex, val:cellValue))
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