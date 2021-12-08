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
//    var Id = ""
    var arrMeg:[String] = []
    var myId:String?

    @IBOutlet weak var textMessage: UITextField!
    @IBOutlet weak var userTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTableView.delegate = self
        userTableView.dataSource = self
        myId = Auth.auth().currentUser?.uid
        getLesner()
    }

    @IBAction func sendMessagee(_ sender: Any) {
        sendMeg()
        
    }

    func sendMeg(){
        let message = ["content":textMessage!]
        
//        firestoreUrl.collection("Users").document(myId!).collection("Message").document(self.Id).setData(message)
//
//        firestoreUrl.collection("Users").document(self.Id).collection("Message").document(myId!).setData(message)


        firestoreUrl.collection("Users").document(myId!).collection("Message").document(self.myId!).collection("msg").document().setData(message)
        
        firestoreUrl.collection("Users").document(self.myId!).collection("Message").document(myId!).collection("msg").document().setData(message)
    }
    
    func getLesner(){

        firestoreUrl.collection("Users").document(myId!).collection("Message").document(self.myId!).collection("msg").addSnapshotListener{ documentSnapshot, error in

            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }

            self.arrMeg.removeAll()
            for item in documentSnapshot!.documents {

                self.arrMeg.append(item.get("content") as! String)

            }
            self.userTableView.reloadData()
        }
    }
 
}


extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMeg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as! ChatTableViewCell
        cell.userChat.text = arrMeg[indexPath.row]

        return cell
    }
    
}
