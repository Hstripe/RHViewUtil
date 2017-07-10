//
// Created by 黄睿 on 2017/7/10.
// Copyright (c) 2017 Doliant. All rights reserved.
//

import UIKit

typealias coordinateTrans = UIView
extension coordinateTrans {
    var width: CGFloat {
        set { frame.size.width = newValue }
        get { return frame.size.width }
    }

    var height: CGFloat {
        set { frame.size.height = newValue }
        get { return frame.size.height }
    }

    var x: CGFloat {
        set { frame.origin.x = newValue }
        get { return frame.origin.x }
    }

    var y: CGFloat {
        set { frame.origin.y = newValue }
        get { return frame.origin.y }
    }

}
