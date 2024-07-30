import KMPShared

 public extension Optional where Wrapped == KotlinLong {
    var int: Int {
        Int(truncating: self ?? 0)
    }
 }

 public extension KotlinLong {
    var int: Int {
        Int(truncating: self)
    }
 }

 public extension Optional where Wrapped == KotlinInt {
    var int: Int {
        Int(truncating: self ?? 0)
    }
 }

 public extension KotlinInt {
    var int: Int {
        Int(truncating: self)
    }
 }

 public extension Int64 {
    var int: Int {
        Int(self)
    }
 }

 public extension Int32 {
    var int: Int {
        Int(self)
    }
 }

 public extension Int {
    var int: Int32 {
        Int32(self)
    }

    var int64: Int64 {
        Int64(self)
    }
 }

 public extension Optional where Wrapped == Kotlinx_datetimeInstant {
    var asDate: Date? {
        Date(timeIntervalSince1970: TimeInterval(self?.epochSeconds ?? 0))
    }
 }

 public extension Kotlinx_datetimeInstant {
    var asDate: Date {
        Date(timeIntervalSince1970: TimeInterval(self.epochSeconds))
    }
 }

 public extension Optional where Wrapped == Kotlinx_datetimeLocalDate {
    var asDate: Date? {
        guard let components = self?.toComponents() else {
            return Date()
        }
        let calendar = NSCalendar(calendarIdentifier: .gregorian)!
        return calendar.date(from: components) ?? Date()
    }
 }

// TODO: Fix
 public extension Kotlinx_datetimeLocalDate {
    var asDate: Date {
        let calendar = NSCalendar(calendarIdentifier: .gregorian)!
        return calendar.date(from: toComponents()) ?? Date()
    }
 }

 public extension Optional where Wrapped == Kotlinx_datetimeLocalDateTime {
    var asDate: Date? {
        Date(timeIntervalSince1970: TimeInterval(self?.toInstant().epochSeconds ?? 0))
    }
 }

 public extension Kotlinx_datetimeLocalDateTime {
    var asDate: Date {
        Date(timeIntervalSince1970: TimeInterval(self.toInstant().epochSeconds))
    }
 }

 public extension Date {
    var asInstant: Kotlinx_datetimeInstant {
        KotlinDateTimeKt.toInstant(self)
    }
    var asLocalDate: Kotlinx_datetimeLocalDate {
        KotlinDateTimeKt.toLocalDate(self)
    }

    var asLocalDateTime: Kotlinx_datetimeLocalDateTime {
        KotlinDateTimeKt.toLocalDateTime(self)
    }
 }
