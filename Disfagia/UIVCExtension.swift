import UIKit

extension UIViewController {
    func createCustomNavbar(back: Bool) -> UIView {
        let container = UIView()
        container.backgroundColor = UIColor.systemIndigo

        let menuIcon = UILabel()
        menuIcon.text = "☰"
        if back {
            menuIcon.text = "Atrás"
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissSelf))
//            menuIcon.addGestureRecognizer(tapGesture)
        }
        menuIcon.font = .systemFont(ofSize: 24, weight: .bold)
        menuIcon.textColor = .white

        let logoImage = UIImageView(image: UIImage(systemName: "cross.case"))
        logoImage.tintColor = .white
        logoImage.contentMode = .scaleAspectFit
        logoImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 30).isActive = true

        let logoText = UILabel()
        logoText.text = "CARPETA de SALUD"
        logoText.textColor = .white
        logoText.font = .systemFont(ofSize: 14, weight: .semibold)

        let logoStack = UIStackView(arrangedSubviews: [logoImage, logoText])
        logoStack.axis = .horizontal
        logoStack.spacing = 5
        logoStack.alignment = .center

        let langLabel = UILabel()
        langLabel.text = "ES | EU"
        langLabel.font = .systemFont(ofSize: 14, weight: .medium)
        langLabel.textColor = .white
        langLabel.textAlignment = .right

        let userIcon = UIImageView(image: UIImage(systemName: "person.circle"))
        userIcon.tintColor = .white
        userIcon.contentMode = .scaleAspectFit
        userIcon.widthAnchor.constraint(equalToConstant: 24).isActive = true
        userIcon.heightAnchor.constraint(equalToConstant: 24).isActive = true

        let userLabel = UILabel()
        userLabel.text = "NOMBRE"
        userLabel.font = .systemFont(ofSize: 14)
        userLabel.textColor = .white

        let userStack = UIStackView(arrangedSubviews: [userIcon, userLabel])
        userStack.axis = .horizontal
        userStack.spacing = 5
        userStack.alignment = .center

        let rightStack = UIStackView(arrangedSubviews: [langLabel, userStack])
        rightStack.axis = .vertical
        rightStack.alignment = .trailing
        rightStack.spacing = 2

        let mainStack = UIStackView(arrangedSubviews: [menuIcon, logoStack, rightStack])
        mainStack.axis = .horizontal
        mainStack.spacing = 10
        mainStack.alignment = .center
        mainStack.distribution = .equalSpacing
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        container.addSubview(mainStack)
        mainStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 10).isActive = true
        mainStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16).isActive = true
        mainStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16).isActive = true
        mainStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10).isActive = true

        return container
    }
}
