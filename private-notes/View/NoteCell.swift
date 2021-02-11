//
//  NoteCell.swift
//  private-notes
//
//  Created by Bogdan Ponocko on 11.2.21..
//

import UIKit

class NoteCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet var noteLabel: UILabel!
    @IBOutlet var lockImage: UIImageView!
    

    func configureCell(note: Note){
        if note.lockedStatus == .locked{
            lockImage.isHidden = false
            noteLabel.text = "you have no power here. unlock it."
        } else {
            lockImage.isHidden = true
            noteLabel.text = note.message
        }
    }
    
}
