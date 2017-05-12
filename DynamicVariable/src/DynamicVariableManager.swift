//
//  DynamicVariableManager.swift
//  DynamicVariable
//
//  Created by Muronaka Hiroaki on 2017/05/12.
//  Copyright © 2017年 Muronaka Hiroaki. All rights reserved.
//

import UIKit
import Swifter

public class DynamicVariableManager {
    
    public static let shared = DynamicVariableManager()
    
    fileprivate var httpServer:HttpServer!
    fileprivate var dictionary = [String:AnyDynamicVariable]()
    
    public fileprivate(set) var errorHandler: ((Error) -> ())?
    
    init() {
    }
    
    @discardableResult
    public func onError(errorHandler: ((Error) -> ())?) -> Self {
        self.errorHandler = errorHandler
        return self
    }
    
    func add<T>(variable: DynamicVariable<T>) {
        dictionary[variable.name] = AnyDynamicVariable(bridge: variable)
    }
    
    func get<T>(name: String) -> DynamicVariable<T>? {
        guard let any = dictionary[name] else {
            return nil
        }
        return DynamicVariable<T>(bridge: any)
    }
    
    public func start(port: UInt16 = 8080) {
        if httpServer != nil {
            httpServer.stop()
        }
        
        httpServer = HttpServer()
        httpServer["/dv"] = { (request) -> HttpResponse in
            print("req \(request)")
            let jsonString = String(bytes: request.body, encoding: .utf8)!
            let jsonData = jsonString.data(using: .utf8, allowLossyConversion: false)!
            do {
                let jsonAny = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:String]
                guard let jsonDict = jsonAny, let name = jsonDict["name"], let value = jsonDict["value"] else {
                    return HttpResponse.badRequest(nil)
                }
                DispatchQueue.main.async { [unowned self] in
                    guard let dynamicVariable = self.dictionary[name] else {
                        return
                    }
                    let any = dynamicVariable.converter(value)
                    dynamicVariable.currentValue = any
                    dynamicVariable.callback?(any)
                }
            } catch {
                self.errorHandler?(error)
                return HttpResponse.badRequest(nil)
            }
            return HttpResponse.ok(.html("Success"))
        }
        try! httpServer.start(port)
        
        print("ipaddr: \(DynamicVariableUtil().getIPAddress())")
    }
    
}
