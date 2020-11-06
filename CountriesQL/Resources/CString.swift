import Foundation

struct CString {
    struct Scenes {
        struct ContinentList {
            static let title = String.localized(by: "scenes_continents_title")
            static let countries = String.localized(by: "scenes_continents_countries")

            private init() {}
        }

        private init() {}
    }
    
    struct Errors {
        static let generic = String.localized(by: "errors_generic")
        static let noConnection = String.localized(by: "errors_no_connection")

        private init() {}
    }

    struct General {
        static let loading = String.localized(by: "general_loading")
        static let tryAgain = String.localized(by: "general_try_again")

        private init() {}
    }

    private init() {}
}
