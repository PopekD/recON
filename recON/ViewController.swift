import UIKit
import NotificationCenter

class ViewController: UIViewController{
    
    @IBOutlet var tableView: UITableView!
    var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        askforPermission()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {_ in
            self.tableView.reloadData()
            for i in updateTable.sorted(by: <){
                if i.1 <= Date(){
                    updateTable.removeValue(forKey: i.0)
                    tableTitle.removeValue(forKey: i.0)
                }
            }
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
        return updateTable.count
    }
}

extension ViewController:UITableViewDataSource{
    func tableView(_ tableVIew: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        print(tableTitle.sorted(by: >)[indexPath.row].1)
        cell.textLabel?.text = tableTitle.sorted(by: <)[indexPath.row].1

        dateFormatter.dateFormat = "YYYY/MM/dd hh:mm"
        cell.detailTextLabel?.text = "Will appear on \(dateFormatter.string(from:updateTable.sorted(by: <)[indexPath.row].1))"
        
        return cell
    }
}

let dateFormatter = DateFormatter()

