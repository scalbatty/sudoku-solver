//
//  SimulatedAnnealingSolver.swift
//  Sudoku
//
//  Created by Pascal Batty on 13/01/2016.
//  Copyright © 2016 Scalbatty. All rights reserved.
//

import Foundation

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}


public class SimulatedAnnealingSolver {

    var squaresUnchangeable:[Bool] = [Bool]()
    
    public func simulatedAnnealingSolve(board:SudokuBoard) {
        squaresUnchangeable = [Bool](count: 81, repeatedValue:false)
        
        //determine which squares' values cannot be changed
        for (var i = 0; i < 9; i++)
        {
            for (var j = 0; j < 9; j++)
            {
                if (board[i,j] != 0) {
                    squaresUnchangeable[i * 9 + j] = true
                }
            }
        }
        
        //for every 3x3 square, calculate numbers remaining and fill them in randomly
        var numbers = [Int]();
        
        // 0:3 0:3 ----------------------------
        
        numbers = Array(1...9);
        
        for row in 0..<3 {
            for col in 0..<3 {
                if (board[row,col] != 0) {
                    let index = numbers.indexOf(board[row, col])
                    numbers.removeAtIndex(index!)
                }
            }
        }
        
        numbers = numbers.shuffle()
        
        for row in 0..<3 {
            for col in 0..<3 {
                if (board[row, col] == 0) {
                    board[row, col] = numbers.removeFirst()
                }
            }
        }
        
        // 0:3 3:6 ----------------------------
        
        numbers = Array(1...9);
        
        for row in 0..<3 {
            for col in 3..<6 {
                if (board[row,col] != 0) {
                    let index = numbers.indexOf(board[row, col])
                    numbers.removeAtIndex(index!)
                }
            }
        }
        
        numbers = numbers.shuffle()
        
        for row in 0..<3 {
            for col in 3..<6 {
                if (board[row, col] == 0) {
                    board[row, col] = numbers.removeFirst()
                }
            }
        }
        
        // 0:3 6:9 ----------------------------
        
        numbers = Array(1...9);
        
        for row in 0..<3 {
            for col in 6..<9 {
                if (board[row,col] != 0) {
                    let index = numbers.indexOf(board[row, col])
                    numbers.removeAtIndex(index!)
                }
            }
        }
        
        numbers = numbers.shuffle()
        
        for row in 0..<3 {
            for col in 6..<9 {
                if (board[row, col] == 0) {
                    board[row, col] = numbers.removeFirst()
                }
            }
        }
        
        // 3:6 0:3 ----------------------------
        
        numbers = Array(1...9);
        
        for row in 3..<6 {
            for col in 0..<3 {
                if (board[row,col] != 0) {
                    let index = numbers.indexOf(board[row, col])
                    numbers.removeAtIndex(index!)
                }
            }
        }
        
        numbers = numbers.shuffle()
        
        for row in 3..<6 {
            for col in 0..<3 {
                if (board[row, col] == 0) {
                    board[row, col] = numbers.removeFirst()
                }
            }
        }
        
        // 3:6 3:6 ----------------------------
        
        numbers = Array(1...9);
        
        for row in 3..<6 {
            for col in 3..<6 {
                if (board[row,col] != 0) {
                    let index = numbers.indexOf(board[row, col])
                    numbers.removeAtIndex(index!)
                }
            }
        }
        
        numbers = numbers.shuffle()
        
        for row in 3..<6 {
            for col in 3..<6 {
                if (board[row, col] == 0) {
                    board[row, col] = numbers.removeFirst()
                }
            }
        }
        
        // 3:6 6:9 ----------------------------
        
        numbers = Array(1...9);
        
        for row in 3..<6 {
            for col in 6..<9 {
                if (board[row,col] != 0) {
                    let index = numbers.indexOf(board[row, col])
                    numbers.removeAtIndex(index!)
                }
            }
        }
        
        numbers = numbers.shuffle()
        
        for row in 3..<6 {
            for col in 6..<9 {
                if (board[row, col] == 0) {
                    board[row, col] = numbers.removeFirst()
                }
            }
        }
        
        // 6:9 0:3 ----------------------------
        
        numbers = Array(1...9);
        
        for row in 6..<9 {
            for col in 0..<3 {
                if (board[row,col] != 0) {
                    let index = numbers.indexOf(board[row, col])
                    numbers.removeAtIndex(index!)
                }
            }
        }
        
        numbers = numbers.shuffle()
        
        for row in 6..<9 {
            for col in 0..<3 {
                if (board[row, col] == 0) {
                    board[row, col] = numbers.removeFirst()
                }
            }
        }
        
        // 6:9 3:6 ----------------------------
        
        numbers = Array(1...9);
        
        for row in 6..<9 {
            for col in 3..<6 {
                if (board[row,col] != 0) {
                    let index = numbers.indexOf(board[row, col])
                    numbers.removeAtIndex(index!)
                }
            }
        }
        
        numbers = numbers.shuffle()
        
        for row in 6..<9 {
            for col in 3..<6 {
                if (board[row, col] == 0) {
                    board[row, col] = numbers.removeFirst()
                }
            }
        }
        
        // 6:9 6:9 ----------------------------
        
        numbers = Array(1...9);
        
        for row in 6..<9 {
            for col in 6..<9 {
                if (board[row,col] != 0) {
                    let index = numbers.indexOf(board[row, col])
                    numbers.removeAtIndex(index!)
                }
            }
        }
        
        numbers = numbers.shuffle()
        
        for row in 6..<9 {
            for col in 6..<9 {
                if (board[row, col] == 0) {
                    board[row, col] = numbers.removeFirst()
                }
            }
        }
        
        displaySudoku(board)
        
        recurseSolve(board, temperature: 0.8, iteration: 0)
    }
    
