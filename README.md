# trivia-mrc

**trivia-mrc** is a simple trivia bot written in mIRC script.

## Installation

Place the file `trivia.mrc` in your mIRC directory and run the following command inside mIRC.

    /load -rs trivia.mrc

Press <kbd>ALT</kbd> + <kbd>R</kbd> and select `trivia.mrc` in the **View** menu to configure the script.

## Configuration

The configuration options can be found near the top of `trivia.mrc`.

Each option is in the format `alias trivia.<option> return <value>` where `<option>` refers to an item in the table below, and `<value>` is whatever you want it to be.

| Option | Description | Default |
|:-------|:------------|:--------|
| chan | The channel in which the bot responds to commands, and speaks. It won't speak or respond in any other channel but this one. | #trivia
| pre | The character to use as a command prefix. For example, if you pick `.`, then you'd start the bot with the command `.start`. | `.`
| qlength | How long (in seconds) to give people to answer a question. | 60
| hintintv | The pause (in seconds) between hints. Since there are 3 hints, you probably want `hintintv * 3 < qlength` to hold true. You can set it to a bigger value, but who knows what'll happen then. | 15
| questionpause | How long (in seconds) to wait between the end of a question and the start of a new one. | 10
| unansweredstop | After how many unanswered questions to automatically stop. | 10
| questionfile | The file in which the questions are stored. | `questions.txt`
| scoresfile | The file in which the scores are stored. | `scores.ini`

## Commands

These are the commands the bot will respond to in the trivia channel. They should be prefixed by the command prefix e.g., `.start` (if you chose `.` as the command prefix).

| Command | Description |
|:--------|:------------|
| start | Starts the bot.
| stop | Stops the bot.
| qcount | Shows how many questions are in the questions file.
| repeat | Asks the bot to repeat the current question.
| score [name] | Shows `[name]`'s score, or your own if `[name]` is not specified.

## Questions

The format of `questions.txt` is

    question*answer

For example:

    A short legged hunting dog*basset

(Yes, I know that's technically not a question. Feel free to add your own or make corrections. The current questions file contains a bunch of questions I found somewhere out on the interwebs a long time ago. They're not brilliant, but they'll do.)

## Scores

Scores are stored in an `ini` file, with one score per nickname.

For example:

```ini
[scores]
name1=24
name2=93
```

There's no way to merge the scores of different nicknames used by the same person, sorry.

## Credits

No idea. This script was written quite a long time ago.

## Bugs or contributions

Open an [issue](http://github.com/crdx/trivia-mrc/issues) or send a [pull request](http://github.com/crdx/trivia-mrc/pulls).

## Licence

[MIT](https://github.com/crdx/trivia-mrc/blob/master/LICENCE.md).
