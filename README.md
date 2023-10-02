<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Bruno%20Ace">

<h1 align="center" style="font-family: Bruno Ace;font-size:44px">DUNE</h1>
<div align="center">
<a href="https://github.com/DMouayad/DUNE/releases"><img src="https://img.shields.io/github/v/release/DMouayad/DUNE?style=flat-square&color=blue" alt="Release"/></a>
<a title="Made with Fluent Design" href="https://github.com/bdlukaa/fluent_ui"><img src="https://img.shields.io/badge/fluent-design-blue?style=flat-square&color=gray&labelColor=0078D7"/></a>
</div>

<div align="center">
Dune makes it easy to have your favourite songs in one place just choose your playlist ➡ 🎧 ➡ enjoy seamless music streaming.
</div>
<br/>

<details>
<summary><b>Table of contents</b></summary>

<!-- TOC -->

* [Features](#features)
    * [Explore Music](#explore-music)
    * [Local music library](#local-music-library)
    * [Tabs support](#tabs-support)
    * [Listening Statistics](#listening-statistics)
    * [Other Features](#other-features)
* [Screenshots](#screenshots)
* [Download](#download)
* [Roadmap](#roadmap)
* [How it works](#how-it-works)
    * [Storage](#storage)
* [Build from source](#build-from-source)
* [Feed back & Contributions](#feed-back--contributions)
* [Disclaimer](#disclaimer)
* [Motivation](#motivation)
* [Acknowledgement](#acknowledgement)
    * [Packages & Plugins](#packages--plugins)
    * [Inspiration](#inspiration)
* [License](#license)
<!-- TOC -->
</details>

## Features

### Explore Music

- Get up-to-date popular & trending music from all over the world.
- Explore music by genre & mood.

### Local music library

- Add your local audio files with one click and all of your tracks, albums, artists will be saved and available inside
  the app.

### Tabs support

**Yes, you've read it correctly**, with the option of both vertical & horizontal tabs-layout:

Now your web-browsing experience is less cluttered because DUNE is the prefect place for your
music-exploring adventures.

### Listening Statistics

> Not 100% functional; going under some refinements.

### Other Features

- **Mixed playlists**: creating a playlist with songs from different sources.
- **Data Usage control**: You can set the quality of audio streaming & cover images.
- **No-Tabs mode**: Tabs can be disabled but, you still have all the other great features.
- **Themes**: Provides a wide verity of accent colors for you to choose from.
- **Cross-platform support**
- **Lyrics support**
- **Download media & offline mode**
- **Local library Mode**

## Screenshots

![](/readme_assets/explore.png)

![](/readme_assets/library-albums.png)

![](/readme_assets/search.png)

## Download

<a href="https://github.com/DMouayad/DUNE/releases"><img src="https://img.shields.io/github/v/release/DMouayad/DUNE?style=flat-square&color=blue" alt="Release"></a>

> Older versions are also available at: [GitHub releases](https://github.com/DMouayad/DUNE/releases)


<table>
    <tr>
        <th>OS</th>
        <th>Latest version</th>
    </tr>
    <tr>
        <td align="center">
           <img width="64" height="64" src="https://img.icons8.com/color/96/windows-10.png" alt="windows-10"/>
        </td>
            <td align="center">
                <a href="">
            <img width="30" height="30" align="center" src="https://img.icons8.com/ios-glyphs/30/github.png" alt="github"/>
                         <h5 style="color:grey;"> Get it on GitHub</h5></a>
            </td>
    </tr>
    <tr>
        <td align="center"><img width="64" height="64" src="https://img.icons8.com/fluency/96/android-os.png" alt="android-os"/></td>
        <td align="center">
          <a href="">
            <img width="30" height="30" align="center" src="https://img.icons8.com/ios-glyphs/30/github.png" alt="github"/>
                         <h5 style="color:grey;"> Get it on GitHub</h5></a>
        </td>

</tr>
    <tr>
        <td  align="center">
            <img width="64" height="54" src="https://img.icons8.com/color/96/linux--v1.png" alt="linux--v1"/>
        </td>
        <td align="center">
                <a href="">
            <img width="30" height="30" align="center" src="https://img.icons8.com/ios-glyphs/30/github.png" alt="github"/>
                         <h5 style="color:grey;"> Get it on GitHub</h5></a>
        </td>
    </tr>
</table>

## Roadmap

> This project is a WIP

Please refer to [DUNE project](https://github.com/users/DMouayad/projects/2) for:
planned features, discussions and development progress.

## How it works

### Storage

- [Isar](https://github.com/isar/isar)

  |  Feature  | Offline store |    Backup & Restore     | Cloud store | Storing User Playlists | Storing User Preferences | Storing User Listening History |
    |:---------:|:-------------:|:-----------------------:|:-----------:|:----------------------:|:------------------------:|:------------------------------:|
  | Supported |       ✔       |           🚧            |      ❌      |           🚧           |            ✔             |               ✔                |

## Build from source

To build your own version of DUNE, please follow these [instructions](CONTRIBUTING.md#running-locally-guide).

## Feed back & Contributions

- 🐛 Found an issue or encountered a bug? please check the existing [issues](https://github.com/DMouayad/DUNE/issues) or
  create a new one.
- 💪🏻 Want to improve this project? check out the [Contributing](CONTRIBUTING.md) guide.
- ⭐ You can also help us by starring this repo.
- Read also ["motivation for this project"](#motivation).

## Disclaimer

- Initially, this app was developed to demonstrate the power of **Flutter** in creating cross-platform apps.

  > But, if you like using DUNE, well, thank you. Enjoy the music responsibly and support the artists who create it.

- Read also Copy Rights © [disclaimer](DISCLAIMER.md).

## Motivation

Although there are many projects that offer similar features, they often fall short
in providing a complete package 📦.
For example, some apps can stream music from different platforms, but they do not 🚫 allow users to:

- Create a playlist with songs from different sources.
- Provide the option to add your local music library.
- Change the search engine(source) without adjusting some setting.

Another important issue in some of these projects is the quality of code. While it may not be an immediate
concern for users, it becomes a time-consuming and challenging task for maintainers to add new features
in the long run. This can be for several reasons:

- The lack of a clear architecture on how code is organized and communicate across different layers.
- Having mega classes and functions scattered all over the place discarding the SOLID principals.
- The absence of tests, no Unit tests no Widget tests, nothing.

That is *why* I started this project with the goal of creating something beautiful & elegant from the inside-out.

## Acknowledgement

### Packages & Plugins

- [taggy:](https://github.com/DMouayad/) provides reading & writing audio files metadata.
- [Isar:](https://github.com/isar/isar) NoSQL database for Flutter.
- [youtube_explode_dart:](https://pub.dev/packages/youtube_explode_dart) provides an interface for using YouTube APIs.
- [file_picker:](https://pub.dev/packages/file_picker) cross-platform solution for selecting files\folders from local
  storage.
- [fluent_ui:](https://github.com/bdlukaa/fluent_ui/)
- [audio_video_progress_bar](https://github.com/suragch/audio_video_progress_bar)

### Inspiration

- [Spotube](https://github.com/KRTirtho/spotube/)
- [Harmonoid](https://github.com/harmonoid/harmonoid/)
- [Drip](https://github.com/Spsden/Drip)
- [Musify](https://github.com/gokadzev/Musify)

## License

DUNE is an open source project and licensed under the [GNU](/LICENSE) License.