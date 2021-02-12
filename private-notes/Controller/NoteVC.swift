//
//  NoteVC.swift
//  private-notes
//
//  Created by Bogdan Ponocko on 10.2.21..
//

import UIKit
import LocalAuthentication

class NoteVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView 
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
        //pushNoteFor(indexPath: indexPath)
        if notesArrary[indexPath.row].lockedStatus == .locked {
            //require biometrics
            authWithBiometrics { (successAuth) in
                if successAuth{
                    let lockStatus = notesArrary[indexPath.row].lockedStatus
                    notesArrary[indexPath.row].lockedStatus = self.lockStatusSwitcher(lockStatus)
                    DispatchQueue.main.async {
                        self.pushNoteFor(indexPath: indexPath)
                    }
                }
            }
        } else {
            pushNoteFor(indexPath: indexPath)
        }
    }
    
    func pushNoteFor(indexPath: IndexPath){
        guard let noteDetails = storyboard?.instantiateViewController(withIdentifier: "NoteDetailsVC") as? NoteDetailsVC else {return}
        noteDetails.note = notesArrary[indexPath.row]
        noteDetails.index = indexPath.row
        navigationController?.pushViewController(noteDetails, animated: true)
    }
    
    //MARK: - FaceID using LocalAuthentication
    func authWithBiometrics(completion: @escaping(Bool) -> Void){
        let context = LAContext()
        let reason = "Unlock note with FaceID/TouchID"
        var authError: NSError?
        
        //iOS 8.0< doesn't support Biometrics authentication
        if #available(ios 8.0, macOS 10.12.1, *){
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError){
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { (success, authenticationError) in
                    if success {
                        completion(true)
                    } else {
                        guard let authError = authenticationError?.localizedDescription else {return}
                        //show alert
                        let alert = UIAlertController(title: "Error!", message: "Try again.", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Ok.", style: .default, handler: nil)
                        alert.addAction(action)
                        self.present(alert, animated: true, completion: nil)
                        completion(false)
                    }
                }
            } else {
                //device doesn't support faceID/touchID
                guard let errorReason = authError?.localizedDescription else {return}
                let alert = UIAlertController(title: "Error!", message: "Your device doesn't support Biometrics Authentication.", preferredStyle: .alert)
                let action = UIAlertAction(title: "Ok.", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
                completion(false)
            }
        } else { //deprecated OS version
            let alert = UIAlertController(title: "Deprecated OS version!", message: "Your device OS version doesn't support Biometrics Authentication. Please update your device.", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok.", style: .default, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            completion(false)
            
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

