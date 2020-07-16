import UIKit

class WelcomeViewController: UIViewController {
    let rootView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "initial_main_bg"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGUI()
    }
    
    private func loadGUI() {
        view.addSubview(rootView)
        rootView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rootView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        rootView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        rootView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func launchTheGame() {
        let gameVC = GameViewController()
        gameVC.modalPresentationStyle = .fullScreen
        gameVC.present(gameVC, animated: true)
    }
}

