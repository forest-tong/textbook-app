import Foundation
import Parse

var dateFormatter = NSDateFormatter()

class Chat: PFObject, PFSubclassing {
    @NSManaged var me: PFUser?
    @NSManaged var you: PFUser?
    @NSManaged var lastMessageSentDate: NSDate?
    @NSManaged var messages: [[Message]]
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
        super.init()
//        self.messages = []
//        self.me = nil
//        self.you = nil
//        self.lastMessageText = nil
//        self.lastMessageSentDate = nil
    }
    
    var lastMessageSentDateString: String? {
        return formatDate(lastMessageSentDate)
    }
    
    init(me: PFUser, you: PFUser, lastMessageSentDate: NSDate) {
        super.init()
        self.me = me
        self.you = you
        self.lastMessageSentDate = lastMessageSentDate
        self.messages = []
    }
    
    func formatDate(date: NSDate?) -> String? {
        let calendar = NSCalendar.currentCalendar()
        
        if let date = date {
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
        return nil
    }

    static func parseClassName() -> String {
        return "Chat"
    }
}
