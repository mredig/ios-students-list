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
    }

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "EmbedStudentsTableView" {
			guard let dest = segue.destination as? StudentsTableViewController else { return }
			studentsTableViewController = dest
		}
	}
}
