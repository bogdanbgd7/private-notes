//
//  NewNoteVC.swift
//  private-notes
//
//  Created by Bogdan Ponocko on 12.2.21..
//

import UIKit

class NewNoteVC: UIViewController {
    
    //Outlets
    @IBOutlet weak var noteText: UITextView!
    
    //Props
    var note: Note!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func addNoteBtnPressed(_ sender: Any) {
        if noteText.text != "" {
            let text = noteText.text!
            let newNote = Note(message: text, lockedStatus: .unlocked)
            notesArrary.append(newNote)
            
            navigationController?.popViewController(animated: true)
        } else {
            let alert = UIAlertController(title: "Error!", message: "Please enter some text.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok.", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
}
