import Foundation

class Message: PFObject, PFSubclassing {
    var incoming: Bool?
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

    init(incoming: Bool, text: String, sentDate: NSDate) {
        super.init()
        self.incoming = incoming
        self.text = text
        self.sentDate = sentDate
    }
    
    static func parseClassName() -> String {
        return "Message"
    }
}
