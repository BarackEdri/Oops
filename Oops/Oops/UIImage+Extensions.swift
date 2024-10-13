//
//  UIImage+Extensions.swift
//  Oops
//
//  Created by Barak Edry on 09/02/2024.
//

import Foundation
import UIKit

extension UIImage {
    func fixedOrientation() -> UIImage {
        if self.imageOrientation == .up {
            return self
        }
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: self.size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return normalizedImage
    }
}
