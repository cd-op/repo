# dire

dire (DIrectory REquire) is a simple node.js module capable of requiring an entire directory of other modules.

## Features:

- requiring a directory with one statement, either as a flat (one level) or nested (namespaced) object;
- filtering modules by file extension (i.e. you can require just the .json files or just the .js files).

## Usage:

    var dire = require('dire');
    var x = dire('/path/to/some/directory/');

This is the simplest use case. It requires any loadable node.js files in that directory and returns a nested object. If `/path/to/some/directory` had the following structure:

    /path/to/some/directory/
    '-- a/
        '-- cfg.json
        '-- mod.js
    '-- b/
        '-- cfg.json
        '-- mod.js
        '-- err.js
        '-- completelyrandommodule.js

the object `x` would be:

    {
        a: {
            cfg: [...],
            mod: [...]
        },
        b: {
            cfg: [...],
            mod: [...],
            err: [...],
            completelyrandommodule: [...]
        }
    }

`dire` can also be told to load a flat object:

    var x = dire('/path/to/some/directory/', true);

and then `x` would be:

    {
        'a/cfg': [...],
        'a/mod': [...],
        'b/cfg': [...],
        'b/mod': [...],
        'b/err': [...],
        'b/completelyrandommodule': [...]
    }

The third parameter provided to `dire` specifies the file extension filter:

    var x = dire('/path/to/some/directory/', false, '.json');

The value of `x` would now be:

    {
        a: {
            cfg: [...]
        },
        b: {
            cfg: [...]
        }
    }

## Credits

This module is largely inspired by Troy Goode's [node-require-directory](https://github.com/TroyGoode/node-require-directory)

Thanks to @romanshestilovski (github) for spotting and fixing the local path bug.
