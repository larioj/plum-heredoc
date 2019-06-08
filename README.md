# Plum Heredoc

Allows you to execute heredocs like so:

    $ cat <<EOF
      this is a heredoc
    EOF

It will trim the whitespace, so that the EOF marker is reconized.
It will also make it so that all lines until EOF file are captured
when you "execute" the first line.

Note: For now it only supports `<<EOF`. No other tokens.

## Files
    .
    ├── README.md
    └── autoload
        └── plum
            └── heredoc.vim
