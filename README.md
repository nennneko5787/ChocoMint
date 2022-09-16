最後まで見てﾈ!
# How To Install
[こちらのリンクから自分のデバイスに合うものをダウンロードしてください。](https://github.com/nennneko5787/ChocoMint/releases/latest)
### インストールするものがわからない...
Windows版 -> Chocomint-v*.exe  
Android版 -> Chocomint-v*.apk  
(* にはバージョン番号が入ります)
# Build from source code
## Linux
### 必要な環境
GUI環境(X Window System)
### 必要なもののインストール
まず、以下のコマンドを入力して、HSP(のソースコード)をインストールします。  
<pre>
git clone http://github.com/onitama/OpenHSP
</pre>
次に、以下のコマンドを入力して、必要なライブラリをインストールします。
<pre>
sudo apt install libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev
sudo apt install libcurl4-openssl-dev
</pre>
最後に、以下のコマンドを入力して、HSPのソースコードをビルドします。
<pre>
cd OpenHSP
make
</pre>
### ソースコードのコンパイル、実行
[こちらのリンクから最新版のソースコードをダウンロードしてください。](https://github.com/nennneko5787/ChocoMint/archive/refs/heads/main.zip)  
ダウンロードしたソースコードを好きなところに解凍します。  
そうしたら、HSPがインストールされているディレクトリに移動し、以下のコマンドを入力して、ソースコードをコンパイルし、実行します。
<pre>
hspcmp -d -i -u &lt;ソースコードのディレクトリ&gt;/main.hsp
hsp3cl &lt;ソースコードのディレクトリ&gt;/main.ax
</pre>
# FAQ
## MacとかiPhoneとかで使えないの??
Mac -> Wine通して使ってね
iPhone -> 使えないよ
基本的にApple製品では使えません。
## ソースコード見づらい
(^^;
## いつになったら完成するの?
(^^;
