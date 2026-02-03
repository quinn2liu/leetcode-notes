# Concurreny and Threading

**Main Thread:** where the UI runs

### Queue
Tasks enter a queue to maintain the order of execution

Serial: a task fully completes before the next task starts

`(task 3) -> (task 2) -> (task 1) -> execute`

Concurrent: tasks don't have to wait for each other to start executing

`(task 3, slow) -> execute`
`(task 2, slowest) -> execute`
`(task 1, fastest) -> execute`

#### Queue Distribution

By default, ever app has **1 Serial Queue** and **4 Concurrent Queues**

ex: you're downloading data and want to reload the view to display the updated data

- data is being downloaded on a background thread
- we want to dispatch it off of the background thread (when it completes) and call this code on the 

```swift
DispatchQueue.main.async {
    self.tableView.reloadData()
}
```