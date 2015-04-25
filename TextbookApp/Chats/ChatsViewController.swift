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
        
        let chat = Chat(me: PFUser.currentUser()!, you: PFUser.currentUser()!, lastMessageText: "hello", lastMessageSentDate: NSDate())
        let tempChats = [chat]
        let currentUser = PFUser.currentUser()!
        currentUser.setValue(tempChats, forKey: "chats")
        currentUser.saveInBackgroundWithBlock(nil)
        println(currentUser.objectForKey("chats"))
//        PFUser.currentUser()?.setObject("hello", forKey: "message")
//        println(PFUser.currentUser()?.objectForKey("message"))
        
        fetchChats()
        
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.rowHeight = chatCellHeight
        tableView.separatorInset.left = chatCellInsetLeft
        tableView.registerClass(ChatCell.self, forCellReuseIdentifier: NSStringFromClass(ChatCell))
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
        if let myChats = PFUser.currentUser()?.valueForKey("chats") as? [Chat] {
            chats = myChats
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
