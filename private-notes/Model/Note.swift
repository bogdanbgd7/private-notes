//
//  Note.swift
//  private-notes
//
//  Created by Bogdan Ponocko on 11.2.21..
//

import Foundation

class Note {
    
    //This property can be read, but cannot be set from the outside
    public private(set) var message : String
    public var lockedStatus : LockStatus
    
    init(message : String, lockedStatus: LockStatus) {
        self.message = message
        self.lockedStatus = lockedStatus
    }
}
