import UIKit

class WelcomeViewController: UIViewController {
    let rootView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "PlayNow.jpg"))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.frame  = UIScreen.main.bounds
        button.backgroundColor = .clear
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
        playButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        playButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        playButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        playButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @objc private func buttonAction() {
        launchTheGame()
    }
    
    private func launchTheGame() {
        let GameVC = GameViewController()
        GameVC.modalPresentationStyle = .fullScreen
        self.present(GameVC, animated: true)
    }
}

