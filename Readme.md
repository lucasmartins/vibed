# Vibed

Vibed is an interactive cli tool for downloading music files from the Cloud using the Terminal.

Spotify was too evil owning my playlists and I decided to rebel. Yeah, you can't export your playlists, you don't own the music, you don't own the list.

## System/User Requirements

You gotta have a Ruby environment, I'm sorry if that's not your cup of tea but I made this tool for myself and I'm sharing to those who are willing to sweat a bit to use it.

If you don't know to use the Terminal, there are nice video tutorials for free on the internet, specially for Ruby.

Or, just use a web interface like [this one](http://vibeclouds.net).

## Install

```bash
$ git clone git@github.com:lucasmartins/vibed.git ~/.vibed
$ mkdir ~/.config
$ echo 'alias vibed="~/.vibed/vibed.thor"'
$ cd ~/.vibed/ && bundle install && cd -
```

## Usage

Start it up and spell out the name+author of the song:

```bash
$ vibed start
Getting cookie...
OHM NOM NOM...
Tell me the music name and author:
sugar robin schulz
```

Hopefully, you will be prompted with some options:

```
Select the file:
[0] Robin Schulz-Sugar feat Francesco Yates 
[1] Robin Schulz feat Francesco Yates -Sugar Hugel Remix 
[2] Robin Schulz-Sugar feat Francesco Yates 
[3] Robin Schulz feat Francesco Yates-Sugar FREY Remix 
[4] Рингтон Robin Schulz-Sugar - Solovey su
```

Pick your and wait.

## Config

There's only one config to set (default target location for the files), you can check at `~/.config/vibed`.

## That's it.

Now I can script out something to export my Spotify playlists into real files on my own drive.

Nice...

## Disclaimer / Caveats

Depending on the country you live in, using this might get you jail time or huge fines.

Enjoy [democracy](https://en.wikipedia.org/wiki/Democracy) at you own peril.