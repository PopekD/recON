import UIKit
import NotificationCenter


class Notifications_VC: UIViewController{

    @IBOutlet var myTitle: UITextField!
    @IBOutlet var myBody: UITextField!
    @IBOutlet var saveBtnn: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTitle.delegate = self
        myBody.delegate = self
        datePicker.minimumDate = Date()
    }
    public static var vc_notifications = Notifications_VC()
    @IBAction func didTapSave(_ sender: UIButton) {
        if let titleText = myTitle.text, !titleText .isEmpty,
           let bodyText = myBody.text, !bodyText .isEmpty{
        
            let userDate = datePicker.date
            let new = Mystruct(count_v: 1)
            models.append(new)
            updateTable.updateValue(userDate, forKey: models.count)
            tableTitle.updateValue(titleText, forKey: models.count)
            
            
            
            let redirectHome = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
            view.window?.rootViewController = redirectHome
            view.window?.makeKeyAndVisible()
            
            
            
            let content = UNMutableNotificationContent()
            content.title = titleText
            content.sound = .default
            content.body = bodyText
            let targetDate = Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: userDate)
            let trigger = UNCalendarNotificationTrigger(dateMatching: targetDate, repeats: false)
            let request = UNNotificationRequest(identifier: titleText, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
                if error != nil{
                    print(error!)
                }
            })
        }
    }
}
extension Notifications_VC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        myTitle.resignFirstResponder()
        myBody.resignFirstResponder()
        return true
    }
}
struct Mystruct{
    var count_v:Int
}
var models = [Mystruct]()
var tableTitle:[Int:String] = [:]
var updateTable:[Int:Date] = [:]
