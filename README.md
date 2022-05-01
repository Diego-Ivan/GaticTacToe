<div align="center">
<img src="data/icons/hicolor/scalable/apps/io.github.diegoivan.GaticTacToe.svg" width="160" height="160"></img>

# GaticTacToe

**Play Tic-tac-toe with your friends**

<a href="https://flathub.org/apps/details/io.github.diegoivan.GaticTacToe">
    <img width="200" src="https://flathub.org/assets/badges/flathub-badge-en.png" alt="Download on Flathub">
</a>

</div>

## Installing and Running

### Flathub

The only official distribution format for GaticTacToe is the Flatpak package available on Flathub. Click on the banner on the top of this README.md to go to app's Flathub page.

### Building from source

#### Flatpak and GNOME Builder

GNOME Builder provides a high quality Flatpak integration. All dependencies, runtimes and SDK extensions necessary will be installed by the application if they're not available. Just click the "Run" button and the app will be built :smile:.

#### Requirements

| Dependency | Version |
| ---------- | ------- |
| Meson | 0.5.9 |
| gtk-4  | 4.4.6 |
| libadwaita-1 |  1.1 |

To compile and install, run:

```sh
meson builddir --prefix=/usr
cd builddir
sudo ninja install
gatictactoe
```
