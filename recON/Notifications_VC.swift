import UIKit
import NotificationCenter


class Notifications_VC: UIViewController{

    @IBOutlet var myTitle: UITextField!
    @IBOutlet var myBody: UITextField!
    @IBOutlet var saveBtnn: UIButton!
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTitle.becomeFirstResponder()
        myBody.becomeFirstResponder()
        datePicker.minimumDate = Date()
    }
    public static var vc_notifications = Notifications_VC()
    
    @IBAction func didTapSave(_ sender: UIButton) {
        if let titleText = myTitle.text, !titleText .isEmpty,
           let bodyText = myBody.text, !bodyText .isEmpty{
        
            let userDate = datePicker.date
            
            let new = MyNotification(title: titleText, date: userDate, content: bodyText, identifier: "id\(titleText)")
            models.append(new)

            let redirectHome = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
            view.window?.rootViewController = redirectHome
            view.window?.makeKeyAndVisible()
            
            let content = UNMutableNotificationContent()
            content.title = titleText
            content.sound = .default
            content.body = bodyText
            let targetDate = userDate
            let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year,.month,.day,.hour,.minute], from: targetDate), repeats: false)
            let request = UNNotificationRequest(identifier: titleText, content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: {error in
                if error != nil{
                    print(error!)
                }
            })
            
            
        }
    }
    


}

struct MyNotification{
    let title: String
    let date: Date
    let content: String
    var identifier: String
}
var models = [MyNotification]()

