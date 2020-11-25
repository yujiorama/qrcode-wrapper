# qrcode-wrapper

alpine イメージに qrencode と zbar をインストールしたコンテナイメージ。

## dependency

* [libqrencode](https://github.com/fukuchi/libqrencode)
* [ZBar bar code reader](http://zbar.sourceforge.net/)

## usage

```bash
$ docker container run --rm -i yujiorama/qrcode-wrapper encode > google-qr.png <<< https://www.google.com
ls -l google-qr.png
$ docker container run --rm -i yujiorama/qrcode-wrapper decode < google-qr.png
https://www.google.com
```

## License

[MIT](./LICENSE)
