#!/bin/bash

TODO_LIST_FILE="/home/virus/.local/cache/todo_list.txt"

if [ ! -f "$TODO_LIST_FILE" ]; then
  touch "$TODO_LIST_FILE"
fi

list_tasks ()
{
  if [ ! -s "$TODO_LIST_FILE" ]; then
    echo -e "--- your to-do list is empty! ---"
  else
    echo -e "----- your tasks"
    cat -n "$TODO_LIST_FILE"
    echo -e "-----"
  fi
}

add_task ()
{
  if [ -z "$1" ]; then
    echo -e "error: please provide a task."
    echo "usage: todo add \"your task\""
  else
    echo "$*" >> "$TODO_LIST_FILE"
    echo -e "----- task added: $*"
    cat -n "$TODO_LIST_FILE"
    echo -e "-----"
  fi
}

remove_task ()
{
  if [ -z "$1" ]; then
    echo -e "error: please provide the task number to remove."
    list_tasks
  else
    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
      echo -e "error: input must be a valid number."
      return
    fi

    TOTAL_LINES=$(wc -l < "$TODO_LIST_FILE")
    if [ "$1" -gt "$TOTAL_LINES" ] || [ "$1" -lt 1 ]; then
      echo -e "$erroe: task #$1 does not exist."
    else
      TASK_TEXT=$(sed "${1}q;d" "$TODO_LIST_FILE")
      sed -i "${1}d" "$TODO_LIST_FILE"
      echo -e "completed: $TASK_TEXT"
      cat -n "$TODO_LIST_FILE"
      echo -e "-----"
    fi
  fi
}

clear_all ()
{
  read -p "are you sure you want to delete all tasks? (y/n): " confirm
  if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]; then
    > "$TODO_LIST_FILE"
    echo -e "all tasks cleared."
  else
    echoo -e "operation cancelled."
  fi
}

show_help ()
{
  echo -e "simple bash to-do list"
  echo "usage:"
  echo "  $0 -l               -> show all tasks"
  echo "  $0 -a \"task name\" 	-> add a new task"
  echo "  $0 -d <number>      -> mark a task as done (remove it)"
  echo "  $0 -c               -> remove all tasks"
}

case "$1" in
  -a) shift
    add_task "$@"
    ;;
  -l) list_tasks
    ;;
  -d) remove_task "$2"
    ;;
  -c) clear_all
    ;;
  *|-h) show_help
    ;;
esac

