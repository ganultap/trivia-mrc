; The channel in which the bot responds to commands, and speaks.
alias trivia.chan return #trivia

; The character to use as a command prefix.
alias trivia.pre return .

; How long (in seconds) to give people to answer a question.
alias trivia.qlength return 60

; The pause (in seconds) between hints.
alias trivia.hintintv return 15

; How long (in seconds) to wait between the end of a question and the start of a new one.
alias trivia.questionpause return 10

; After how many unanswered questions to automatically stop.
alias trivia.unansweredstop return 10

; The file that stores the questions.
alias trivia.questionfile return questions.txt

; The file that stores the scores.
alias trivia.scoresfile return scores.ini

;------------------------------------------------------------------------------------

on 2:TEXT:*:$($trivia.chan): {
  tokenize 32 $strip($1-)
  if ($1 == $trivia.pre $+ start) trivia.start
  elseif ($1 == $trivia.pre $+ stop) trivia.stop
  elseif ($1 == $trivia.pre $+ qcount)  msg $trivia.chan Number of questions:4 $lines(questions.txt) $+ 
  elseif ($1 == $trivia.pre $+ repeat) if (%trivia.question) msg $trivia.chan Question:04 %trivia.question $+
  elseif ($1 == $trivia.pre $+ score) {
    if (!$2) msg $trivia.chan 4 $+ $nick $+ 's score:04 $trivia.getscore($nick) $+ 
    else msg $trivia.chan 4 $+ $2 $+ 's score:04 $trivia.getscore($2) $+ 
  }
  else trivia.parse $1-
}

on *:EXIT: unset %trivia.*
on *:DISCONNECT: unset %trivia.*

alias trivia.stop {
  if (%trivia.state == playing) {
    unset %trivia.state
    msg $trivia.chan Trivia stopped. Type $trivia.pre $+ start to restart.
    .timerhint off
    .timerquestion off
    .timerpause off
    unset %trivia.*
  }
}

alias trivia.start {
  if (%trivia.state != playing) {
    set %trivia.state playing
    msg $trivia.chan Trivia started. Type $trivia.pre $+ stop to stop.
    trivia.doquestion
  }
}

alias trivia.doquestion {
  if (%trivia.question) return
  var %qa = $read($trivia.questionfile)
  set %trivia.question $gettok(%qa, 1, 42)
  set %trivia.answer $gettok(%qa, -1, 42)
  set %trivia.hint 1
  .timerhint 3 $trivia.hintintv trivia.thint
  .timerquestion 1 $trivia.qlength trivia.tquestion
  trivia.genhints %answer
  msg $trivia.chan Question:4 %trivia.question ( $+ $trivia.qlength $+ s left)
}

alias trivia.makehint {
  var %l = $1
  var %hint = $2-
  var %length = $len(%hint)

  var %i = 1, %r
  while (%i <= %l) {
    var %retry = 1
    while (%retry) {
      %r = $rand(1, %length)
      if ($mid(%hint, %r, 1) == $chr(32)) continue
      if ($mid(%hint, %r, 1) == _) continue
      %hint = $repch(%hint, %r, _)
      %retry = 0
    }
    inc %i
  }
  return %hint
}

alias repch return $left($1, $calc($2 - 1)) $+ $3 $+ $mid($1, $calc($2 + 1))

alias trivia.genhints {
  var %a = %trivia.answer
  var %len = $len($replace(%a,$chr(32),$null))
  var %chs = $floor($calc(%len / 3))

  if (%chs == 0) {
    set %trivia.hint3 $repch(%a, 1, _)
    if (%len == 2) {
      set %trivia.hint1 $repch(%trivia.hint3, 2, _)
      set %trivia.hint2 %trivia.hint3
    }
    else {
      set %trivia.hint1 %trivia.hint3
      set %trivia.hint2 %trivia.hint3
    }
  }
  else {
    set %trivia.hint3 $trivia.makehint(%chs, %a)
    set %trivia.hint2 $trivia.makehint(%chs, %trivia.hint3)
    set %trivia.hint1 $trivia.makehint(%chs, %trivia.hint2)
  }
}

alias trivia.thint {
  if (%trivia.hint == 1) msg $trivia.chan Hint: %trivia.hint1 ( $+ $timer(question).secs $+ s left)
  if (%trivia.hint == 2) msg $trivia.chan Hint: %trivia.hint2 ( $+ $timer(question).secs $+ s left)
  if (%trivia.hint == 3) msg $trivia.chan Hint: %trivia.hint3 ( $+ $timer(question).secs $+ s left)
  inc %trivia.hint
}

alias trivia.tquestion {
  msg $trivia.chan Time's up! The answer was 04 $+ %trivia.answer $+ .
  set %trivia.incorrect $calc(%trivia.incorrect + 1)
  if (%trivia.incorrect == $trivia.unansweredstop) {
    msg $trivia.chan Too many unanswered questions, stopping trivia
    trivia.stop
  }
  else {
    unset %trivia.question
    trivia.question
  }
}

alias trivia.parse {
  if (($1- == %trivia.answer) && (%trivia.question)) trivia.win $nick %trivia.answer
}

alias trivia.win {
  if ($1 == shawnz) return
  var %newscore = $calc($trivia.getscore($1) + 1)
  trivia.setscore $nick %newscore
  msg $trivia.chan 4 $+ $1 got it! The answer was " $+ $2- $+ ". 4 $+ $1 $+  answered in4 $calc($trivia.qlength - $timer(question).secs) $+ s and their score is now 04 $+ %newscore $+ .
  .timerhint off
  .timerquestion off
  unset %trivia.incorrect
  unset %trivia.question
  trivia.question
}

alias trivia.setscore {
  writeini -n $trivia.scoresfile scores $1 $2
}

alias trivia.getscore {
  var %t = $readini($trivia.scoresfile, n, scores, $1)
  if (!%t) return 0
  return %t
}

alias trivia.question {
  .timerpause 1 $trivia.questionpause trivia.doquestion
}
