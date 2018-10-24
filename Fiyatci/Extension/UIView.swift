//
//  UIView.swift
//  Fiyatci
//
//  Created by Tunc Tugcu on 23.10.2018.
//  Copyright © 2018 Tunc Tugcu. All rights reserved.
//

import UIKit

extension UIView {
    static func loadFromNib<T: UIView>() -> T {
        let name = String(describing: self)
        return Bundle.main.loadNibNamed(name, owner: nil, options: nil)![0] as? T ?? T()
    }
}
