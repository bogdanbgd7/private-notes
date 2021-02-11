//
//  NoteObjects.swift
//  private-notes
//
//  Created by Bogdan Ponocko on 11.2.21..
//

import Foundation

var firstNote = Note(message: "first message", lockedStatus: .locked)
var secondNote = Note(message: "second message", lockedStatus: .unlocked)
var thirdNote = Note(message: "cats are awesome", lockedStatus: .locked)
var notesArrary : [Note] = [firstNote, secondNote, thirdNote]
