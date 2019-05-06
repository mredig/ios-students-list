//
//  MainViewController.swift
//  Students
//
//  Created by Michael Redig on 5/6/19.
//  Copyright © 2019 Lambda Inc. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

	@IBOutlet weak var sortSelector: UISegmentedControl!

	private let networkClient = NetworkClient()
	private var studentsTableViewController: StudentsTableViewController!

	private var students: [Student] = []

    override func viewDidLoad() {
        super.viewDidLoad()

		networkClient.fetchStudents { (students, error) in
			if let error = error {
				print("Error loading students: \(error)")
				return
			}

			DispatchQueue.main.async {
				self.students = students ?? []
			}
		}
    }

	private func updateSort() {
		let sortedStudents: [Student]
		switch sortSelector.selectedSegmentIndex {
		case 0:
			sortedStudents = students.sorted { $0.firstName < $1.firstName }
		case 1:
			sortedStudents = students.sorted {
				($0.lastName ?? "") < ($1.lastName ?? "")
			}
		default:
			sortedStudents = students.sorted {
				($0.lastName ?? "") < ($1.lastName ?? "")
			}
		}
		studentsTableViewController.students = sortedStudents
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "EmbedStudentsTableView" {
			guard let dest = segue.destination as? StudentsTableViewController else { return }
			studentsTableViewController = dest
		}
	}
}
