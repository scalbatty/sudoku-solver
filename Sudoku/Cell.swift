//
//  Cell.swift
//  Sudoku
//
//  Created by Pascal Batty on 12/01/2016.
//  Copyright © 2016 Scalbatty. All rights reserved.
//

import Foundation

public struct Cell : Equatable {
    
    public static let emptyValue = 0
    
    public var row:Int
    public var col:Int
    public var val:Int = emptyValue
    
    public var isEmpty:Bool {
        get {
            return val == Cell.emptyValue
        }
    }
    
    
    init(row: Int, col: Int, val: Int = 0) {
        self.row = row
        self.col = col
        self.val = val
    }
}

public func ==(lhs: Cell, rhs: Cell) -> Bool {
    return lhs.row == rhs.row
        && lhs.col == rhs.col
        && lhs.val == rhs.val
}

extension Cell : Hashable {
    public var hashValue: Int {
        get {
            var hashCode = row
            hashCode = (hashCode * 397) ^ col
            hashCode = (hashCode * 397) ^ val
            return hashCode
        }
    }
}

public func isEmpty(cell:Cell) -> Bool {
    return cell.isEmpty
}

public func hasValue(cell:Cell) -> Bool {
    return !cell.isEmpty
}