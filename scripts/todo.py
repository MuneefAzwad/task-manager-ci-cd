class Task:
    def __init__(self, title, status="ToDo"):
        self.title = title  # <--- This line was missing
        self.status = status
        self.completed = False

    def mark_completed(self):
        self.completed = True
        self.status = "Done"

    def __repr__(self):
        return f"{self.title} - {self.status}"

    def __str__(self):
        return f"Task: {self.title}, Status: {self.status}"

class TaskPool:
    def __init__(self):
        self.tasks = []

    def populate(self):
        task1 = Task("LEarn GitHub Actions")
        task2 = Task("DEvelop todo.py")
        task3 = Task("Write unit tests")
        task4 = Task("Create Dockerfile")
        task5 = Task("Set up CI/CD workflow")
        task6 = Task("Test the Pipeline")

        task1.mark_completed()
        task2.mark_completed()
        task3.mark_completed()

        self.tasks.extend([task1, task2, task3, task4, task5, task6])

    def add_task(self, task):
        self.tasks.append(task)

    def get_open_tasks(self):
        return [task for task in self.tasks if task.status == "ToDo"]

    def get_done_tasks(self):
        return [task for task in self.tasks if task.status == "Done"]

def main():
    pool = TaskPool()
    pool.populate()

    print("ToDo Tasks:")
    for task in pool.get_open_tasks():
        print(f"- {task.title}")

    print("\nDone Tasks:")
    for task in pool.get_done_tasks():
        print(f"- {task.title}")

if __name__ == "__main__":
    main()