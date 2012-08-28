## trivia.mrc

### What?

`trivia.mrc` is a simple trivia bot written in mIRC script.

### Installation

Place the file `trivia.mrc` in your mIRC directory and run the following command inside mIRC.

    /load -rs trivia.mrc

Press `ALT + R` and select `trivia.mrc` in the view menu to configure the script (see below).

### Configuration

The configuration lines can be found near the top of `trivia.mrc`.

The format of each configuration line is `alias trivia.<option> return <value>` where `trivia.<option>` refers to an item in the table below, and `<value>` is whatever you want it to be.

| Option | Description | Default |
|:-------|:------------|:--------|
| `trivia.chan` | The channel in which the bot responds to commands, and speaks. It won't speak or respond in any other channel but this one. | #trivia
| `trivia.pre` | The character to use as a command prefix. For example, if you pick `.`, then you'd start the bot with the command `.start`. | `.`
| `trivia.qlength` | How long (in seconds) to give people to answer a question. | 60
| `trivia.hintintv` | The pause (in seconds) between hints. Since there are 3 hints, you probably want `hintintv * 3 < qlength` to hold true. You can set it to a bigger value, but who knows what'll happen then. | 15
| `trivia.questionpause` | How long (in seconds) to wait between the end of a question and the start of a new one. | 10
| `trivia.unansweredstop` | After how many unanswered questions to automatically stop. | 10
| `trivia.questionfile` | The file in which the questions are stored. | questions.txt
| `trivia.scoresfile` | The file in which the scores are stored. | scores.ini

### Commands

These are the commands the bot will respond to in the trivia channel. They should be prefixed by the command prefix like `.start` (if you chose `.` as the command prefix).

| Command | Description |
|:--------|:------------|
| `start` | Starts the bot.
| `stop` | Stops the bot.
| `qcount` | Shows how many questions are in the questions file.
| `repeat` | Asks the bot to repeat the current question.
| `score [name]` | Shows `[name]`'s score, or your own if `[name]` is not specified.

### Questions

The format of `questions.txt` is

    question*answer

For example:

    A short legged hunting dog*basset

(Yes, I know that's technically not a question. Feel free to add your own or make corrections. The current questions file contains a bunch of questions I found somewhere out on the interwebs a long time ago. They're not brilliant, but they'll do.)

### Scores

Scores are stored in an `.ini` file, one score per nickname.

For example:

    [scores]
    name1=24
    name2=93

There is no way to merge the scores of different nicknames used by the same person. Sorry.

### Credits

No idea. This script was written quite a long time ago.