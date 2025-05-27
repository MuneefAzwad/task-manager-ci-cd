#!/bin/bash
cd /app

TODO_TASKS=$(grep -A 100 "ToDo Tasks:" "$1" | sed '/^$/d' | sed '1d' | awk NF)
DONE_TASKS=$(grep -A 100 "Done Tasks:" "$1" | sed '/^$/d' | sed '1d' | awk NF)
UNIT_TEST_RESULTS=$(<"$2")

update_pre() {
    local pre_id="$1"
    local new_content="$2"
    local html_file="$3"
    perl -i -p0e "s|(<pre id=\"${pre_id}\">).*?(</pre>)|${1}\n${new_content}\n${2}|s" "$html_file"
}

if [ ! -f index.html ]; then
    cat <<EOF > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Manager Report</title>
    <style>
        body { font-family: sans-serif; margin: 20px; }
        pre { background-color: #f4f4f4; padding: 10px; border-radius: 5px; overflow-x: auto; }
        h2 { color: #333; }
    </style>
</head>
<body>
    <h1>Task Management System Report</h1>

    <h2>To Do Tasks</h2>
    <pre id="todo-tasks">No tasks yet.</pre>

    <h2>Done Tasks</h2>
    <pre id="done-tasks">No tasks yet.</pre>

    <h2>Unit Test Results</h2>
    <pre id="unit-tests">No test results yet.</pre>
</body>
</html>
EOF
fi

update_pre "todo-tasks" "${TODO_TASKS}" "index.html"
update_pre "done-tasks" "${DONE_TASKS}" "index.html"
update_pre "unit-tests" "${UNIT_TEST_RESULTS}" "index.html"

git config --global user.email "github-actions@users.noreply.github.com"
git config --global user.name "github-actions"

git add index.html

if ! git diff-index --quiet HEAD --; then
    git commit -m "Update index.html with new task and test data"
else
    echo "No changes to index.html to commit."
fi

git push
