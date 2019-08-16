# docker-btc

## Get Docker Images
```
docker pull zzir/btc:latest
``` 

or build yourself

```
docker build -t btc:latest .
```

## Run Mainnet

```
docker run --name btc-main -d -p 8332:8332 -p 8333:8333 zzir/btc
```

## Run Regtest

```
docker run -d --name btc-dev btc bitcoind -regtest
docker exec btc-dev bitcoin-cli -regtest getblockcount
```