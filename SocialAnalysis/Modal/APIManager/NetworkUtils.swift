//
//  NetworkUtils.swift
//  Svideo
//
//  Created by Pacific Ocean on 8/18/17.
//  Copyright © 2017 Minori. All rights reserved.
//

import UIKit
import Alamofire

enum BackendError: Error {
    case network(reason: String) // Capture any underlying Error from the URLSession API
    case jsonSerialization(reason: String)
    case jsonStructure(reason: String)
    case server(reason: String)
}

open class NetworkUtils {
    // MARK: - Variables
    var headers: HTTPHeaders?
    var timeout = REQUEST.TIME_OUT
    let manager: SessionManager?
    
    // MARK: - Init
    // Singleton Instance
    class var sharedInstance: NetworkUtils {
        struct Static {
            static let instance = NetworkUtils()
        }
        return Static.instance
    }
    
    init() {
        self.manager = Alamofire.SessionManager.default
        self.setHeaderDefault()
    }
    
    // MARK: - Headers
    func setHeaderDefault() {
       // clearHeaders()
        print("\n")
    }
    
    open func clearHeaders() {
        if headers != nil {
            headers?.removeAll()
        }
    }
    
    open func addHeader(for dictionary: [String: String], clearFirst check: Bool) {
        if check {
            clearHeaders()
        }
        for (key, value) in dictionary {
            if headers == nil {
                setHeaderDefault()
            }
            if headers![key] != nil {
                headers![key] = value
            } else {
                headers!.updateValue(value, forKey: key)
            }
        }
    }
    
    // MARK: - Timeout
    open func setTimeout(for timeout:Int) {
        self.timeout = timeout
    }
    
    // MARK: - Clear
    open func cancelAllRequest(completion: @escaping () -> Void) {
        self.manager?.session.getTasksWithCompletionHandler {
            (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
            completion()
        }
    }
    
    // MARk: - Request DELETE
    func deleteRequest(_ strURL: String,
                     parameter:RequestProtocol,
                     header:HTTPHeaders?,
                     success:@escaping (Any?) -> Void,
                     failure:@escaping (Error?) -> Void){
        requestService(strURL, method: .delete, parameters: parameter.toDict(), headers: header, encoding: nil, success: { (response) in
            success(response)
        }) { (error) in
            failure(error)
        }
    }
    
    // MARk: - Request POST
    func postRequest(_ strURL: String,
                     parameter:RequestProtocol,
                     header:HTTPHeaders?,
                     success:@escaping (Any?) -> Void,
                     failure:@escaping (Error?) -> Void){
        requestService(strURL, method: .post, parameters: parameter.toDict(), headers: header, encoding: nil, success: { (response) in
            success(response)
        }) { (error) in
            failure(error)
        }
    }
    
    
    
    // MARk: - Request Get
    func getRequest(_ strURL: String,
                    headers:HTTPHeaders?,
                    parameters: [String: Any]? = nil,
                    success:@escaping (Any?) -> Void,
                    failure:@escaping (Error?) -> Void){
        requestService(strURL, method: .get, parameters: parameters, headers: headers, encoding: nil, success: { (response) in
            success(response)
        }) { (error) in
            failure(error)
        }
    }
    
    // MARk: - Request
    func requestService(_ strURL: String,
                        method httpmethod: HTTPMethod,
                        parameters params:[String:Any]?,
                        headers header:HTTPHeaders?,
                        encoding encode:ParameterEncoding?,
                        success:@escaping (Any?) -> Void,
                        failure:@escaping (Error?) -> Void) {
        if header == nil {
            setHeaderDefault()
        }
        var headersLocal = headers;
        if let headerVal = header {
            headersLocal = headerVal
        }
        // Set configuration
        // Timeout
        manager?.session.configuration.timeoutIntervalForRequest = TimeInterval(timeout)
        
        // Request
        manager?.request(strURL,
                         method: httpmethod,
                         parameters: params,
                         encoding: (encode == nil ? JSONEncoding.default : encode!),
                         headers: headersLocal).responseJSON(completionHandler: { (response) in
                            switch response.result {
                            case .success( _):
                                if response.result.value != nil{
                                    success(response.result.value)
                                }
                                else {
                                    failure(nil)
                                }
                                break
                            case .failure(let err):
                                failure(err as NSError?)
                                break
                            }
                         })
    }


    func uploadService(_ strURL: String,
                       method httpmethod: HTTPMethod = .get,
                       parameters params:[String:Any]?,
                       image img:Data?,
                       imageKey key:String,
                       imagename imgName:String,
                       headers header:HTTPHeaders?,
                       encoding encode:ParameterEncoding?,
                       success:@escaping (Any?) -> Void,
                       failure:@escaping (Error?) -> Void) {
        if header == nil {
            setHeaderDefault()
        }
        var headersLocal = headers;
        if let headerVal = header {
            headersLocal = headerVal
        }
        //headersLocal?[HEADER_API.CONTENT_TYPE] = HEADER_API.TYPE_MULTIPART
        // Set configuration
        // Timeout
        manager?.session.configuration.timeoutIntervalForRequest = TimeInterval(timeout)
        
        
        // upload
        manager?.upload(multipartFormData: { multipartFormData in
            if img != nil {
                multipartFormData.append(img!, withName: key, fileName: String.init(format: "%@.png", imgName), mimeType: "image/png")
            }
            
            if let parameters = params {
                print("\n\n")
                print("Parameters")
                for (key, value) in parameters {
                    if let valueString = value as? String,
                        let data = valueString.data(using: String.Encoding.utf8) {
                        print("     \(key) : \(value)")
                        multipartFormData.append(data, withName: key)
                    }
//                    multipartFormData.append((value as! String).data(using: String.Encoding.utf8)!, withName: key)
                }
            }
        },usingThreshold: UInt64.init(),
          to: strURL, method: httpmethod,
          headers: headersLocal,
          encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success( _):
                        if response.result.value != nil
                        {
                            success(response.result.value)
                        }
                        else {
                            failure(nil)
                        }
                        break
                    case .failure(let err):
                        failure(err as NSError?)
                        break
                    }
                })
            case .failure(let encodingError):
                failure(encodingError)
                break
            }
        })
    }

}
