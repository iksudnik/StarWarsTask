# Star Wars Task

## Overview
Star Wars Explorer is an iOS application built to showcase state-of-the-art architecture and technologies in iOS development. The app connects to the Star Wars API ([SWAPI](https://swapi.dev/)) and displays comprehensive information about the Star Wars universe, including films, characters, planets, starships, vehicles, and species.

## Features
- Browse complete catalog of Star Wars films, characters, planets, starships, vehicles, and species
- View detailed information about each item
- Navigate between related items
- Offline support with data caching
- Network connectivity monitoring

## Architecture

The application follows the **MVVM (Model-View-ViewModel)** architecture pattern with a modular approach.

## Technologies

- **Swift**: Latest Swift language features
- **SwiftUI**: Modern declarative UI framework
- **Swift Concurrency**: Async/await pattern for network calls
- **Combine**: For reactive programming needs
- **Swift Package Manager**: For modular architecture with local packages
- **URLSession**: For network requests
- **FileManager**: For local data persistence
- **NWPathMonitor**: For network connectivity monitoring
- **MVVM Architecture**: Clear separation of concerns
- **Repository Pattern**: Abstraction over data sources
- **Dependency Injection**: For improved testability

## Getting Started

### Installation
1. Clone the repository
2. Open the project in Xcode
3. Build and run the application

## Future Improvements

The following enhancements are planned for future development:

1. **Modularization of Presentation Layer**: Move the Presentation layer into a separate Swift Package to further improve separation of concerns and build times.
2. **Test Coverage**: Add comprehensive unit tests for the Domain layer to ensure reliability and facilitate future refactoring.
3. **Dynamic Text Support**: Improve accessibility by adapting the UI to support dynamic font sizes and text settings.

---

*Developed as a technical demonstration by Ilja Sudnik, 2025* 
