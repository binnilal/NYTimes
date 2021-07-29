//
//  AppConfig.swift
//  New York Times
//
//  Created by Binnilal on 29/07/2021.
//

import Foundation

class AppConfig: NSObject {
    
    static var isRunningTests : Bool {
        get {
            return NSClassFromString("XCTest") != nil;
        }
    }
}
