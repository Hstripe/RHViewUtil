//
//  RHAppUtil.swift
//  RHViewUtil
//
//  Created by 黄睿 on 2017/7/3.
//  Copyright © 2017年 Doliant. All rights reserved.
//

import Foundation
import UIKit

class RHAppUtil {
    
    // MARK: SYSTEM
    class var deviceType: String {
        return UIDevice.current.detailModel
    }
    
    class var systemVersion: String {
        return UIDevice.current.systemVersion
    }
    // MARK: APP
    class var appDisplayName: String {
        guard let displayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String else {
            return "获取DisplayName失败"
        }
        return displayName
    }
    
    class var appBuildVersion: String {
        guard let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else {
            return "获取BundleVersion失败"
        }
        return buildVersion
    }
    
    class var  appBundleID: String {
        guard let bundleID = Bundle.main.bundleIdentifier else {
            return "获取bundleID失败"
        }
        return bundleID
    }
    
    class var appVersion: String {
        guard let appversion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else {
            return "获取APP版本失败"
        }
        return appversion
    }
    
    class var appLanguage: String {
        let userDefaults = UserDefaults.standard
        let language = userDefaults.object(forKey: "AppleLanguages") as? Array<Any>
        guard  let preferLanguage = language else {
            return "获取系统设定语言失败"
        }
        let sysLanguage = preferLanguage[0] as! String
        return sysLanguage
    }
    
    class var appNetworkType: String {
        let statusBar = UIApplication.shared.value(forKeyPath: "statusBar") as! UIView
        let foregroundView = (statusBar.value(forKeyPath: "foregroundView") as! UIView).subviews
        var netType = 0
        for view in foregroundView {
            let className = String(describing: view.classForCoder)
            if className == "UIStatusBarDataNetworkItemView" {
                netType = view.value(forKeyPath: "dataNetworkType") as! Int
                switch netType {
                case 0:
                    return "网络无连接"
                case 1:
                    return "2G"
                case 2:
                    return "3G"
                case 3:
                    return "4G"
                case 5:
                    return "WIFI"
                default:
                    return "未知"
                }
            }
        }
        
        return ""
    }
    
    class var appIDFV: String {
        guard let idfv = UIDevice.current.identifierForVendor?.uuidString else {
            return "获取IDFV失败"
        }
        
        return idfv
    }
    
    class var currentTimeStamp: String {
        let nowInterval = Date().timeIntervalSince1970
        let result = String(describing: Int(nowInterval))
        return result
    }
    
    class func hasNewVersion(_ recentVersion: String) -> Bool {
        let appVersion = (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)?.replacingOccurrences(of: ".", with: "")
        let serverVersion = recentVersion.replacingOccurrences(of: ".", with: "")
        let appVersionNumber = Int(appVersion!)
        let serverVersionNumber = Int(serverVersion)
        return appVersionNumber! - serverVersionNumber! <= 0
    }
}

extension UIDevice {
    var detailModel: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPhone4,1":              return "iPhone4s"
        case "iPhone5,1","iPhone5,2":  return "iPhone5"
        case "iPhone5,3","iPhone5,4":  return "iPhone5c"
        case "iPhone6,1","iPhone6,2":  return "iPhone5s"
        case "iPhone7,1":              return "iPhone6 Plus"
        case "iPhone7,2":              return "iPhone6"
        case "iPhone8.1":              return "iPhone6s"
        case "iPhone8,2":              return "iPhone6s Plus"
        case "iPhone8,3","iPhone8,4":  return "iPhoneSE"
        case "iPhone9,1":              return "iPhone7"
        case "iPhone9,2":              return "iPhone7 Plus"
        case "X86_64","i386":          return "Simulator"
        case "iPod1,1","iPod2,1",
             "iPod3,1","iPod4,1",
             "iPod5,1","iPod6,1":      return "iPod Touch"
        case "iPad2,1","iPad2,2",
             "iPad2,3","iPad2,4":      return "iPad2"
        case "iPad3,1","iPad3,2",
             "iPad3,3":                return "iPad3"
        case "iPad3,4","iPad3,5",
             "iPad3,6":                return "iPad4"
        case "iPad4,1","iPad4,2",
             "iPad4,3":                return "iPad Air"
        case "iPad5,3","iPad5,4":      return "iPad Air2"
        case "iPad6,3","iPad6,4":      return "iPad Pro(9.7)"
        case "iPad6,7","iPad6,8":      return "iPad Pro(12.9)"
        case "iPad2,5","iPad2,6",
             "iPad2,7":                return "iPad mini"
        case "iPad4,4","iPad4,5",
             "iPad4,6":                return "iPad mini2"
        case "iPad4,7","iPad4,8",
             "iPad4,9":                return "iPad mini3"
        case "iPad5,1","iPad5,2":      return "iPad mini4"
        default:                       return identifier
        }
    }
}





