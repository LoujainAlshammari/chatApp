//
//  ViewController2.swift
//  chatApp
//
//  Created by loujain on 07/12/2021.
//

import UIKit
import Firebase

class ChatViewController: UIViewController{
    let firestoreUrl = Firestore.firestore()
    var idUser:String?
    var nameUserr:String?
    var Id = ""
    @IBOutlet weak var textMessage: UITextField!
    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.delegate = self
        userTableView.dataSource = self
        
    }

    @IBAction func sendMessagee(_ sender: Any) {
        sendMeg()
        
    }

    func sendMeg(){
        let message = ["content":textMessage!]
        let myId = Auth.auth().currentUser?.uid
        
//        firestoreUrl.collection("Users").document(myId!).collection("Message").document(self.Id).setData(message)
//
//        firestoreUrl.collection("Users").document(self.Id).collection("Message").document(myId!).setData(message)
        
        firestoreUrl.collection("Users").document(myId!).collection("Message").document(self.Id).collection("msg").document().setData(message)
        
        firestoreUrl.collection("Users").document(self.Id).collection("Message").document(myId!).collection("msg").document().setData(message)
    }
 
}


extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! ChatTableViewCell
        
        return cell
    }
    
}
