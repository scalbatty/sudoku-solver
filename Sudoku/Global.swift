//
//  Global.swift
//  Sudoku
//
//  Created by Pascal Batty on 17/01/2016.
//  Copyright © 2016 Scalbatty. All rights reserved.
//

import Foundation

func displaySudoku(board:SudokuBoard) {
    for i in 0..<SudokuSize {
        if ((i) % 3 == 0) {
            print(" -----------------------")
        }
        
        let row = board.rows()[i]
        let renderedLine = "| \(row[0].dashed()) \(row[1].dashed()) \(row[2].dashed()) | \(row[3].dashed()) \(row[4].dashed()) \(row[5].dashed()) | \(row[6].dashed()) \(row[7].dashed()) \(row[8].dashed()) |"
        print(renderedLine)
    }
    print(" -----------------------")
}

extension Int {
    func dashed() -> String {
        return self == 0 ? "-" : String(self)
    }
}