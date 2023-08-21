//
//  AppNeeds.swift
//  YORHero
//
//  Created by mac on 06/11/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit

class AppNeeds: NSObject {

}

let KEY_ACCESSTOEKN = "access-token"

func generateAccessToken (completionHandler: @escaping (String?) -> Swift.Void) {
    let user = UserDefaults.standard
    
    if user.object(forKey: KEY_ACCESSTOEKN) == nil {
        /*let httpPara = HttpParams (api_generate_access_token)
        httpPara.params = params()
        
        Http.instance().request(httpPara) { (response) in
            //let json = response?.json as? NSDictionary
            if let json = response?.json as? NSDictionary {
                if json.number("status").intValue == 1 {
                    let token = json.string("token")
                    
                    if token.count > 0 {
                        user.set(token, forKey: KEY_ACCESSTOEKN)
                        user.synchronize()
                        
                        completionHandler(token)
                        
                        return
                    }
                } else {
                    completionHandler (nil)
                }
            }
        }*/
    } else {
        completionHandler (user.object(forKey: KEY_ACCESSTOEKN) as? String)
    }
}

func removeToken () {
    let user = UserDefaults.standard
    user.removeObject(forKey: KEY_ACCESSTOEKN)
    user.synchronize()
}

func params () -> NSMutableDictionary {
    let md = NSMutableDictionary()
    
    /*
    md["device_id"] = UIDevice.current.identifierForVendor() // UIDevice.current.identifierForVendor!.uuidString
    md["device_type"] = "2"
    md["api_key"] = "hero@user#2"
    
    let user = UserDefaults.standard
    
    if let token = user.object(forKey: KEY_ACCESSTOEKN) as? String {
        md["access_token"] = token
    }
    
    let ob = LoginJSON.userInfo()
    
    if ob != nil {
        if ob?.data?.id != nil {
            md["uid"] = (ob?.data?.id)!
        }
    }
    
    //md["type"] = "user"
    md["access"] = "user"
    */
    
    if let id = userId() {
        md["user_id"] = id
    }
    
    /*let obl = kAppDelegate.location()
    
    if obl.lat != nil && obl.lng != nil {
        md["lat"] = obl.lat
        md["long"] = obl.lng
    }*/
    
    /*let obLang = kAppDelegate.getAppLanguage()
    
    if obLang.lang == .arabic {
        md["language"] = "ar"
    } else if obLang.lang == .english {
        md["language"] = "en"
    } else if obLang.lang == .hebrew {
        md["language"] = "hb"
    }*/
    
    return md
}

func header () -> NSMutableDictionary {    
    let md = NSMutableDictionary()
    md["device_id"] = UIDevice.current.identifierForVendor() // UIDevice.current.identifierForVendor!.uuidString
    md["device_type"] = "ios"
    md["api_key"] = "cleaningapp123"
    md["language"] = "en"
    
    let ob = LoginJSON.userInfo()
    
    if let token = ob?.data?.token {
        md["access_token"] = token
    }
    
    /*let obLang = kAppDelegate.getAppLanguage()
    
    if obLang.lang == .arabic {
        md["language"] = "ar"
    } else if obLang.lang == .english {
        md["language"] = "en"
    } else if obLang.lang == .hebrew {
        md["language"] = "hb"
    }*/
    
    return md
}

func isLogged () -> Bool {
    let ob = LoginJSON.userInfo()
    
    if ob != nil {
        if let arr = ob?.data?.userdata as? [DataDetail] {
            for i in 0..<arr.count {
                let ob = arr[i]
                if ob.id != nil {
                    return true
                }
            }
        }
        
        
    }
    
    return false
}

func userId () -> String? {
    let ob = LoginJSON.userInfo()
    
    if ob != nil {
        if let arr = ob?.data?.userdata {
            for i in 0..<arr.count {
                let ob = arr[i]
                
                return ob.id
            }
        }
    }
    
    return nil
}

struct LoginJSON: Codable {
    static func logout () {
        let user = UserDefaults.standard
        user.removeObject(forKey: "UserData")
        user.synchronize()
    }
    
