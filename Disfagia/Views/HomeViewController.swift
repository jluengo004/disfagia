import UIKit

// MARK: - HomeViewController
class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        setupUI()
    }

    private func setupUI() {
        let invent = Invent(inventDFD: "df")
        let coupons = Coupons(couponName: "hsuhd", invent: invent)
        let extraprams = ExtraParams(coupons: coupons,
                                     elementID: "adfa",
                                     relatedProduct: "daf")
        let sdjhsd = Invent(inventAaaaaa: <#T##Double?#>, inventDFD: <#T##String?#>)

        let event = StoretoolsProductIconEvent(productID: .the00001,
                                                contentCategory: "ijsd",
                                                extraParams: extraprams,
                                                location: "sfs")

        let dict = event.getBody()


        self.view.backgroundColor = .white
        self.navigationController?.isNavigationBarHidden = true
        
        let navbar = createCustomNavbar(back: false)
        view.addSubview(navbar)
        navbar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navbar.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: navbar.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 20
        container.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(container)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            container.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            container.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            container.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        // Aviso
        let aviso = UILabel()
        aviso.text = "AVISO: Se ha añadido una nueva funcionalidad llamada “IrudiGiltza” dentro del apartado de “Trámites”, que va a permitir la visualización de sus imágenes médicas si las ha solicitado previamente. Consulte las FAQ para más información."
        aviso.textColor = .systemRed
        aviso.font = .systemFont(ofSize: 14)
        aviso.numberOfLines = 0
        aviso.backgroundColor = .white
        aviso.layer.cornerRadius = 8
        aviso.layer.borderWidth = 1
        aviso.layer.borderColor = UIColor.systemGray4.cgColor
        aviso.setContentHuggingPriority(.defaultHigh, for: .vertical)
        aviso.setContentCompressionResistancePriority(.required, for: .vertical)
        aviso.padding(10)
        container.addArrangedSubview(aviso)

        // Actividad
        let actividadTitle = UILabel()
        actividadTitle.text = "Actividad"
        actividadTitle.font = .boldSystemFont(ofSize: 20)
        container.addArrangedSubview(actividadTitle)

        container.addArrangedSubview(makeActivityItem(
            date: "18 JUN 2025",
            title: "Videoconferencia con el Doctor Jon Doe",
            subtitle: "Tratamiento de disfagia",
            status: "Programada",
            icon: "video.circle"
        ))

        container.addArrangedSubview(makeActivityItem(
            date: "04 FEB 2025",
            title: "Otros agentes virales como causa de enfermedades clasificadas bajo otro concepto",
            subtitle: "Incapacidad temporal",
            status: "Cerrada",
            icon: "figure.walk.diamond"
        ))
        
        container.addArrangedSubview(makeActivityItem(
            date: "20 MAR 2024",
            title: "MEDICINA FAMILIAR (AP)",
            subtitle: "Analítica\nAmbulatorio Bombero Etxaniz",
            status: "Finalizada",
            icon: "drop.fill"
        ))

        // Botón Ver más
        let button = UIButton(type: .system)
        button.setTitle("Ver más", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        container.addArrangedSubview(button)
    }

    private func makeActivityItem(date: String, title: String, subtitle: String, status: String, icon: String) -> UIView {
        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.spacing = 4
        vStack.translatesAutoresizingMaskIntoConstraints = false

        let dateLabel = UILabel()
        dateLabel.text = date
        dateLabel.font = .systemFont(ofSize: 12, weight: .semibold)
        dateLabel.textColor = .systemBlue

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.numberOfLines = 0

        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0

        let statusLabel = UILabel()
        statusLabel.text = status
        statusLabel.font = .systemFont(ofSize: 14)
        statusLabel.textColor = .gray

        vStack.addArrangedSubview(dateLabel)
        vStack.addArrangedSubview(subtitleLabel)
        vStack.addArrangedSubview(titleLabel)
        vStack.addArrangedSubview(statusLabel)

        let iconView = UIImageView(image: UIImage(systemName: icon))
        iconView.tintColor = .systemBlue
        iconView.contentMode = .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.widthAnchor.constraint(equalToConstant: 30).isActive = true

        let hStack = UIStackView(arrangedSubviews: [iconView, vStack])
        hStack.axis = .horizontal
        hStack.spacing = 10
        hStack.alignment = .top

        let container = UIView()
        container.addSubview(hStack)
        hStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hStack.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
            hStack.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10),
            hStack.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10),
            hStack.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
        ])
        container.backgroundColor = .white
        container.layer.cornerRadius = 10
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.1
        container.layer.shadowRadius = 5
        container.layer.shadowOffset = .init(width: 0, height: 2)
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.systemGray4.cgColor

        return container
    }
}

// MARK: - Padding Extension
extension UILabel {
    func padding(_ value: CGFloat) {
        self.drawText(in: self.bounds.insetBy(dx: value, dy: value))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setContentHuggingPriority(.required, for: .vertical)
    }
}

