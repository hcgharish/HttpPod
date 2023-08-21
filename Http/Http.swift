//
//  Http.swift
//  SupportingProject
//
//  Created by Harish on 16/01/18.
//  Copyright © 2018 Harish. All rights reserved.
//
import UIKit
let kCouldnotconnect = "Could not connect to the server. Please try again later."
let kInternetNotAvailable = "Please establish network connection."
open class Http: NSObject {
    open class func instance () -> Http {
        return Http()
    }
    
    public func request (_ par: HttpParams,
                         completionHandler: @escaping (HttpResponse?) -> Swift.Void) {
        let httpParams = par
        
        if par.aPIMethod == .get {
            httpParams.setMethod ("GET")
        } else if par.aPIMethod == .post {
            httpParams.setMethod ("POST")
        } else if par.aPIMethod == .delete {
            httpParams.setMethod ("DELETE")
        } else {
            httpParams.setMethod ("POST")
        }
        
        self.jsonWithParamObject(httpParams) { (httpResourse) in
            DispatchQueue.main.async {
                completionHandler(httpResourse)
            }
        }
    }
    func sessionConfig () -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 40.0
        config.timeoutIntervalForResource = 40.0
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return config
    }
    public func jsonWithParamObject (_ httpParams: HttpParams, completionHandler: @escaping (HttpResponse?) -> Swift.Void) {
        let reach = ReachabilityKrishna.init(hostname: "google.com")
        if (reach?.isReachable)! {
            if httpParams.aai {
                startActivityIndicator()
            }
            let request = makeDecision (httpParams)
            addHeader (request, httpParams)
            
            let config = sessionConfig ()
            let session = URLSession(configuration: config)
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
                let httpObject = HttpObject(completionHandler)
                httpObject.completionHandler = completionHandler
                httpObject.data = data
                httpObject.response = response
                httpObject.error = error
                httpObject.api = httpParams.api
                httpObject.params = httpParams.params
                httpObject.aai = httpParams.aai
                httpObject.popup = httpParams.popup
                httpObject.prnt = httpParams.prnt
                if error != nil {
                    if httpParams.aai {
                        self.stopActivityIndicator()
                    }
                }
                
                DispatchQueue.global().async {
                    self.jsonThread(httpObject)
                }
            })
            task.resume()
        } else {
            if httpParams.aai {
                stopActivityIndicator()
            }
            if httpParams.popup {
                alert("Network message!", kInternetNotAvailable)
            }
            let httpResponse = HttpResponse(nil)
            httpResponse.params = httpParams.params
            completionHandler (httpResponse)
        }
    }
    func makeDecision (_ httpParams: HttpParams) -> NSMutableURLRequest {
        var request = NSMutableURLRequest(url:
            NSURL(string: (httpParams.api!.addingPercentEncoding(
                withAllowedCharacters: .urlQueryAllowed)!))! as URL)
        if httpParams.getMethod() == "GET" && httpParams.params != nil {
            var url = httpParams.api! + "?"
            for (key, value) in httpParams.params! {
                url += "\((key as? String)!)=\(value)&"
            }
            request = NSMutableURLRequest(url:
                NSURL(string: (url.addingPercentEncoding(withAllowedCharacters:
                    .urlQueryAllowed)!))! as URL)
        } else if httpParams.getMethod() == "POST" {
            request.httpMethod = httpParams.getMethod()!
            
            var data: Data! = Data()
            do {
                if httpParams.params == nil {
                    data = try JSONSerialization.data(withJSONObject: [], options: [])
                    request.httpBody = data
                } else if httpParams.getMethod() == "POST" {
                    createBody(request, httpParams)
                }
            } catch {
                if httpParams.aai {
                    stopActivityIndicator()
                }
                print("JSON serialization failed:  \(error)")
            }
        } else if let method = httpParams.getMethod(), method.count > 0  {
            request.httpMethod = httpParams.getMethod()!
        } else if httpParams.getMethod() == nil || httpParams.params == nil || httpParams.getMethod() == "GET" {
            
        }
        
        return request
    }
    func addHeader (_ request: NSMutableURLRequest, _ httpParams: HttpParams) {
        if httpParams.prnt {
            print("Header \(String(describing: httpParams.header))")
        }
        
        if httpParams.header != nil {
            if (httpParams.header?.count)! > 0 {
                for (key, _) in httpParams.header! {
                    request.setValue(httpParams.header?.object(forKey: key) as? String, forHTTPHeaderField: "\(key)")
                }
            }
        }
    }
    func createBody(_ request: NSMutableURLRequest, _ httpParams: HttpParams) {
        
        let para = httpParams.params as? [String: Any]
        
        let form_data = "form-data"
        //let form_data = "x-www-form-urlencoded"
        
        if httpParams.images != nil {
            let boundary = generateBoundaryString()
            
            let data = NSMutableData()
            
            request.setValue("multipart/\(form_data); boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            for (key, value) in para! {
                data.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                data.append("Content-Disposition: \(form_data); name=\"\(key)\"\r\n\r\n".data(using: String.Encoding.utf8)!)
                data.append("\(value)\r\n".data(using: String.Encoding.utf8)!)
            }
            
            for iii in 0..<(httpParams.images?.count)! {
                let filename = "user-profile_\(Date().getStringDate("yyyy_MM_dd_HH_mm_ss_SSS"))_.jpg"
                
                let mdd = (httpParams.images?[iii] as? NSMutableDictionary)!
                let param = (mdd["param"] as? String)!
                let image = (mdd["image"] as? UIImage)!
                
                print("Uploading images for -\(param)-\(filename)-")
                
                let imageData = image.resize(640).jpegData(compressionQuality: 1)
                
                data.append("--\(boundary)\r\n".data(using: String.Encoding.utf8)!)
                data.append("Content-Disposition: \(form_data); name=\"\(param)\"; filename=\"\(filename)\"\r\n".data(using: String.Encoding.utf8)!)
                data.append("Content-Type: application/octet-stream\r\n\r\n".data(using: String.Encoding.utf8)!)
                data.append(imageData!)
                data.append("\r\n".data(using: String.Encoding.utf8)!)
            }
            
            data.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
            
            request.httpBody = data as Data
        } else {
            request.httpBody = para!.percentEscaped().data(using: .utf8)
        }
    }
    public func jsonThread(_ httpObject: HttpObject) {
        if httpObject.error != nil {
            printError(httpObject)
        } else {
            printSuccess(httpObject)
        }
        if httpObject.aai {
            stopActivityIndicator ()
        }
    }
    public func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
            }
            .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

