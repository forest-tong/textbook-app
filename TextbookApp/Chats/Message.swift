import Foundation

class Message: PFObject, PFSubclassing {
    @NSManaged var me: PFUser?
    @NSManaged var you: PFUser?
    @NSManaged var text: String?
    @NSManaged var sentDate: NSDate?
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    override init() {
        super.init()
    }

    init(me: PFUser, you: PFUser, text: String, sentDate: NSDate) {
        super.init()
        self.me = me
        self.you = you
        self.sentDate = sentDate
    }
    
    static func parseClassName() -> String {
        return "Message"
    }
}
