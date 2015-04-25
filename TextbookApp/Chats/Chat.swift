import Foundation
import Parse

var dateFormatter = NSDateFormatter()

class Chat: PFObject, PFSubclassing {
    var me: PFUser
    var you: PFUser
    var lastMessageText: String
    var lastMessageSentDate: NSDate
    var messages: [[Message]]
    var unreadMessageCount: Int = 0 // subtacted from total when read
    var hasUnloadedMessages = false
    var draft = ""
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    
    override init() {
        self.me = PFUser.currentUser()!
        self.you = PFUser.currentUser()!
        self.lastMessageText = "hello"
        self.lastMessageSentDate = NSDate()
        self.messages = []
        super.init()
    }
    
    var lastMessageSentDateString: String {
        return formatDate(lastMessageSentDate)
    }
    
    init(me: PFUser, you: PFUser, lastMessageText: String, lastMessageSentDate: NSDate) {
        self.me = me
        self.you = you
        self.lastMessageText = lastMessageText
        self.lastMessageSentDate = lastMessageSentDate
        self.messages = []
        super.init()
    }
    
    func formatDate(date: NSDate) -> String {
        let calendar = NSCalendar.currentCalendar()
        
        let last18hours = (-18*60*60 < date.timeIntervalSinceNow)
        let isToday = calendar.isDateInToday(date)
        let isLast7Days = (calendar.compareDate(NSDate(timeIntervalSinceNow: -7*24*60*60), toDate: date, toUnitGranularity: .CalendarUnitDay) == NSComparisonResult.OrderedAscending)
        
        if last18hours || isToday {
            dateFormatter.dateStyle = .NoStyle
            dateFormatter.timeStyle = .ShortStyle
        } else if isLast7Days {
            dateFormatter.dateFormat = "ccc"
        } else {
            dateFormatter.dateStyle = .ShortStyle
            dateFormatter.timeStyle = .NoStyle
        }
        return dateFormatter.stringFromDate(date)
    }

    static func parseClassName() -> String {
        return "Chat"
    }
}
