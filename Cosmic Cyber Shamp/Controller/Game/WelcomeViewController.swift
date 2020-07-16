import UIKit

class WelcomeViewController: UIViewController {
    let rootView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "initial_main_bg"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 60)
        button.setTitle("Play", for: .normal)
        button.setImage(UIImage(named: ""), for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        
        view.addSubview(playButton)
        playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc private func buttonAction() {
        print("Button pressed")
    }
    
    private func launchTheGame() {
        let gameVC = GameViewController()
        gameVC.modalPresentationStyle = .fullScreen
        gameVC.present(gameVC, animated: true)
    }
}

