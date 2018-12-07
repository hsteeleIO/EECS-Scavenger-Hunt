import UIKit

class Player2ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let levels = ["Level 1", "Level 2", "Level 3", "Level 4", "Level 5", "Level 6"]
    let player1 = [false, false, false, false, false, false]
    let player2 = [false, false, false, false, false, false]
    
    let lvlObjects = ["Player 1 Complete", "Player 2 Complete", "Solve"]
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = lvlObjects[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return levels[section]
    }
    
    
    @IBOutlet weak var connectionsLabel: UILabel!
    
    let colorService = ColorService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorService.delegate = self
    }
    
    func changeColor(color : UIColor) {
        UIView.animate(withDuration: 0.2) {
            self.view.backgroundColor = color
        }
    }
    
    //Hint Label
    
    @IBOutlet weak var lab: UILabel!
    @IBOutlet weak var textf: UITextField!
    
    @IBAction func sendTF(_ sender: Any) {
        lab.text = textf.text
        colorService.send(hint: textf.text!)
    }
    
    func changeText(text : String) {
        lab.text = text
    }
    
}

extension Player2ViewController : ColorServiceDelegate {
    
    func connectedDevicesChanged(manager: ColorService, connectedDevices: [String]) {
        OperationQueue.main.addOperation {
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    func hintChanged(manager: ColorService, hint: String) {
        OperationQueue.main.addOperation {
            self.changeText(text: hint)
        }
    }
    
}
