# cutefish-statusbar

The status bar at the top displays the current status of the system, such as time, system tray, etc.

## Dependencies

```bash
sudo apt install libkf5windowsystem-dev -y
```

## Build

```bash
git clone https://github.com/cutefishos/statusbar.git
mkdir ~/statusbar/build $$ cd ~/statusbar/build
cmake ..
make
sudo make install
```

## License

StatusBar is licensed under GPLv3.

![GPLv3](https://raw.githubusercontent.com/cutefish-ubuntu/cutefish-ubuntu/master/img/gpl3.png)
