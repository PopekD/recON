import UIKit
import NotificationCenter

class ViewController: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        askforPermission()
    }
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            
        }
    }
    public static var vc_table = ViewController()
    
    func askforPermission(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {granted, error in
            if let error = error{
                print(error)
            }
        })
    }
}

extension ViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableVIew: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        dateFormatter.dateFormat = "YY/MM/dd hh:mm"
        cell.detailTextLabel?.text = "Will appear on \(dateFormatter.string(from:models[indexPath.row].date))"
        return cell
    }
}

let dateFormatter = DateFormatter()

