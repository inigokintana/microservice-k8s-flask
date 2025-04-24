mkdir /mnt/pgdata
cd /mnt
chown 1000:1000 pgdata # because k command alias k='kubectl' is run from inigokintana user - not roor

--
vectorizer-worker container
# password was stored in secret - how to get it from there secretRef:name: pgvectorconfig? 

--

Follow steps https://github.com/timescale/pgai

https://www.timescale.com/blog/vector-databases-are-the-wrong-abstraction 
--
