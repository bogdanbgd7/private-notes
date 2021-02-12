//
//  NoteDetailsVC.swift
//  private-notes
//
//  Created by Bogdan Ponocko on 12.2.21..
//

import UIKit

class NoteDetailsVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var lockBtn: UIButton!
    @IBOutlet weak var lockImg: UIImageView!
    
    //MARK: - Props
    var note: Note! //lockStatus enabled
    var index: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load message for each note
        textView.text = note.message
        
    }
    
    @IBAction func lockBtnPressed(_ sender: Any) {
        notesArrary[index].lockedStatus = .locked
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - lockStatus helper functions
    
    func isNoteLocked(_ lockStatus: LockStatus) -> Bool {
        if lockStatus == .locked {
            return true
        } else {
            return false
        }
    }
    
    func lockStatusSwitcher(_ lockStatus: LockStatus) -> LockStatus {
        if lockStatus == .locked {
            return .unlocked
        } else {
            return .locked
        }
    }

}
