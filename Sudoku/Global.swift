//
//  Global.swift
//  Sudoku
//
//  Created by Pascal Batty on 17/01/2016.
//  Copyright © 2016 Scalbatty. All rights reserved.
//

import Foundation

func displaySudoku(board:SudokuBoard) {
    for i in 0..<SudokuBoard.SIZE {
        if ((i) % 3 == 0) {
            print(" -----------------------")
        }
        
        let row = board.rows()[i]
        let renderedLine = "| \(row[0]) \(row[1]) \(row[2]) | \(row[3]) \(row[4]) \(row[5]) | \(row[6]) \(row[7]) \(row[8]) |"
        print(renderedLine)
    }
    print(" -----------------------")
}