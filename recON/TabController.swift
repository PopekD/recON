

import UIKit

class TabController: UITabBarController{
    
    @IBInspectable var initialIndex: Int = 0
    
    public static let tabcontroller = TabController()
    
    override func viewDidLoad(){
        super.viewDidLoad()
        selectedIndex = initialIndex
    }
    
}
