module UnsafeLib
    ( startWorkers
    ) where

import Control.Monad (forever, when)
import Control.Concurrent (threadDelay)
import Control.Concurrent.STM.TQueue
import GHC.Conc.Sync
import System.Random
import System.IO.Unsafe

--uses an unsafePerformIO to create a global TQueue
q = unsafePerformIO newTQueueIO :: TQueue Int

workerThread :: Int -> IO ()
workerThread tId =
    let
        --read the tQueue, process the element and then do it again
        loop = atomically (readTQueue q) >>= processElement >> loop

        --replace the processElement function with a useful function
        processElement :: Int -> IO ()
        processElement n = do
            let delayLow = 0
                delayHi  = 4
            putStrLn $ "Processing element " ++ show n ++ " on thread " ++ show tId
            delay <- getStdRandom $ randomR (delayLow,round $ 1000000 * delayHi) :: IO Int
            threadDelay delay
    in
        loop

startWorkers :: Int -> Int -> IO ()
startWorkers workers tasks = do
    mapM_ (\n -> forkIO $ workerThread n) [0..workers - 1]
    atomically $ mapM_ (writeTQueue q) [0..tasks - 1]
    forever $ threadDelay 100000000