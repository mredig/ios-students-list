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

	private var students: [Student] = [] {
		didSet {
			updateSort()
		}
	}

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

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		updateSort()
	}

	private func updateSort() {
		guard isViewLoaded else { return }
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

	@IBAction func sort(_ sender: UISegmentedControl) {
		updateSort()
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "EmbedStudentsTableView" {
			guard let dest = segue.destination as? StudentsTableViewController else { return }
			studentsTableViewController = dest
		}
	}
}