    public func numConflicts(board:SudokuBoard) -> Int {
        var num = 0
        var numbers = [Int:Int]()
        
        for i in 0..<9 {
            for j in 0..<9 {
                if let value = numbers[board[i,j]] {
                    numbers[board[i, j]] = value + 1
                }
                else {
                    numbers[board[i, j]] = 1
                }
            }
            
            for j in 1...9 {
                if let value = numbers[j] where value > 1 {
                    num += value - 1
                }
                numbers[j] = -1
            }
        }
        
        for col in 0..<9 {
            for row in 0..<9 {
                if let value = numbers[board[row, col]] {
                    numbers[board[row, col]] = value + 1
                }
                else {
                    numbers[board[row, col]] = 1
                }
            }
            
            for j in 1...9 {
                if let value = numbers[j] where value > 1 {
                    num += value - 1
                }
                numbers[j] = -1
            }
        }
        return num
        
    }
    
    public func recurseSolve(var board:SudokuBoard, temperature:Double, var iteration:Int) -> SudokuBoard {
        let initConflicts = numConflicts(board)
        let square = (random() % 9)
        var xOffset = 0
        var yOffset = 0
        
        if (initConflicts == 0) {
            print("Solution found!")
            return board;
        }
        
        switch(square) {
        case 0:
            xOffset = 0
            yOffset = 0
        case 1:
            xOffset = 0
            yOffset = 3
        case 2:
            xOffset = 0
            yOffset = 6
        case 3:
            xOffset = 3
            yOffset = 0
        case 4:
            xOffset = 3
            yOffset = 3
        case 5:
            xOffset = 3
            yOffset = 6
        case 6:
            xOffset = 6
            yOffset = 0
        case 7:
            xOffset = 6
            yOffset = 3
        case 8:
            xOffset = 6
            yOffset = 6
        default:
            break
        }
        
        var x1:Int
        var y1:Int
        var x2:Int
        var y2:Int
        
        repeat {
            x1 = (random() % 3)
            x2 = (random() % 3)
            y1 = (random() % 3)
            y2 = (random() % 3)
        } while (squaresUnchangeable[(xOffset + x1) * 9 + (yOffset + y1)] || squaresUnchangeable[(xOffset + x2) * 9 + (yOffset + y2)])
        
        print("x1: \(xOffset + x1) y1: \(yOffset + y1)")
        print("x2: \(xOffset + x2) y2: \(yOffset + y2)")
        print("iteration Number: \(iteration)");
        iteration++;
        
        let boardCandidate = board.clone()
        boardCandidate[xOffset + x1, yOffset + y1] = board[xOffset + x2, yOffset + y2]
        boardCandidate[xOffset + x2, yOffset + y2] = board[xOffset + x1, yOffset + y1]
        
        let newConflicts = numConflicts(boardCandidate);
        if (newConflicts < initConflicts) {
            board = boardCandidate.clone();
        }
        else {
            let probability = pow(M_E, Double(initConflicts - newConflicts)) / temperature
            let random = drand48()
            if (random <= probability) {
                board = boardCandidate.clone();
            }
        }
        
        displaySudoku(board)
        
        if (iteration > 4450) {
            return board;
        }
        
        let nextTemperature = updateTemp(temperature);
        return recurseSolve(board, temperature: nextTemperature, iteration: iteration);

    }
    
    func updateTemp(var temperature:Double) -> Double
    {
    temperature *= 0.8; //or .7 or .3
    return temperature;
    }
    
}