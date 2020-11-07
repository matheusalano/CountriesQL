import UIKit

final class CountryListView: UIView {
    
    let errorView = CErrorView()
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    let refreshControl: UIRefreshControl = {
        $0.attributedTitle = NSAttributedString(string: CString.General.loading)
        return $0
    }(UIRefreshControl())

    //MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubviews()
        installConstraints()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: Private functions

    private func addSubviews() {
        addSubview(tableView)
    }

    private func installConstraints() {
        tableView.snp.makeConstraints({
            $0.edges.equalToSuperview()
        })
    }
}
