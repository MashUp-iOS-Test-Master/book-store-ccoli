//
//  UIDevice+Extension.swift
//  book-store-ccoli
//
//  Created by 최혜린 on 2022/11/01.
//

import AudioToolbox
import UIKit

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(1521)
    }
}
