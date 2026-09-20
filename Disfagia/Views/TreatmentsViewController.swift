import UIKit
class TreatmentsViewController: UIViewController {
    private let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["En curso", "Finalizados"])
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()

    private let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tratamientos"
        view.backgroundColor = .systemBackground
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

        view.addSubview(segmentedControl)
        view.addSubview(tableView)

        segmentedControl.topAnchor.constraint(equalTo: navbar.bottomAnchor, constant: 10).isActive = true
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        setupLayout()
    }

    private func setupLayout() {
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func segmentChanged() {
        tableView.reloadData()
    }
}

let tratamientos = ["Disfagia", "Escuela de espalda", "Rinitis alérgica"]

extension TreatmentsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return segmentedControl.selectedSegmentIndex == 0 ? 3 : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tratamientos[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(DisfagiaHomeViewController(), animated: true)
    }
}
