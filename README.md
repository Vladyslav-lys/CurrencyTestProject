# CurrencyTestProject
 
### Overview
<img src="https://i.imgur.com/mQo7r2W.png" width="375" height="667">

The application consists of a single screen displaying a list of currencies and their exchange rates relative to each other.

By tapping on a list item the user adds the exchange rate to favorites if it was not previously added. When tapping on a favorited exchange rate again it is removed from the favorites.

The application can operate both online and offline. The exchange rates are updated daily when online. If the user uses the application offline the last viewed data will be displayed.

The purpose of the application is to monitor the current exchange rate and highlight important ones for the user.

### Technical description

#### How to build and run an app
Open the project in Xcode by double-clicking on the CurrencyTestProject.xcodeproj file in the project folder. Next, select the simulator you need and click the Run▶️ button in the upper left corner. The project will build itself by default and open the simulator with the running application.

#### App architecture and design choices
The application follows the MVVM architecture ensuring a separation of concerns and improved testability.

The Coordinator pattern is implemented for navigation allowing better flow management and decoupling navigation logic from views and view models.

The user interface presents exchange rates as a vertical list, providing an intuitive way to browse currency exchange rates. This layout enhances readability and ensures a good user experience.

#### App structure 
The application consists of separate modules such as the main project, the network layer, the database layer and services. Layers are created in such a way that they can be reused in different parts of the project or its extensions.

The network layer includes a direct connection with the GraphQL, Network component for further use in the project and a model of errors that may occur during interaction with the network.

The database layer consists of the main database component CDDatabase for connecting the database with other parts of the application, the database error model, entities and CoreDataPersistable for determining the primary keys of entities.

The service layer represents the business logic of the application, which processes data from the network and the database for subsequent presentation of the main part of the project or its extensions.

The main part of the application consists of UI components, coordinators for navigation, resources and Platform component, which describes the primary settings of the project and services for using them in the part of View-Model that separates the interface and the logic of the project.

#### How offline mode was implemented
The offline mode was implemented using Core Data database in separate DatabaseLayer.

#### Libraries
There are only Rswift and Appolo GraphQL libraries in the project that were included by SPM dependency manager.
