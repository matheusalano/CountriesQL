import UIKit

final class ContinentListViewController: BaseViewController<ContinentListView> {

    //MARK: Private variables

    private var viewModel: ContinentListViewModelProtocol

    //MARK: Initializers

    init(viewModel: ContinentListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.delegate = self
        
        setupNavigationBar()
        setupTableView()
        setupErrorView()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Overridden functions

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.requestData()
    }

    //MARK: Private functions

    private func setupNavigationBar() {
        title = CString.Scenes.ContinentList.title
    }
    
    private func setupTableView() {
        customView.tableView.dataSource = self
        customView.tableView.delegate = self
        customView.refreshControl.addAction(UIAction(handler: { [weak self] _ in
            self?.viewModel.requestData()
        }), for: .valueChanged)
    }
    
    private func setupErrorView() {
        customView.errorView.addRetryAction(UIAction(handler: { [weak self] _ in
            self?.customView.errorView.removeFromSuperview()
            self?.viewModel.requestData()
        }))
    }
}

extension ContinentListViewController: ContinentListViewModelDelegate {
    func setLoading(_ loading: Bool) {
        let refreshControl = customView.refreshControl
        loading ? refreshControl.beginRefreshing() : refreshControl.endRefreshing()
    }
    
    func reloadTable() {
        customView.tableView.reloadData()
    }
    
    func showError(message: String) {
        customView.errorView.title = message
        customView.errorView.insert(onto: customView)
    }
}

extension ContinentListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.continents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let continent = viewModel.continents[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .subtitle, reuseIdentifier: "Cell")
        
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = continent.name
        cell.detailTextLabel?.text = "\(continent.countries.count) countries"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.rowSelected(indexPath)
    }
}
