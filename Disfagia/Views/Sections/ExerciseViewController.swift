import UIKit

class ExerciseViewController: UIViewController {
    let mainStack = UIStackView()

    let dailyExercises = ["Mendelshon", "Masako"]
    let freeExercises = ["Cabeza abajo", "Shaker", "Esfuerzo voluntario", "Supraglótico", "Super-Supraglótico", "Tongue Hold", "Effortful Pitch Glide", "Lingual Resistance", "Expiratory Muscle Strength"]

    var completedExercises: Set<String> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ejercicios Disfagia"
        view.backgroundColor = .systemBackground

        mainStack.axis = .vertical
        mainStack.spacing = 24
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(mainStack)

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mainStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        // Sección 1: Ejercicios Diarios
        addExerciseSection(title: "Ejercicios Diarios", exercises: dailyExercises, useCheckbox: true)

        // Sección 2: Ejercicios Libres
        addExerciseSection(title: "Ejercicios Libres", exercises: freeExercises, useCheckbox: false)
    }

    func addExerciseSection(title: String, exercises: [String], useCheckbox: Bool) {
        let sectionLabel = UILabel()
        sectionLabel.text = title
        sectionLabel.font = .boldSystemFont(ofSize: 20)

        let sectionStack = UIStackView()
        sectionStack.axis = .vertical
        sectionStack.spacing = 16

        mainStack.addArrangedSubview(sectionLabel)
        mainStack.addArrangedSubview(sectionStack)

        exercises.forEach { name in
            let button = UIButton(type: .system)
            let displayTitle = useCheckbox
                ? "\u{2610} \(name)"
                : name
            button.setTitle(displayTitle, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 18)
            button.contentHorizontalAlignment = .left
            button.tag = useCheckbox ? 1 : 0
            button.addTarget(self, action: #selector(exerciseTapped(_:)), for: .touchUpInside)
            sectionStack.addArrangedSubview(button)
        }
    }

    @objc func exerciseTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal)?.components(separatedBy: " ").last else { return }

        let playerVC = ExerciseVideoViewController(exerciseName: title) { [weak self] in
            guard sender.tag == 1 else { return } // Solo marcar si es diario
            sender.setTitle("\u{2611} \(title)", for: .normal)
            self?.completedExercises.insert(title)
            if self?.completedExercises.count == 2 {
                let formularioVC = EncuestaViewController()
                let navVC = UINavigationController(rootViewController: formularioVC)
                self?.present(navVC, animated: true)
            }
        }

        present(playerVC, animated: true)
    }
}
