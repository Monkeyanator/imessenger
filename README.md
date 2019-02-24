# imessenger
> Because we should be able to talk over iMessage through pipes

## Usage

```
usage: imessenger [-m message] [--message message] [-t recipient] [--to recipient]
    -m message  message to send to recipient, this can be omitted if passing message from stdin
    -t recipient    the contact in iMessage who should receive the message
```

Being able to pipe messages in lets us do things like:

`curl http://textfiles.com/humor/boston.geog | ./imessage.sh --to "Joe Schmoe"`

send local file contents to friend over iMessage without attaching file, or whatever, use your imagination :)