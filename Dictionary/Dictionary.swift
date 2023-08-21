//
//  Dictionary.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//
import UIKit
class Dictionary1: NSDictionary {
}
public extension NSDictionary {
    func toString2 () -> String {
        do {
            let opt = JSONSerialization.WritingOptions.prettyPrinted
            let jsonData: NSData = try JSONSerialization.data(withJSONObject: self, options: opt) as NSData
            let str = NSString(data: jsonData as Data, encoding: String.Encoding.utf8.rawValue)! as String
            return str.replacingOccurrences(of: "\n", with: "")
        } catch {
        }
        return "[]"
    }
    func getMutable (_ mdd: NSMutableDictionary? = nil) -> NSMutableDictionary? {
        let dict = self
        var mdd = mdd
        if mdd == nil {
            mdd = NSMutableDictionary ()
        }
        let arr = dict.allKeys
        for iii in 0..<arr.count {
            if let val = dict[arr[iii]] as? String {
                mdd?[arr[iii]] = val
            } else if let val = dict[arr[iii]] as? Double {
                mdd?[arr[iii]] = val
            } else if let val = dict[arr[iii]] as? Int {
                mdd?[arr[iii]] = val
            } else if let val = dict[arr[iii]] as? NSArray {
                mdd?[arr[iii]] = val.getMutable(nil)
            } else if let val = dict[arr[iii]] as? NSDictionary {
                mdd?[arr[iii]] = val.getMutable(nil)
            } else if let val = dict[arr[iii]] as? Float {
                mdd?[arr[iii]] = val
            } else {
                mdd?[arr[iii]] = ""
            }
        }
        return mdd
    }
    func toString1 (_ caller: Bool = true) -> String {
        var str = "{"
        for (key, value) in self {
            let key = (key as? String)!
            if str.count == 1 {
                str = logicIf (key, str, value)
            } else {
                str = logicElse (key, str, value)
            }
        }
        if caller {
            str = "\(str)}".colon ()
            str = str.substring(from: 1)
            str = str.substring(tto: str.count-1)
            
            return str
        } else {
            str = "\(str)}"
            
            return str
        }
    }
    func logicIf (_ key: String, _ str: String, _ value: Any) -> String {
        var str = str
        if value is String {
            str = "\(str)\(key.colon ()):\("\(value)".colon ())"
        } else if value is Double {
            str = "\(str)\(key.colon ()):\("\(value)".colon ())"
        } else if value is Int {
            str = "\(str)\(key.colon ()):\("\(value)".colon ())"
        } else if let val = value as? NSArray {
            str = "\(str)\(key.colon ()):\(val.toString3(false))"
        } else if let val = value as? NSDictionary {
            let sss = val.toString1(false)
            str = "\(str)\(key.colon ()):\(sss)"
        } else if value is Float {
            str = "\(str)\(key.colon ()):\("\(value)".colon ())"
        } else if value is Bool {
            str = "\(str)\(key.colon ()):\("\(value)".colon ())"
        } else if value is Double {
            str = "\(str)\(key.colon ()):\("\(value)".colon ())"
        } else {
            str = "\(str)\(key.colon ()):\("".colon ())"
        }
        
        return str
    }
    func logicElse (_ key: String, _ str: String, _ value: Any) -> String {
        var str = str
        if value is String {
            str = "\(str),\(key.colon ()):\("\(value)".colon ())"
        } else if value is Double {
            str = "\(str),\(key.colon ()):\("\(value)".colon ())"
        } else if value is Int {
            str = "\(str),\(key.colon ()):\("\(value)".colon ())"
        } else if let val = value as? NSArray {
            str = "\(str),\(key.colon ()):\(val.toString3(false))"
        } else if let val = value as? NSDictionary {
            let sss = val.toString1(false)
            str = "\(str),\(key.colon ()):\(sss)"
        } else if value is Float {
            str = "\(str),\(key.colon ()):\("\(value)".colon ())"
        } else if value is Bool {
            str = "\(str),\(key.colon ()):\("\(value)".colon ())"
        } else if value is Double {
            str = "\(str),\(key.colon ()):\("\(value)".colon ())"
        } else {
            str = "\(str),\(key.colon ()):\("".colon ())"
        }
        
        return str
    }
    
    func array (_ key: String) -> [Any]? {
        if let title = self[key] as? [Any] {
            return title
        } else {
            return nil
        }
    }
    func dictionary (_ key: String) -> [String: Any]? {
        if let title = self[key] as? [String: Any] {
            return title
        } else {
            return nil
        }
    }
    func string (_ key: String) -> String {
        if key == "success_message" || key == "response_message" {
            let success_message = self.stringCore("success_message")
            let response_message = self.stringCore("response_message")
            let message = self.stringCore("message")
            
            if success_message.count > 0 {
                return success_message
            } else if response_message.count > 0 {
                return response_message
            } else if message.count > 0 {
                return message
            } else {
                return ""
            }
        } else {           
            return stringCore (key)
        }
    }
    func stringCore (_ key: String) -> String {
        if let title = self[key] as? String {
            return "\(title)"
        } else if let title = self[key] as? NSNumber {
            return "\(title)"
        } else {
            return ""
        }
    }
    func number (_ key: String) -> NSNumber {
        if key == "success" || key == "status" {
            let success = self.string("success")
            let status = self.string("status")
            
            if success.count > 0 {
                return NSNumber(value: Int(success)!)
            } else if status.count > 0 {
                return NSNumber(value: Int(status)!)
            } else {
                return NSNumber(value: 0)
            }
        } else {
            if let title = self[key] as? NSNumber {
                return title
            } else if let title = self[key] as? String {
                if let title1 = Int(title) as Int? {
                    return NSNumber(value: title1)
                } else if let title1 = Float(title) as Float? {
                    return NSNumber(value: title1)
                } else if let title1 = Double(title) as Double? {
                    return NSNumber(value: title1)
                } else if let title1 = Bool(title) as Bool? {
                    return NSNumber(value: title1)
                }
                return 0
            } else {
                return 0
            }
        }
    }
    
    func msg (_ type: MSGType = .both) {
        if type == .both {
            //Http.alert("", self.string("message"))
            Toast.toast(self.string("message"))
        } else if self.number("success").intValue == 1 && type == .success {
            //Http.alert("", self.string("message"))
            Toast.toast(self.string("message"))
        }  else if self.number("success").intValue == 0 && type == .fail {
            //Http.alert("", self.string("message"))
            Toast.toast(self.string("message"))
        }
    }
    
    func success () -> Bool {
        if self.number("success").intValue == 1 {
            return true
        }
        
        if self.number("status").intValue == 1 {
            return true
        }
        
        return false
    }
    
    func bool (_ key: String) -> Bool {
        if let title = self[key] as? Bool {
            return title
        } else {
            return false
        }
    }
}

extension NSDictionary {
    func data () -> (data: Data?, ss: String?) {
        let json = self.getMutable(nil)
        
        if json == nil {
            return (nil, nil)
        }
        
        let s1 = (json?.toString1())!.replacingOccurrences(of: "<null>", with: "")
        
        return (s1.data(using: String.Encoding.utf8), s1)
    }
}

public enum MSGType {
    case success
    case fail
    case both
}
