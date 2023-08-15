# Sitify

Sitify is a small, but extremely extensible bourne shell
script capable of processing a directory tree and transforming
it into a website (it can also be used for other processing
but it's original purpose was to make websites).

# Features

- Bourne Shell syntax. Tested successfully in bash and dash;
- Extensible through simple shell functions (hooks);
- Clean code, easily hackable (as much as a shell script can be).

# Usage:

Out of the box, if you run:

	$ sitify origindirectory destinationdirectory

sitify will just print a terse listing of the contents of
_destinationdirectory_. That's what the default hooks do.

Let's do something useful. We start with two directories

	$ mkdir orig dest

And then we create our front page:

	$ cat >orig/index.markdown <<"EOF"
	Hello World!
	============
	How do you do?
	EOF

But sitify won't do anything yet. We need to add hooks.

Edit orig/.sitify/rc:

	DIR_HOOKS=${DIR_HOOKS}"
	HookDirEnsure"

	FILE_HOOKS=${FILE_HOOKS}"
	HookFileProcess"

	HookDirEnsure () {
		# create the correspondent directory
		mkdir -p "${DEST}${DIR}"
	}

	HookFileProcess () {
		case "$2" in
        *.markdown)
        	FILE_HTML="$(echo -n "$FILE" | sed 's/\.markdown$/.html/')";
        	/usr/bin/vendor_perl/Markdown.pl <"${ORIG}${DIR}${FILE}" >"${DEST}${DIR}${FILE_HTML}"
            ;;
        *)
            cp "${ORIG}${DIR}${FILE}" "${DEST}${DIR}${FILE}"
            ;;
    	esac
	}

We added a directory hook (runs whenever the script arrives at a directory) and
a file hook (runs whenever the script encounters a file). These two hooks replicate
the directory structure from origin to destination, and copy every file as it is
except for markdown formatted files (those are processed accordingly).

Now we just have to run sitify and fire a webserver to serve the results:

	$ sitify orig dest
	$ webfsd -p 8080 -f index.html -r dest

Navigating to http://localhost:8080/ should show your brand new site. Pat yourself in the back and have a beer.

# Additional notes on hooks:

There are four types of hooks:

- Initial (variable *$INIT_HOOKS*): these run before anything else. Good
  for preprocessing macros and such.
- Final (variable *$STOP_HOOKS*): these run after everything else. Good
  for deployment scripts for example.
- Directory (variable *$DIR_HOOKS*): these run on every arrival at a directory.
- File (variable *$FILE_HOOKS*): these run for each file in the directory tree.

Script variables available are the following:

- _$ORIG_: Original directory (1st arg of script). Available for all hooks.
- _$DEST_: Destination directory (2nd arg of script). Available for all hooks.
- _$DIR_:  Current directory (rooted at _$ORIG_). Available for directory and file hooks.
- _$FILE_: Current file (inside current directory). Available for file hooks only.
