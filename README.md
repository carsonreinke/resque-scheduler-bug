
## Steps to recreate

Setup:

```
apt install redis-server redis-tools
git clone 
bundle install --path vendor/bundle
```

Then, I run each of these in a separate process, in this order:

```
bundle exec rails s
bundle exec rake resque:pool
bundle exec rake resque:scheduler
```

Finally, navigate to `http://localhost:300/jobs`.  You will notice that the 
schedule tab has no jobs listed.  However, if you look at the consoles the 
above resque-pool and resque-scheduler processes were started in, you can 
see that the jobs are being queue and run correctly.

## Info

```
$ redis-server --version
Redis server v=3.0.6 sha=00000000:0 malloc=jemalloc-3.6.0 bits=64 build=687a2a319020fa42
$ redis-cli --version
redis-cli 3.0.6
```