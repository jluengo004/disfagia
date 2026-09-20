import UIKit

protocol NotificacionCellDelegate: AnyObject {
    func navigateToTratamientos()
}

class NotificacionCell: UITableViewCell, UITextViewDelegate {
    weak var delegate: NotificacionCellDelegate?
    
    let detallesExtra: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.dataDetectorTypes = [.link]
        textView.linkTextAttributes = [
            .foregroundColor: UIColor.systemBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let detalleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    var infoAdicionalCallback: (() -> Void)?
    
    private let infoAdicionalButton: UIButton = {
        let infoAdicionalButton = UIButton(type: .system)
        infoAdicionalButton.setTitle("📎 Cuestionario", for: .normal)
        infoAdicionalButton.isHidden = true
        return infoAdicionalButton
    }()
    
    private let badgeLabel: UILabel = {
        let label = UILabel()
        label.text = "No visualizada"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.backgroundColor = UIColor.systemIndigo
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contenidoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemIndigo
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    private let contenedor: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor.systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let innerStack = UIStackView()
    private let verticalStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with notif: Notificacion) {
        let texto = "\(notif.fecha) - \(notif.texto)"
        contenidoLabel.text = "📎" + texto
        badgeLabel.isHidden = notif.visualizada
        detalleLabel.text = notif.detalles
        detalleLabel.isHidden = !notif.isExpanded
        detallesExtra.attributedText = notif.detallesExtra
        detallesExtra.isHidden = !notif.isExpanded
        detallesExtra.delegate = self
        infoAdicionalButton.isHidden = !(notif.isExpanded && notif.tieneAdjunto)
        infoAdicionalButton.addTarget(self, action: #selector(infoAdicionalTapped), for: .touchUpInside)
    }
    
    @objc private func infoAdicionalTapped() {
        infoAdicionalCallback?()
    }
    
    private func setupLayout() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(contenedor)
        contenedor.addSubview(badgeLabel)
        
        verticalStack.axis = .vertical
        verticalStack.spacing = 6
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        
        innerStack.axis = .horizontal
        innerStack.spacing = 8
        innerStack.alignment = .top
        innerStack.translatesAutoresizingMaskIntoConstraints = false
        
        innerStack.addArrangedSubview(contenidoLabel)
        
        verticalStack.addArrangedSubview(innerStack)
        verticalStack.addArrangedSubview(detalleLabel)
        verticalStack.addArrangedSubview(detallesExtra)
        verticalStack.addArrangedSubview(infoAdicionalButton)
        
        contenedor.addSubview(verticalStack)
        
        NSLayoutConstraint.activate([
            contenedor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            contenedor.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            contenedor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contenedor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            badgeLabel.topAnchor.constraint(equalTo: contenedor.topAnchor, constant: -8),
            badgeLabel.leadingAnchor.constraint(equalTo: contenedor.leadingAnchor, constant: 12),
            badgeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            verticalStack.topAnchor.constraint(equalTo: badgeLabel.bottomAnchor, constant: 8),
            verticalStack.leadingAnchor.constraint(equalTo: contenedor.leadingAnchor, constant: 12),
            verticalStack.trailingAnchor.constraint(equalTo: contenedor.trailingAnchor, constant: -12),
            verticalStack.bottomAnchor.constraint(equalTo: contenedor.bottomAnchor, constant: -12)
        ])
    }

    func textView(_ textView: UITextView,
                  shouldInteractWith URL: URL,
                  in characterRange: NSRange,
                  interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "app://goToTratamientos" {
            delegate?.navigateToTratamientos()
            return false
        }
        return true
    }
}
