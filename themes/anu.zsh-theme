svn_info() {
  echo "þ $(svn info |grep Revision |cut -d' ' -f 2)"
}
git_info() {
  echo "± $(git branch |grep '*'|cut -d' ' -f2)"
}
hg_info(){
  echo "☿"
}

scm_prompt() {
  svn info NUL    && svn_info && return
  git branch NUL  && git_info && return
  #hg root NUL     && hg_info  && return
  echo '○'
}


color() {
  echo -n "%F{$1}$2%f"
}

user_prompt() {
  fg_color=08;
  if [ "$USER" != "andy" ]; then
    fg_color=09;
  fi
  color $fg_color $USER;
}
at_prompt() {
  color 233 '@'
}
pathsplit_prompt() {
  color 233 ':'
}

host_prompt() {
  fg_color=231;
  if [ "$HOST" = "mongongo" ]; then
    fg_color=24;
  elif [ "$HOST" = "kola" ]; then
    fg_color=28;
  else
    fg_color=228;
  fi
  color $fg_color $HOST;
}


exit_prompt() {
  exit_code=$?;
  if [[ $exit_code -ne 0 ]]; then
    color 196 "$exit_code "
  fi
}

exit_code_prompt() {
  color 160 '%?'
}


git_prompt() {
  PROMPT='%n@%m:%/ %# '
  RPROMPT='$(scm_prompt)'
}

PROMPT='$(user_prompt)$(at_prompt)$(host_prompt)$(pathsplit_prompt)%/ %# '
RPROMPT='$(exit_prompt)$(scm_prompt)'
