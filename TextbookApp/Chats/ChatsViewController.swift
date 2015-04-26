import UIKit

//Source: https://github.com/acani/chats

class ChatsViewController: UITableViewController {
    var chats = [Chat]()

    convenience init() {
        println("init")
        self.init(style: .Plain)
        title = "Chats"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chat = Chat(me: PFUser.currentUser()!, you: PFUser.currentUser()!, lastMessageSentDate: NSDate())
        chat.save()
        let i = PFUser.currentUser()!
        let user1 = PFQuery.getUserObjectWithId("hhO8cokpqK")!
        let user2 = PFQuery.getUserObjectWithId("eNzwt2P8Ck")!
        chat.messages = [
            Message(me: i, you: i, text: "I really enjoyed programming with you! :-)", sentDate: NSDate(timeIntervalSinceNow: -60*60*24*2-60*60)),
            Message(me: i, you: i, text: "Thanks! Me too! :-)", sentDate: NSDate(timeIntervalSinceNow: -60*60*24*2)),
            Message(me: i, you: i, text: "Hey, would you like to spend some time together tonight and work on Acani?", sentDate: NSDate(timeIntervalSinceNow: -33)),
            Message(me: i, you: i, text: "Sure, I'd love to. How's 6 PM?", sentDate: NSDate(timeIntervalSinceNow: -19)),
            Message(me: i, you: i, text: "6 sounds good :-)", sentDate: NSDate())
        ]
        
        let chat2 = Chat(me: PFUser.currentUser()!, you: user1, lastMessageSentDate: NSDate())
        chat2.save()
        chat2.messages = [
            Message(me: i, you: user1, text: "I really enjoyed programming with you! :-)", sentDate: NSDate(timeIntervalSinceNow: -60*60*24*2-60*60)),
            Message(me: i, you: user1, text: "Thanks! Me too! :-)", sentDate: NSDate(timeIntervalSinceNow: -60*60*24*2)),
            Message(me: i, you: user1, text: "Hey, would you like to spend some time together tonight and work on Acani?", sentDate: NSDate(timeIntervalSinceNow: -33)),
            Message(me: i, you: user1, text: "Sure, I'd love to. How's 6 PM?", sentDate: NSDate(timeIntervalSinceNow: -19)),
            Message(me: i, you: user1, text: "6 sounds good :-)", sentDate: NSDate())
        ]
        
        let chat3 = Chat(me: PFUser.currentUser()!, you: user2, lastMessageSentDate: NSDate())
        chat3.save()
        chat3.messages = [
            Message(me: i, you: user2, text: "I really enjoyed programming with you! :-)", sentDate: NSDate(timeIntervalSinceNow: -60*60*24*2-60*60)),
            Message(me: i, you: user2, text: "Thanks! Me too! :-)", sentDate: NSDate(timeIntervalSinceNow: -60*60*24*2)),
            Message(me: i, you: user2, text: "Hey, would you like to spend some time together tonight and work on Acani?", sentDate: NSDate(timeIntervalSinceNow: -33)),
            Message(me: i, you: user2, text: "Sure, I'd love to. How's 6 PM?", sentDate: NSDate(timeIntervalSinceNow: -19)),
            Message(me: i, you: user2, text: "6 sounds good :-)", sentDate: NSDate())
        ]
        
        
        let tempChats = [chat, chat2, chat3]
        let currentUser = PFUser.currentUser()!
        currentUser.setObject(tempChats, forKey: "chats")
        currentUser.saveInBackgroundWithBlock(nil)
        chats = PFUser.currentUser()!.objectForKey("chats") as! [Chat]
        chats = []
        
        
        
        tableView.backgroundColor = UIColor.whiteColor()
        tableView.rowHeight = chatCellHeight
        tableView.separatorInset.left = chatCellInsetLeft
        tableView.registerClass(ChatCell.self, forCellReuseIdentifier: NSStringFromClass(ChatCell))
    }
    
    override func viewDidAppear(animated: Bool) {
        fetchChats()
        tableView.reloadData()
    }
    
    func fetchChats() {
        let query = Chat.query()!
        query.whereKey("me", equalTo: PFUser.currentUser()!)
        let query2 = Chat.query()!
        query2.whereKey("you", equalTo: PFUser.currentUser()!)
        let query3 = PFQuery.orQueryWithSubqueries([query, query2])
        query3.includeKey("you")
        query3.includeKey("me")
        query3.includeKey("messages")
        query3.findObjectsInBackgroundWithBlock { objects, error -> Void in
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
