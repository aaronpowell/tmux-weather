# Tmux Weather

Tmux plugin that displays weather forecast using [wttr.in](http://wttr.in) in the status bar.

The plugin introduces a new `#{forecast}` format.

Thanks to [Rahul Rai](https://github.com/rahulrai-in) for the inspiration, I just packaged it. 😉

## Usage

Add `#{forecast}` to your existing `status-right` tmux option:

```bash
set -g status-right '#{forecast} | #H'
```

You'll now see some information like so:

```
Partly cloudy +13°C ↘13km/h | AaronSB2
```

## Customisation

By default the format string used is `%C+%t+%w`, but you can override this with the `@forecast-format` option:

```bash
set -g @forecast-format '%C'+'|'+'Dusk:'+'%d'
```

Refer to [wttr.in](http://wttr.in) for format options.

Additionally, you might want to specify the location manually, you can do so with the `@forecast-location` option:

```bash
set -g @forecast-location London
```

Refer to [wttr.in](https://wttr.in/:help) for location options.

Moreover a character limit is enforced, in order to avoid errors trashing your status bar.
This limit defaults to 75, but you can increase/decrease it as you wish:

```bash
set -g @forecast-char-limit 30
```

The default forecast language is English. You can change this using a two-letter language code

```bash
set -g @forecast-language "nl"
```

It's possible to enable cache for weather data in file and use it instead of spamming wttr.in
service. Weather (and forecast) doesn't change every minute (or even every second) so no need to add
extra load on wttr.in in case your status-line updated quite often.
To enable caching just set its duration in seconds

```bash
set -g @forecast-cache-duration 900 # 15 minutes
```

There is also an option where to store the cache file

```bash
# this is the default
set -g @forecast-cache-path "/tmp/tmux-weather.cache"
```

## Installation with [Tmux Plugin Manager](https://github.com/tmux-plugins/tpm) (recommended)

Add plugin to the list of TPM plugins in `.tmux.conf`:

```bash
set -g @plugin 'aaronpowell/tmux-weather'
```

Hit `prefix + I` to fetch the plugin and source it.

`#{forecast}` interpolation should now work.

### Manual Installation

Clone the repo:

```bash
$ git clone https://github.com/aaronpowell/tmux-weather ~/clone/path
```

Add this line to the bottom of `.tmux.conf`:

```bash
run-shell ~/clone/path/weather.tmux
```

Reload TMUX environment:

```bash
# type this in terminal
$ tmux source-file ~/.tmux.conf
```

`#{forecast}` interpolation should now work.

## License

[MIT](LICENSE)
