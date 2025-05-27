#!/bin/bash

TODO_OUTPUT_FILE="/app/todo_output.txt"
TEST_OUTPUT_FILE="/app/test_output.txt"

echo "Running todo.py..."
python3 /app/scripts/todo.py > "$TODO_OUTPUT_FILE" 2>&1
if [ $? -ne 0 ]; then echo "Error running todo.py"; exit 1; fi

echo "Running todo-test.py..."
python3 /app/scripts/todo-test.py > "$TEST_OUTPUT_FILE" 2>&1
if [ $? -ne 0 ]; then echo "Error running todo-test.py"; exit 1; fi

echo "Updating index.html and pushing changes..."
/bin/bash /app/scripts/update_index.sh "$TODO_OUTPUT_FILE" "$TEST_OUTPUT_FILE"
if [ $? -ne 0 ]; then echo "Error running update_index.sh"; exit 1; fi

echo "All scripts executed."
