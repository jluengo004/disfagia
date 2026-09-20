import UIKit
import AVKit

class ExerciseVideoViewController: AVPlayerViewController {
    var onFinish: (() -> Void)?

    init(exerciseName: String, onFinish: @escaping () -> Void) {
        super.init(nibName: nil, bundle: nil)
        self.onFinish = onFinish

        if let path = Bundle.main.path(forResource: exerciseName, ofType: "mp4") {
            let url = URL(fileURLWithPath: path)
            self.player = AVPlayer(url: url)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinish), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func playerDidFinish() {
        dismiss(animated: true) {
            self.onFinish?()
        }
    }
}

extension UIApplication {
    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }
    }
}
