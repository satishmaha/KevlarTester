//
//  AppDelegate.swift
//  KevlarTester
//
//  Created by satish on 5/3/16.
//  Copyright © 2016 Satish Maha Software. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate, DevMateKitDelegate {

    var window : NSWindow!

    @IBAction func startActivationProcess(sender: AnyObject?) {
        var error: Int = DMKevlarError.TestError.rawValue
        if !_my_secret_activation_check(&error) || DMKevlarError.NoError != DMKevlarError(rawValue: error)
        {
            DevMateKit.runActivationDialog(self, inMode: DMActivationMode.Sheet)
        }
        else
        {
            let license = _my_secret_license_info_getter().takeUnretainedValue() as NSDictionary
            let licenseSheet = NSAlert()
            licenseSheet.messageText = "Your application is already activated."
            licenseSheet.informativeText = "\(license.description)"
            licenseSheet.addButtonWithTitle("OK")
            licenseSheet.addButtonWithTitle("Invalidate License")
            licenseSheet.beginSheetModalForWindow(self.window, completionHandler: { (response) -> Void in
                if response == NSAlertSecondButtonReturn
                {
                    InvalidateAppLicense()
                }
            })
        }
    }

}