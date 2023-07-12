<div align="center">

![App Screenshot](readme_images/banner_sm.PNG)

</div>
<a title="Made with Fluent Design" href="https://github.com/bdlukaa/fluent_ui">
  <img
    src="https://img.shields.io/badge/fluent-design-blue?style=flat-square&color=gray&labelColor=0078D7"
  >
</a>

# DUNE

Dune is a Music Streaming & Player that makes it easy to enjoy music from YouTube and Spotify, as well as your own music
library on your devices but most importantly without the need to switch or change anything, *just choose your playlist
and listen seamlessly.*

## Features

### *Explore popular & trending music from all over the world*

![App Screenshot](readme_images/frameless_explore_page_light_ACRYLIC.PNG)
![App Screenshot](readme_images/)

## Download

Download *Dune*

## Roadmap

### Planned features:

- [ ] User playlists (( 🚧 )) .
- [ ] Local Music discovery.
- [ ] Downloading Media(songs, albums, playlists).
- [ ] Adding Spotify as a music source.
- and much more...

### Multiple Languages Support

| Language | Status | 
  |:--------:|:------:|
| English  |   ✔    |
|  Arabic  |   🚧   |

### Multi-Platform Support:

| Platform | Supported | Adaptive UI/UX Implemented |
  |:--------:|:---------:|:--------------------------:|
| Windows  |     ✔     |             ✔              |
| Android  |     ✔     |          (50%) 🚧          |
|   IOS    |     ✔     |             🚧             |
|  macOs   |     ✔     |             🚧             |

### Storage options:

|  Option  | Offline Support | Backup & Restore Support | Cloud Support | Storing User Playlists | Storing User Preferences | Storing User Listening History |
  |:--------:|:---------------:|:------------------------:|:-------------:|:----------------------:|:------------------------:|:------------------------------:|
| [Isar]() |        ✔        |            🚧            |       ❌       |           🚧           |            ✔             |               ✔                |

### Testing

- [ ] Unit tests for Music Facades.
- [ ] Unit tests for `StateNotifier` Controllers.
- [ ] Unit tests for Repositories.
- [ ] Unit tests for `AppRouter` class.
- [ ] Unit tests for `AudioPlayer` class.
- [ ] Widget tests for `DesktopHomeScreen`, `WideHomeScreen`, `MobileHomeScreen`.

## Build from source

### Prerequisites

- If you are new to Flutter, start with the [installation instruction](https://flutter.io/docs/get-started/install).

- Flutter v3.10 & Dart v3.0 - or higher.

- For running on *Windows*, please read the
  following [requirements](https://docs.flutter.dev/development/platform-integration/desktop#requirements).

- Run the command `flutter doctor -v` in a terminal to make sure no issues are present.

### Setup

**Step 1:** download or clone this repo.

**Step 2:**

- Go to the project folder:

    ```bash
    cd path_of_project_folder
    ```
- Resolve dependencies:

    ```bash
    flutter pub get
    ```

### Running the app

- Open the project in an IDE.

- Select the device you wish to run the app on.

    - **Option 1:**
      Run the `main` function inside `lib\main.dart` or press `CTRL+F5`.

    - **Option 2:** In the project directory, run in the terminal one of the commands:

      ```dart
          flutter run -d windows
          flutter run -d macos
          flutter run -d android
          flutter run -d ios
      ```

## Contributing

Contributions are always welcome!

See `contributing.md` for ways to get started.

Please adhere to this project's `code of conduct`.

## Acknowledgements
