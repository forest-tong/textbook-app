import UIKit

let chatCellHeight: CGFloat = 72
let chatCellInsetLeft = chatCellHeight + 8

class ChatCell: UITableViewCell {
    let userPictureImageView: UIImageView
    let userNameLabel: UILabel
    let lastMessageTextLabel: UILabel
    let lastMessageSentDateLabel: UILabel
    let userNameInitialsLabel: UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        let pictureSize: CGFloat = 64
        userPictureImageView = UIImageView(frame: CGRect(x: 8, y: (chatCellHeight-pictureSize)/2, width: pictureSize, height: pictureSize))
        userPictureImageView.backgroundColor = UIColor(red: 199/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1)
        userPictureImageView.layer.cornerRadius = pictureSize/2
        userPictureImageView.layer.masksToBounds = true

        userNameLabel = UILabel(frame: CGRectZero)
        userNameLabel.backgroundColor = UIColor.whiteColor()
        userNameLabel.font = UIFont.systemFontOfSize(17)

        lastMessageTextLabel = UILabel(frame: CGRectZero)
        lastMessageTextLabel.backgroundColor = UIColor.whiteColor()
        lastMessageTextLabel.font = UIFont.systemFontOfSize(15)
        lastMessageTextLabel.numberOfLines = 2
        lastMessageTextLabel.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)

        lastMessageSentDateLabel = UILabel(frame: CGRectZero)
        lastMessageSentDateLabel.autoresizingMask = .FlexibleLeftMargin
        lastMessageSentDateLabel.backgroundColor = UIColor.whiteColor()
        lastMessageSentDateLabel.font = UIFont.systemFontOfSize(15)
        lastMessageSentDateLabel.textColor = lastMessageTextLabel.textColor

        userNameInitialsLabel = UILabel(frame: CGRectZero)
        userNameInitialsLabel.font = UIFont.systemFontOfSize(33)
        userNameInitialsLabel.textAlignment = .Center
        userNameInitialsLabel.textColor = UIColor.whiteColor()

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(userPictureImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(lastMessageTextLabel)
        contentView.addSubview(lastMessageSentDateLabel)
        userPictureImageView.addSubview(userNameInitialsLabel)

        userNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addConstraint(NSLayoutConstraint(item: userNameLabel, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1, constant: chatCellInsetLeft))
        contentView.addConstraint(NSLayoutConstraint(item: userNameLabel, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 6))

        lastMessageTextLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addConstraint(NSLayoutConstraint(item: lastMessageTextLabel, attribute: .Left, relatedBy: .Equal, toItem: userNameLabel, attribute: .Left, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: lastMessageTextLabel, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 28))
        contentView.addConstraint(NSLayoutConstraint(item: lastMessageTextLabel, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1, constant: -7))
        contentView.addConstraint(NSLayoutConstraint(item: lastMessageTextLabel, attribute: .Bottom, relatedBy: .LessThanOrEqual, toItem: contentView, attribute: .Bottom, multiplier: 1, constant: -4))

        lastMessageSentDateLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addConstraint(NSLayoutConstraint(item: lastMessageSentDateLabel, attribute: .Left, relatedBy: .Equal, toItem: userNameLabel, attribute: .Right, multiplier: 1, constant: 2))
        contentView.addConstraint(NSLayoutConstraint(item: lastMessageSentDateLabel, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1, constant: -7))
        contentView.addConstraint(NSLayoutConstraint(item: lastMessageSentDateLabel, attribute: .Baseline, relatedBy: .Equal, toItem: userNameLabel, attribute: .Baseline, multiplier: 1, constant: 0))
        
        userNameInitialsLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        userPictureImageView.addConstraint(NSLayoutConstraint(item: userNameInitialsLabel, attribute: .CenterX, relatedBy: .Equal, toItem: userPictureImageView, attribute: .CenterX, multiplier: 1, constant: 0))
        userPictureImageView.addConstraint(NSLayoutConstraint(item: userNameInitialsLabel, attribute: .CenterY, relatedBy: .Equal, toItem: userPictureImageView, attribute: .CenterY, multiplier: 1, constant: -1))
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureWithChat2(chat: Chat) {
        
        
        
        chat.fetch()
        var user = chat.valueForKey("you") as! PFUser
        user.fetch()
        userPictureImageView.image = UIImage(named: "User0")
        userNameLabel.text = user.valueForKey("username") as? String
        
        
        
        var query = PFQuery(className: "Chat")
        query.whereKey("lastMessageSentDate", equalTo:chat.lastMessageSentDate!)
        query.includeKey("messages")
        var objectFirst = query.getFirstObject()!
        objectFirst.fetch()
        


        
        
        
        var messageList = objectFirst.objectForKey("messages") as! [Message]

        
        println(messageList is [Message])
        if messageList.count > 0 {
            var index = messageList.count - 1
            //                    var lastMessage = messageList[index]
            println(messageList)
            //                    self.lastMessageTextLabel.text = lastMessage.text
        }
        self.lastMessageSentDateLabel.text = chat.lastMessageSentDateString
    }





    func configureWithChat(chat: Chat) {
        chat.fetchInBackgroundWithBlock({finished, error in
            let user = chat.valueForKey("you") as! PFUser
            
            
            
            
            
            user.fetchInBackgroundWithBlock({finished, error in
                self.userPictureImageView.image = UIImage(named: "User0")
                self.userNameLabel.text = user.valueForKey("username") as? String
            })
            var messageList2 = chat.objectForKey("messages")! as! [PFObject]
            for m in messageList2 {
                m.fetch()
            }
            var messageList = messageList2 as! [Message]

            println(messageList is [Message])
            if messageList.count > 0 {
                var index = messageList.count - 1
                var lastMessage = messageList[index]
                self.lastMessageTextLabel.text = lastMessage.text
            }
            self.lastMessageSentDateLabel.text = chat.lastMessageSentDateString
        })
    }
}
