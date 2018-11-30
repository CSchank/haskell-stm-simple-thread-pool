# haskell-stm-simple-thread-pool
A very simple static thread pool example using STM in Haskell. Simulates running N tasks
on M threads in a thread pool using `TQueue`s. Intended for processing asynchronous tasks
where the order of execution doesn't matter. Work is simulated with thread delays, but this
function could be swapped out to do more interesting things.

## Compiling
In your favourite terminal, type `stack build` in the root directory of the cloned repo.

## Execution
In your favourite terminal, type `stack exec pool threads tasks`
where `threads` is the size of the pool and `tasks` is the number of tasks to be run.
