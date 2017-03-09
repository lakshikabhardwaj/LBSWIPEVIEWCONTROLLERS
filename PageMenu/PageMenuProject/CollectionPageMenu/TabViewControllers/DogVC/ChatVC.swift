//
//  ChatVC.swift
//  CollectionPageMenu
//
//  Created by lakshika bhardwaj on 25/04/16.
//  Copyright © 2016 Kellton Tech. All rights reserved.
//

import UIKit

class ChatVC: UIViewController  ,UITableViewDataSource,UITableViewDelegate ,UITextFieldDelegate{

    @IBOutlet weak var chatTable: UITableView!
    @IBOutlet weak var chatBox: UITextField!
    
    var textArray :[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
   chatTable.register(UINib(nibName: "ChatMesssegeCell", bundle: nil), forCellReuseIdentifier: "chatCell")
        chatTable.estimatedRowHeight = 50
        chatTable.rowHeight = UITableViewAutomaticDimension
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func goAction(_ sender: AnyObject) {
        textArray.append(chatBox.text!)
        chatTable.reloadData()
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textArray.append(chatBox.text!)
        chatTable.reloadData()
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      let cell:ChatMesssegeCell! = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as? ChatMesssegeCell
      cell.chatText.text = textArray[indexPath.row]
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
