import Foundation

class Message: PFObject, PFSubclassing {
    let incoming: Bool?
    let text: String?
    let sentDate: NSDate?
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    override init() {
        self.incoming = nil
        self.text = nil
        self.sentDate = nil
        super.init()
    }

    init(incoming: Bool, text: String, sentDate: NSDate) {
        self.incoming = incoming
        self.text = text
        self.sentDate = sentDate
        super.init()
    }
    
    static func parseClassName() -> String {
        return "Message"
    }
}
