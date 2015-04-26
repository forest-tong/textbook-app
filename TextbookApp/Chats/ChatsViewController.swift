import UIKit

//Source: https://github.com/acani/chats

class ChatsViewController: UITableViewController {
    var chats = [Chat]()

    convenience init() {
        self.init(style: .Plain)
        title = "Chats"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let chat = Chat(me: PFUser.currentUser()!, you: PFUser.currentUser()!, lastMessageSentDate: NSDate())
//        chat.messages = [
//            [
//                Message(incoming: true, text: "I really enjoyed programming with you! :-)", sentDate: NSDate(timeIntervalSinceNow: -60*60*24*2-60*60)),
//                Message(incoming: false, text: "Thanks! Me too! :-)", sentDate: NSDate(timeIntervalSinceNow: -60*60*24*2))
//            ],
//            [
//                Message(incoming: true, text: "Hey, would you like to spend some time together tonight and work on Acani?", sentDate: NSDate(timeIntervalSinceNow: -33)),
//                Message(incoming: false, text: "Sure, I'd love to. How's 6 PM?", sentDate: NSDate(timeIntervalSinceNow: -19)),
//                Message(incoming: true, text: "6 sounds good :-)", sentDate: NSDate())
//            ]
//        ]
//        let tempChats = [chat]
//        let currentUser = PFUser.currentUser()!
//        currentUser.setValue(tempChats, forKey: "chats")
//        chat.saveInBackgroundWithBlock(nil)
//        currentUser.saveInBackgroundWithBlock(nil)
        self.chats = PFUser.currentUser()!.objectForKey("chats") as! [Chat]
        
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.rowHeight = chatCellHeight
        tableView.separatorInset.left = chatCellInsetLeft
        tableView.registerClass(ChatCell.self, forCellReuseIdentifier: NSStringFromClass(ChatCell))
    }
    
    override func viewDidAppear(animated: Bool) {
//        fetchChats()
//        tableView.reloadData()
    }
    
    func fetchChats() {
//        let buyerQuery = PFQuery(className: "Chat")
//        buyerQuery.whereKey("buyer", equalTo: PFUser.currentUser()!)
//        let sellerQuery = PFQuery(className: "Chat")
//        sellerQuery.whereKey("seller", equalTo: PFUser.currentUser()!)
//        let query = PFQuery.orQueryWithSubqueries([buyerQuery, sellerQuery])
//        query.orderByDescending("updatedAt")
//        buyerQuery.findObjectsInBackgroundWithBlock { objects, error -> Void in
//            if let chats = objects as? [Chat] {
//                account.chats = chats
//                self.tableView.reloadData()
//            }
//        }
        let query = Chat.query()!
        query.includeKey("you")
        query.includeKey("me")
        query.includeKey("messages")
        query.whereKey("me", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock { objects, error -> Void in
            if let myChats = objects as? [Chat] {
                self.chats = myChats
                self.tableView.reloadData()
            }
        }
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chats.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NSStringFromClass(ChatCell), forIndexPath: indexPath) as! ChatCell
        cell.configureWithChat(chats[indexPath.row])
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let chat = chats[indexPath.row]
        let chatViewController = ChatViewController(chat: chat)
        navigationController?.pushViewController(chatViewController, animated: true)
    }
}
