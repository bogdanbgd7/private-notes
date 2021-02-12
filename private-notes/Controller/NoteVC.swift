//
//  NoteVC.swift
//  private-notes
//
//  Created by Bogdan Ponocko on 10.2.21..
//

import UIKit

class NoteVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView 
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    //MARK: - Table View Delegate Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArrary.count
    }
    
    //cellForRowAt behaves like for-each function. 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as? NoteCell else {return UITableViewCell()}
        let note = notesArrary[indexPath.row]
        cell.configureCell(note: note)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pushNoteFor(indexPath: indexPath)
    }
    
    func pushNoteFor(indexPath: IndexPath){
        guard let noteDetails = storyboard?.instantiateViewController(withIdentifier: "NoteDetailsVC") as? NoteDetailsVC else {return}
        noteDetails.note = notesArrary[indexPath.row]
        noteDetails.index = indexPath.row
        navigationController?.pushViewController(noteDetails, animated: true)
    }


}

