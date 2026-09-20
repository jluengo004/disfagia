import UIKit

class ForoTemaCell: UITableViewCell {
    let titleLabel = UILabel()
    let summaryLabel = UILabel()
    let infoLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 2

        infoLabel.font = .systemFont(ofSize: 12)
        infoLabel.textColor = .secondaryLabel
        infoLabel.textAlignment = .right

        let verticalStack = UIStackView(arrangedSubviews: [titleLabel, infoLabel])
        verticalStack.axis = .vertical
        verticalStack.spacing = 4
        verticalStack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(verticalStack)

        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            verticalStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            verticalStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            verticalStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with title: String, author: String, date: String) {
        titleLabel.text = title
        infoLabel.text = "\(author) • \(date)"
    }
}
