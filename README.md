Example to run python main.py on the cluster 

1. ssh to school 

2. git clone this repo 
> git clone https://github.com/liu-kanghui/condor_example.git

3. cd to condor_example and create a directory called log

4. ssh to the head cluster 
> ssh csci-head.cluster.cs.wwu.edu -p 922

5. submit the job
> condor_submit cuda.job