    static func userInfo () -> LoginJSON? {
        let user = UserDefaults.standard
        
        if let s1 = user.object(forKey: "UserData") as? String {
            let data = s1.data(using: String.Encoding.utf8)
            
            if data != nil {
                do {
                    let loginInfo = try JSONDecoder().decode(LoginJSON.self, from: data!)
                    return loginInfo
                } catch let error {
                    print("Error: \(error)")
                }
            }
        }
        
        return nil
    }
    
    let status: String?
    let message: String?
    let data: DataClass?
    
    enum CodingKeys: String, CodingKey {
        case status
        case message
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    
    var affectedRows: String?
    var changedRows: String?
    var fieldCount: String?
    var id: String?
    var message: String?
    var protocol41: String?
    var serverStatus: String?
    var warningCount: String?
    var token: String?
    var userdata: [DataDetail]?
    var userdata1: [DataDetail]?
    
    enum CodingKeys: String, CodingKey {
        case userdata = "userdata"
        case userdata1 = "data"
        case token = "token"
        case affectedRows = "affectedRows"
        case changedRows = "changedRows"
        case fieldCount = "fieldCount"
        case id = "id"
        case message = "message"
        case protocol41 = "protocol41"
        case serverStatus = "serverStatus"
        case warningCount = "warningCount"
    }
}

struct DataDetail: Codable {
    
//    var affectedRows: String?
//
//    var admin_status: String?
//    var birthdate: String?
//    var country: String?
//    var country_code: String?
//    var created_on: String?
//    var device_notification_id: String?
//    var device_type: String?
    var firstName: String?
//    var gender: String?
    var id: String?
//    var language: String?
    var lastName: String?
//    var lat: String?
//    var longitude: String?
    var mobile_no: String?
//    var password: String?
//    var user_role: String?
//    var verify: String?
    
    enum CodingKeys: String, CodingKey {
//        case admin_status = "admin_status"
//        case birthdate = "birthdate"
//        case country = "country"
//        case country_code = "country_code"
//        case created_on = "created_on"
//        case device_notification_id = "device_notification_id"
//        case device_type = "device_type"
        case firstName = "firstName"
//        case gender = "gender"
        case id = "id"
//        case language = "language"
        case lastName = "lastName"
//        case lat = "lat"
//        case longitude = "longitude"
        case mobile_no = "mobile_no"
//        case password = "password"
//        case user_role = "user_role"
//        case verify = "verify"
    }
}

/*
"" = 1;
 = "2021-03-23";
 = Angola;
"" = 244;
"" = "2021-03-23T10:55:22.000Z";
"" = "F59EA7E2-34CD-417D-BACD-ACAEBB30771C";
"" = ios;
 = Ggggg;
 = f;
 = 22;
 = en;
 = Fffff;
 = "";
 = "";
"" = 9999988881;
 = "$2b$10$LFcRiGwOmqf8kQcQwKHbpurduf0hV4kOLev6O4cXr8iE.Di2TJaB2";
"" = user;
 = 1;
*/
extension NSDictionary {
    func sessionExpired (_ vc: UIViewController) {
        var boolSessionExpired = false
        
        if self.number("success").intValue == 4 {
            boolSessionExpired = true
        } else if self.string("response_message") == "invalid_access_token" {
            boolSessionExpired = true
        } /*else if self.string("message") == "User not found" {
            boolSessionExpired = true
        }*/
        
        if boolSessionExpired {
           // kAppDelegate.subscribeToFirebase(false)
            
            LoginJSON.logout()
            
            let user = UserDefaults.standard
            user.removeObject(forKey: KEY_ACCESSTOEKN)
            user.synchronize()
            
            //Http.alert("", "Session expired")
            
            vc.popToHome (vc)
        }
    }
}

extension UIViewController {
    func popToHome (_ vc: UIViewController) {
        DispatchQueue.main.async {
            /*
            var bool = false
            if let nv = self.navigationController {
                for controller in nv.viewControllers as Array {
                    if controller.isKind(of: GetStarted.self) {
                        bool = true
                        
                        controller.navigationController!.popToRootViewController(animated: true)
                        break
                    }
                }
            }
            
            if bool == false {
                let vc1 = GetStarted.viewController()
                kAppDelegate.navigationController = UINavigationController(rootViewController: vc1)
                kAppDelegate.navigationController?.isNavigationBarHidden = true
                kAppDelegate.window?.rootViewController = kAppDelegate.navigationController
            }
            */
        }
    }
}
