import unittest
from io import StringIO
import sys
from todo import Task, TaskPool

class TestTaskPool(unittest.TestCase):
    def setUp(self):
        self.pool = TaskPool()

    def test_add_task(self):
        task = Task("New Test Task")
        self.pool.add_task(task)
        self.assertEqual(len(self.pool.tasks), 1)
        self.assertEqual(self.pool.tasks[0].title, "New Test Task")

    def test_get_open_tasks(self):
        self.pool.populate()
        open_tasks = self.pool.get_open_tasks()
        self.assertEqual(len(open_tasks), 3)
        self.assertIn("Create Dockerfile", [t.title for t in open_tasks])

    def test_get_done_tasks(self):
        self.pool.populate()
        done_tasks = self.pool.get_done_tasks()
        self.assertEqual(len(done_tasks), 3)
        self.assertIn("Learn GitHub Actions", [t.title for t in done_tasks])

if __name__ == "__main__":
    old_stdout = sys.stdout
    sys.stdout = captured_output = StringIO()

    runner = unittest.TextTestRunner(stream=captured_output, verbosity=2)
    suite = unittest.TestSuite()
    suite.addTest(unittest.makeSuite(TestTaskPool))
    runner.run(suite)

    sys.stdout = old_stdout

    output_lines = captured_output.getvalue().splitlines()
    for line in output_lines:
        if "..." in line and ("ok" in line or "FAIL" in line or "ERROR" in line):
            print(line.strip())
        elif "Ran" in line and "tests" in line:
            print(line.strip())
        elif "FAILED" in line or "OK" in line:
            print(line.strip())
