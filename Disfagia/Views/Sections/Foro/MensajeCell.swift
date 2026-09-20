import UIKit

class MensajeCell: UITableViewCell {
    let aliasLabel = UILabel()
    let mensajeLabel = UILabel()
    let bubbleView = UIView()

    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        aliasLabel.font = .systemFont(ofSize: 12, weight: .semibold)

        mensajeLabel.numberOfLines = 0
        mensajeLabel.font = .systemFont(ofSize: 16)
        mensajeLabel.textColor = .white

        bubbleView.layer.cornerRadius = 16
        bubbleView.translatesAutoresizingMaskIntoConstraints = false
        bubbleView.addSubview(aliasLabel)
        bubbleView.addSubview(mensajeLabel)

        aliasLabel.translatesAutoresizingMaskIntoConstraints = false
        mensajeLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(bubbleView)

        NSLayoutConstraint.activate([
            aliasLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 8),
            aliasLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 12),
            aliasLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -12),

            mensajeLabel.topAnchor.constraint(equalTo: aliasLabel.bottomAnchor, constant: 4),
            mensajeLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -8),
            mensajeLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 12),
            mensajeLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -12),

            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            bubbleView.widthAnchor.constraint(equalToConstant: 325)
        ])

        leadingConstraint = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        trailingConstraint = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
    }

    func configure(with mensaje: ForoMensaje) {
        mensajeLabel.text = mensaje.texto
        aliasLabel.text = mensaje.alias
        switch mensaje.usuario {
        case .paciente:
            bubbleView.backgroundColor = UIColor(white: 0.9, alpha: 1)
            mensajeLabel.textColor = .label
            aliasLabel.textColor = .secondaryLabel
        case .doctor:
            bubbleView.backgroundColor = UIColor.systemBlue
            aliasLabel.textColor = .white.withAlphaComponent(0.8)
        case .usuario:
            bubbleView.backgroundColor = UIColor.systemGreen
        }

        if mensaje.usuario == .usuario {
            trailingConstraint.isActive = true
            leadingConstraint.isActive = false
        } else {
            trailingConstraint.isActive = false
            leadingConstraint.isActive = true
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
