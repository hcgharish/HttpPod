//
//  Functions.swift
//  HarishFrameworkSwift4
//
//  Created by Harish on 11/07/18.
//  Copyright © 2018 Harish. All rights reserved.
//
import UIKit
import MapKit
public protocol AlertDelegate: class {
    func alertZero ()
    func alertOne ()
}

let GOOGLE_KEY = "AIzaSyAiGkdyEsT9ELC7tZ6YnDyrQEIsGNwxAjE"

class Functions: NSObject { }
public func getImageSizeByUIScreen (_ size: CGSize) -> CGSize {
    var width = size.width
    var height = size.height
    if size.width > UIScreen.main.bounds.width {
        width = UIScreen.main.bounds.width
        let scale = width / size.width
        height = size.height * scale
    } else if size.height > UIScreen.main.bounds.height {
        height = UIScreen.main.bounds.height
        let scale = height / size.height
        width = size.width * scale
    }
    return CGSize(width: width, height: height)
}
public func filterByPrice (_ maA: NSMutableArray, _ high: Bool) -> NSMutableArray {
    class Item: NSObject {
        var price: Double = 0.0
    }
    var swiftArray = maA as NSArray as? [Item]
    if high {
        swiftArray = swiftArray?.sorted { $0.price < $1.price }
    } else {
        swiftArray = swiftArray?.sorted { $0.price > $1.price }
    }
    return NSMutableArray(array: swiftArray!)
}
public func array (_ dict: NSDictionary, _ key: String) -> [Any]? {
    if let title = dict[key] as? [Any] {
        return title
    } else {
        return nil
    }
}
public func dictionary (_ dict: NSDictionary, _ key: String) -> [String: Any]? {
    if let title = dict[key] as? [String: Any] {
        return title
    } else {
        return nil
    }
}
public func string (_ dict: NSDictionary, _ key: String) -> String {
    if let title = dict[key] as? String {
        return "\(title)"
    } else if let title = dict[key] as? NSNumber {
        return "\(title)"
    } else {
        return ""
    }
}
public func number (_ dict: NSDictionary, _ key: String) -> NSNumber {
    if let title = dict[key] as? NSNumber {
        return title
    } else if let title = dict[key] as? String {
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
public func bool (_ dict: NSDictionary, _ key: String) -> Bool {
    if let title = dict[key] as? Bool {
        return title
    } else {
        return false
    }
}
public func niil (_ dict: NSDictionary, _ key: String) -> String? {
    if let title = dict[key] as? String {
        return title
    } else {
        return nil
    }
}
public func nullToNil(value: AnyObject?) -> AnyObject? {
    if value is NSNull {
        return nil
    } else {
        return value
    }
}
public func isNull(value: AnyObject?) -> Bool {
    if value == nil {
        return true
    } else if value is NSNull {
        return true
    } else {
        return false
    }
}
public func callNumber(_ phoneNumber: String) {
    if let phoneCallURL: NSURL = NSURL(string: "tel://\(phoneNumber)") {
        let application: UIApplication = UIApplication.shared
        if application.canOpenURL(phoneCallURL as URL) {
            if #available(iOS 10.0, *) {
                application.open(phoneCallURL as URL, options: [:], completionHandler: nil)
            } else {
                application.openURL(phoneCallURL as URL)
            }
        } else {
            Http.alert("", "Phone call not available.")
        }
    } else {
        Http.alert("", "Phone call not available.")
    }
}

//let googleKey = "AIzaSyB7MZjDR01iPPoKqk88o6BHFVCIbhSyvM4"
let googleKey = "AIzaSyAC5Xi930pmXth1p8sO-4oW8W4h5AkI88w"

public func getAddressOrLatLong (_ lat: NSNumber?, _ long: NSNumber?,
                                 _ addr: String?, _ prnt: Bool) -> AddressObject? {
        let reach = ReachabilityKrishna.init(hostname: "google.com")
        if prnt {
            print("lat-\(String(describing: lat))-")
            print("long-\(String(describing: long))-")
            print("addr-\(String(describing: addr))-")
        }
        if lat == nil && long == nil && addr == nil {
            return nil
        } else {
            if (reach?.isReachable)! {
                var api = "https://maps.google.com/maps/api/geocode/json?sensor=false&key=\(googleKey)&"
                if lat != nil && long != nil {
                    api += "latlng=\(lat!),\(long!)"
                } else if addr != nil {
                    api += "address=\(addr!)"
                }
                if prnt {
                    print("api-\(api)-")
                }
                return getJsonAddressOrLatLong(api, lat, long, addr, prnt)
            }
        }
        return nil
}
func getJsonAddressOrLatLong (_ api: String, _ lat: NSNumber?, _ long: NSNumber?,
                              _ addr: String?, _ prnt: Bool) -> AddressObject {
    do {
        let uurl = URL(string: api.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
        
        if uurl != nil {
            let data = NSData(contentsOf: uurl!)
            if data != nil {
                let json: NSDictionary? = try JSONSerialization.jsonObject(with: data! as Data,
                                                                           options: .allowFragments)
                    as? NSDictionary
                if prnt {
                    print("json-\(String(describing: json))-")
                }
                
                if json != nil {
                    let status = string(json!, "status")
                    if status == "OK" {
                        if let results = json?["results"] as? NSArray {
                            for iii in 0..<results.count {
                                if let obb = returnAddressLatLong(lat, long, results, iii, addr) {
                                    return obb
                                }
                                break
                            }
                        }
                    }
                }
            }
        }
    } catch _ as NSError {
        return AddressObject(nil)
    }
    return AddressObject(nil)
}
func returnAddressLatLong(_ lat: NSNumber?, _ long: NSNumber?,
                          _ results: NSArray, _ iii: Int, _ addr: String?) -> AddressObject? {
    let addressObject = AddressObject(nil)
    
    if let dtt = results[iii] as? NSDictionary {
        //print("Address [\(dtt)]")
        if let dtt = results[iii] as? NSDictionary {
            if let address_components = dtt["address_components"] as? NSArray {
                for i in 0..<address_components.count {
                    let dt = address_components[i] as? NSDictionary
                    
                    if let types = dt!["types"] as? NSArray {
                        for j in 0..<types.count {
                            if let type = types[j] as? String {
                                if type == "postal_code" {
                                    addressObject.pincode = dt!["long_name"] as? String
                                } else if type == "locality" {
                                    addressObject.city = dt!["long_name"] as? String
                                } else if type == "sublocality_level_1" {
                                    addressObject.subaddress = dt!["long_name"] as? String
                                }
                            }
                        }
                        
                        if types.count == 2 {
                            if let o0 = types[0] as? String,
                                let o1 = types[1] as? String {
                                if o0 == "country" && o1 == "political" {
                                    addressObject.country = dt!.string("long_name")
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    if lat != nil && long != nil {
        if let dtt = results[iii] as? NSDictionary {
            let address = string(dtt, "formatted_address")
            addressObject.address = address
            return addressObject
        }
    } else if addr != nil {
        if let dtt = results[iii] as? NSDictionary {
            if let geometry = dtt["geometry"] as? NSDictionary {
                if let location = geometry["location"] as? NSDictionary {
                    let lat = number(location, "lat").doubleValue
                    let lng = number(location, "lng").doubleValue
                    if lat > 0 && lng > 0 {
                        addressObject.latitude = lat
                        addressObject.longitude = lng
                        return addressObject
                    }
                }
            }
        }
    }
    return nil
}
public class AddressObject {
    init(_ address: String?) {
        self.address = address
    }
    
    var latitude: Double? = 0.0
    var longitude: Double? = 0.0
    
    var type: String?
    
    var subaddress: String?
    var address: String?
    var city: String?
    var pincode: String?
    var country: String?
    var countryCode: String?
}

func langUIArabic (_ view: UIView?) {
    if view != nil {
        if view?.superview != nil {
            var frame1 = view!.frame
            frame1.origin.x = CGFloat((view?.superview?.frame.size.width)! - frame1.size.width - frame1.origin.x)
            view?.frame = frame1
        }
        for vvv in (view?.subviews)! {
            if vvv.tag == 100 {
                continue
            }
            if vvv is UIScrollView {
                langUIArabic(vvv)
            } else if vvv is UILabel
                || vvv is UITextField
                || vvv is UITextView
                || vvv is UIButton
                || vvv is UITableView
                || vvv is UITableViewCell
                || vvv is UIImageView
                || vvv is UISlider
                || vvv is UISearchBar
                || vvv is UIActivityIndicatorView
                || vvv is UISwitch
                || vvv is UISegmentedControl
                || vvv is UIProgressView
                || vvv is UIPageControl
                || vvv is UIStepper
                || vvv is UICollectionView
                || vvv is UICollectionViewCell
                || vvv is UIDatePicker
                || vvv is UIPickerView
                
                || vvv is UINavigationBar
                || vvv is UIToolbar
                || vvv is UITabBar
                || vvv is MKMapView {
                langWorkArabic (view, vvv)
            } else {
                langUIArabic(vvv)
            }
        }
    }
}
func langWorkArabic (_ view: UIView?, _ vvv: UIView) {
    if view is UIScrollView {
        let view = (view as? UIScrollView)!
        var frame = vvv.frame
        frame.origin.x = view.contentSize.width - frame.size.width - frame.origin.x
        vvv.frame = frame
    } else {
        var frame = vvv.frame
        frame.origin.x = (view?.frame.size.width)! - frame.size.width - frame.origin.x
        vvv.frame = frame
    }
    if vvv is UILabel {
        let vvv = (vvv as? UILabel)!
        if vvv.textAlignment == .left || vvv.textAlignment == .natural {
            vvv.textAlignment = .right
        } else if vvv.textAlignment == .right {
            vvv.textAlignment = .left
        }
    } else if vvv is UITextField {
        let vvv = (vvv as? UITextField)!
        if vvv.textAlignment == .left || vvv.textAlignment == .natural {
            vvv.textAlignment = .right
        } else if vvv.textAlignment == .right {
            vvv.textAlignment = .left
        }
    } else if vvv is UITextView {
        let vvv = (vvv as? UITextView)!
        if vvv.textAlignment == .left || vvv.textAlignment == .natural {
            vvv.textAlignment = .right
        } else if vvv.textAlignment == .right {
            vvv.textAlignment = .left
        }
    }
}

public func getAddressOrLatLongApple (_ lat: NSNumber?, _ long: NSNumber?,
                                 _ addr: String?, _ prnt: Bool, handler: @escaping (AddressObject?) -> Swift.Void) {
    let reach = ReachabilityKrishna.init(hostname: "google.com")
    if prnt {
        print("lat-\(String(describing: lat))-")
        print("long-\(String(describing: long))-")
        print("addr-\(String(describing: addr))-")
    }
    if lat == nil && long == nil && addr == nil {
        handler(nil)
    } else {
        if (reach?.isReachable)! {
            if lat == nil && long == nil {
                let ceo: CLGeocoder = CLGeocoder()
                
                ceo.geocodeAddressString(addr!) { (placemarks, error) in
                    //print("placemarks-\(placemarks)-")
                    //print("error-\(error)-")
                    
                    if (error != nil) {
                        //print("2 reverse geodcode fail: \(error!.localizedDescription)")
                        
                        //handler (nil, nil)
                        
                        let ob = AddressObject(nil)
                        
                        ob.address = addr
                        //ob.country = country
                        
                        handler(ob)
                    }
                    
                    if placemarks != nil {
                        let pm = placemarks! as [CLPlacemark]
                        if pm.count > 0 {
                            let pm = placemarks![0]
                            
                            let location = pm.location
                            
                            let ob = AddressObject(nil)
                            
                            if location != nil {
                                ob.latitude = location!.coordinate.latitude
                                ob.longitude = location!.coordinate.longitude
                            }
                            
                            ob.address = addr
                            ob.country = pm.country
                            ob.countryCode = pm.isoCountryCode
                            
                            handler(ob)
                        }
                    }
                }
                
            } else {
                getAddressFromLatLon((lat?.doubleValue)!, (long?.doubleValue)!) { (add, country) in
                    //print("getAddressFromLatLon Add-\(add)-\(country)-")
                    let ob = AddressObject(nil)
                    ob.address = add
                    ob.country = country
                    
                    handler(ob)
                }
            }
        } else {
            handler(nil)
        }
    }
}

func getAddressFromLatLon(_ lat: Double, _ lon: Double, handler: @escaping (String?, String?) -> Swift.Void) {
    var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    let ceo: CLGeocoder = CLGeocoder()
    
    center.latitude = lat
    center.longitude = lon
    
    let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
    
    ceo.reverseGeocodeLocation(loc, completionHandler:
                                {(placemarks, error) in
                                    if (error != nil) {
                                        //print("1 reverse geodcode fail: \(error!.localizedDescription)")
                                        
                                        handler (nil, nil)
                                    }
                                    
                                    if placemarks != nil {
                                        let pm = placemarks! as [CLPlacemark]
                                        
                                        if pm.count > 0 {
                                            let pm = placemarks![0]
                                            
                                            var addressString : String = ""
                                            
                                            if pm.subLocality != nil {
                                                addressString = addressString + pm.subLocality! + ", "
                                            }
                                            if pm.thoroughfare != nil {
                                                addressString = addressString + pm.thoroughfare! + ", "
                                            }
                                            if pm.locality != nil {
                                                addressString = addressString + pm.locality! + ", "
                                            }
                                            if pm.country != nil {
                                                addressString = addressString + pm.country! + ", "
                                            }
                                            if pm.postalCode != nil {
                                                addressString = addressString + pm.postalCode! + " "
                                            }
                                            
                                            handler (addressString, pm.country)
                                        }
                                        
                                    } else {
                                        handler (nil, nil)
                                    }
                                })
}
