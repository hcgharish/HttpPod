//
//  String.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//
import UIKit
class String1: NSString {
}

public extension String {
    var hasWhiteSpace : Bool {
        return(self.rangeOfCharacter(from: .whitespacesAndNewlines) != nil)
    }
    
    func showRating () -> String {
        if self.count > 0 {
            if let flo = Float(self) {
                return String(format: "%0.1f", arguments: [flo])
                
                /*let diff = flo - Float(Int(flo))
                let multi = Int(diff * 1000)
                
                if multi > 0 {
                    return String(format: "%0.1f", arguments: [flo])
                } else {
                    return String(format: "%d", arguments: [Int(flo)])
                }*/
            }
        }
        
        return self
    }
    
    func showPrice () -> String {
        if self.count > 0 {
            if let flo = Float(self) {
                let diff = flo - Float(Int(flo))
                let multi = Int(diff * 1000)
                
                if multi > 0 {
                    return String(format: "%0.2f", arguments: [flo])
                } else {
                    return String(format: "%0.2f", arguments: [flo])
                    //return String(format: "%d", arguments: [Int(flo)])
                }
            }
        } else {
            return "0.00"
        }
        
        return self
    }
//public extension String {
    func currTime () -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = self//"yyyy-MM-dd HH:mm:ss"//.SSSZ"
        let date = Date()
        let str = dateFormatter.string(from: date)
        return str
    }
    func convertToJson() -> Any? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data,
                                                        options: [])
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
    func colon () -> String {
        return "\"\(self)\""
    }
    func json () -> Any? {
        let data = self.data(using: String.Encoding.ascii)
        if data != nil {
            do {
                return try JSONSerialization.jsonObject(with: data!,
                                                        options: .allowFragments)
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
    var length: Int {
        return self.count
    }
    subscript (iii: Int) -> String {
        return self[iii ..< iii + 1]
    }
    func substring(from: Int) -> String {
        return self[min(from, length) ..< length]
    }
    func substring(tto: Int) -> String {
        return self[0 ..< max(0, tto)]
    }
    subscript (rrr: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, rrr.lowerBound)),
                                            upper: min(length, max(0, rrr.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        let range1 = start..<end
        return String(self[range1])
    }
    func heightWithConstrainedWidth(width: CGFloat,
                                           font: UIFont) -> CGRect {
        let constraintRect = CGSize(width: width,
                                    height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font],
                                            context: nil)
        return boundingBox
    }
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    func capFirstLetter() -> String {
        let first = String(prefix(1)).capitalized
        let other = String(dropFirst())
        return first + other
    }
    mutating func capFirst() {
        self = self.capFirstLetter()
    }
    func converDate(_ from: String,
                           _ tto: String) -> String {
        if self.count == 0 {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = from
        let myDate: Date? = dateFormatter.date(from: self)
        
        //print("myDate-\(myDate)-")
        
        dateFormatter.dateFormat = tto
        if myDate == nil {
            return ""
        } else {
            return dateFormatter.string(from: myDate!)
        }
    }
    func getDate(_ formate: String) -> Date {
        if self.count == 0 {
            return Date()
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        let dttt = dateFormatter.date(from: self)
        
        if dttt == nil {
            return Date()
        } else {
            return dttt!
        }
    }
    func getDateWithNull(_ formate: String) -> Date? {
        if self.count == 0 {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        let dttt = dateFormatter.date(from: self)
        
        if dttt == nil {
            return nil
        } else {
            return dttt!
        }
    }
    func isDate(_ formate: String) -> Date? {
        if self.count == 0 {
            return Date()
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formate
        return dateFormatter.date(from: self)
    }
    func imageName () -> String {
        var name = self.replacingOccurrences(of: ".", with: "_")
        name = name.replacingOccurrences(of: "?", with: "_")
        name = name.replacingOccurrences(of: "=", with: "_")
        name = name.replacingOccurrences(of: ":", with: "_")
        name = name.replacingOccurrences(of: "//", with: "_")
        name = name.replacingOccurrences(of: "/", with: "_")
        name = name.replacingOccurrences(of: "-", with: "_")
        name = name.replacingOccurrences(of: "", with: "_")
        name = "\(name).jpg"
        let arr = name.components(separatedBy: "_")
        if arr.count > 0 {
            let divide: Int = Int(arr.count / 2)
            if divide <= 0 {
                return name
            } else {
                var newName = ""
                for iii in divide..<arr.count {
                    newName = "\(newName)\(arr[iii])"
                }
                return newName
            }
        }
        return ""
    }
    func subString (_ str: String) -> Bool {
        if self.range(of: str) != nil {
            return true
        }
        return false
    }
    func subInSensetive (_ str: String) -> Bool {
        if self.range(of: str,
                      options: String.CompareOptions.caseInsensitive,
                      range: nil,
                      locale: nil) != nil {
            return true
        }
        return false
    }
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self,
                                           options: [],
                                           range: NSRange(location: 0, length: self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    func validate(_ phoneNumber: String) -> Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = phoneNumber.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  phoneNumber == filtered
    }
    func getDateFromUTC (_ formate: String) -> Date {
        let dateUTC = self.getDate(formate)
        let timeZoneLocal = NSTimeZone.local as TimeZone?
        let newDate = Date(timeInterval: TimeInterval((timeZoneLocal?.secondsFromGMT(for: dateUTC))!),
                           since: dateUTC)
        return newDate//.getStringDate(formate)
    }
    
    func getUTCDate(_ formate: String) -> Date {
        if self.count == 0 {
            return Date()
        }
        
        let timeZoneLocal = NSTimeZone.local as TimeZone?

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = timeZoneLocal
        dateFormatter.dateFormat = formate
        let dttt = dateFormatter.date(from: self)
        
        if dttt == nil {
            return Date()
        } else {
            return dttt!
        }
    }
}

extension String {
    func getUserValue () -> Any? {
        let user = UserDefaults.standard
        return user.value(forKey: self)
    }
    
    func setUserValue (_ value: Any) {
        let user = UserDefaults.standard
        user.set(value, forKey: self)
        user.synchronize()
    }
    
    func removeUserValue () {
        let user = UserDefaults.standard
        user.removeObject(forKey: self)
        user.synchronize()
    }
    
    func clearUserData () {
        /*Key_User_website_link.removeUserValue()
        Key_User_about_me.removeUserValue()
        Key_User_access.removeUserValue()
        Key_User_business_name.removeUserValue()
        Key_User_city.removeUserValue()
        Key_User_country.removeUserValue()
        Key_User_dob.removeUserValue()
        Key_User_email.removeUserValue()
        Key_User_full_name.removeUserValue()
        Key_User_gender.removeUserValue()
        Key_User_id.removeUserValue()
        Key_User_last_login.removeUserValue()
        Key_User_latitude.removeUserValue()
        Key_User_license_number.removeUserValue()
        Key_User_longitude.removeUserValue()
        Key_User_mobile.removeUserValue()
        Key_User_online.removeUserValue()
        Key_User_phone_number.removeUserValue()
        Key_User_professional_experience.removeUserValue()
        Key_User_profile_pic.removeUserValue()
        Key_User_register_complete.removeUserValue()
        Key_User_status.removeUserValue()
        Key_User_verified.removeUserValue()
        Key_User_website_link.removeUserValue()*/
    }
}



extension String {
    func viewController (_ vc: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: self, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: vc)
        return vc
    }
}

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

extension String {
    func replace (_ of: String, _ with: String) -> String {
        return self.replacingOccurrences(of: of, with: with)
    }
    
    func saveUserInfo () {
        let user = UserDefaults.standard
        user.set(self, forKey: "UserData")
        user.synchronize()
    }
    
    func removeUserInfo () {
        let user = UserDefaults.standard
        user.removeObject(forKey: "UserData")
        user.synchronize()
    }
    
    func saveJson (_ key: String) {
        let user = UserDefaults.standard
        user.set(self, forKey: key)
        user.synchronize()
    }
    
    func savedJson (_ key: String) -> String? {
        let user = UserDefaults.standard
        
        return user.object(forKey: key) as? String
        
        //user.set(self, forKey: key)
        //user.synchronize()
    }
}

extension String {
    /*func lt () -> String {
        return kAppDelegate.getLang(self)
    }*/
    
    func capWords () -> String {
        let arr = self.components(separatedBy: " ")
        
        var str = ""
        
        for i in 0..<arr.count {
            if str.count == 0 {
                str = arr[i].lowercased().capFirstLetter()
            } else {
                str = "\(str) \(arr[i].lowercased().capFirstLetter())"
            }
        }
        
        return str
    }
}

extension String {
    func concat (_ add: String?, _ with: String = ",") -> String {
        if add == nil {
            return self
        }
        
        if add!.count == 0 {
            return self
        }
        
        var str = self
        
        if str.count == 0 {
            str = add!
        } else {
            str = "\(str)\(with)\(add!)"
        }
        
        return str
    }
}

func logPrint (_ any: Any, _ str: String = "") {
    if str.count > 0 {
        print("\(Date().getStringDate("HH:mm:ss")) [\(str)] [\(any)]")
    } else {
        print("\(Date().getStringDate("HH:mm:ss")) [\(any)]")
    }
}

extension NSArray {
    func log (_ str: String = "") {
        logPrint(self, str)
    }
}

extension UIColor {
    func log (_ str: String = "") {
        logPrint(self, str)
    }
}

extension Date {
    func log (_ str: String = "") {
        logPrint(self, str)
    }
}

extension UIImage {
    func log (_ str: String = "") {
        logPrint(self, str)
    }
}

extension NSDictionary {
    func log (_ str: String = "") {
        logPrint(self, str)
    }
}

extension UIView {
    func log (_ str: String = "") {
        logPrint(self, str)
    }
}

extension String {
    func log (_ str: String = "") {
        logPrint(self, str)
    }
}

extension Bool {
    func log (_ str: String = "") {
        logPrint(self, str)
    }
}

extension Int {
    func log (_ str: String = "") {
        logPrint(self, str)
    }
}

extension Float {
    func log (_ str: String = "") {
        logPrint(self, str)
    }
}

extension Double {
    func log (_ str: String = "") {
        logPrint(self, str)
    }
}

extension IndexPath {
    func log (_ str: String = "") {
        logPrint(self, str)
    }
}

extension String {
    public func getTDate () -> Date? {
        let parkingTime1 = self.replacingOccurrences(of: "T", with: " ").replacingOccurrences(of: "Z", with: "").replacingOccurrences(of: ".000", with: " +0000")
        
        return parkingTime1.getDateWithNull("yyyy-MM-dd HH:mm:ss z")
    }
    
    func float () -> Float? {
        if self.count > 0 {
            return  Float(self)
        }
        
        return 0
    }
    
    func double () -> Double? {
        if self.count > 0 {
            return Double(self)
        }
        
        return 0
    }
    
    func int () -> Int? {
        if self.count > 0 {
            return Int(self)
        }
        
        return 0
    }
}
