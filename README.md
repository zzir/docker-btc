# CoinDockerfile

## Build
```bash
# clone project
git clone https://github.com/zzir/CoinsDockerfile

# build to images
docker build -t btc:v0.16.2 CoinsDockerfile/Bitcoin/0.16.2/
```

## Run & Exec

```bash
# run
docker run -d --name btc-0-16-2 -v /tmp/btc:/home/bitcoin/.bitcoin/ btc:v0.16.2 -regtest=1

# exec
docker exec --user bitcoin btc-0-16-2 bitcoin-cli -regtest getmininginfo
```

## Volume Path

**Bitcoin**
```
/home/bitcoin/.bitcoin
```
**BitcoinCash**
```
/home/bitcoin/.bitcoin
```
**BitcoinDiamond**
```
/home/bitcoindiamond/.bitcoindiamond
```
**BitcoinGold**
```
/home/bitcoingold/.bitcoingold
```
**Litecoin**
```
/home/litecoin/.litecoin
```


## Q & A

Q: can not connect github.com or speed slow.    
A: add http proxy.
```
docker build --build-arg HTTP_PROXY=http://1.2.3.4:5678 -t btc:v0.16.2 .
```

Q: can not running.    
A: do not write `deamon=1` in `bitcoin.conf` file.


## Reference

 - https://github.com/ruimarinho/docker-bitcoin-core
 - https://github.com/uphold/docker-litecoin-core
 - https://github.com/uphold/docker-bitcoin-gold
