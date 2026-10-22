# Chromium managed policies

Files in this directory are copied to `/etc/chromium/policies/managed/` in the image.

## emudhra-distrust.json

Distrusts the eMudhra intermediates whose private keys were compromised
([CVE-2026-111943](https://www.cve.org/CVERecord?id=CVE-2026-111943),
[advisory](https://emudhra.we-have-a-problem.com/)).

Chromium in this image does not reject these intermediates on its own, and it does not use the system CA bundle for
them, so updating `ca-certificates` is not enough. The
[`CADistrustedCertificates`](https://chromeenterprise.google/policies/#CADistrustedCertificates) policy makes Chromium
reject any chain containing a key listed here, including cross-signed variants of the same intermediate.

The list has one certificate per key distrusted by Go's `crypto/x509`
([golang/go@aa64342](https://github.com/golang/go/commit/aa64342a9e13affffea3e989d67e574475af5a78)). Entries are
base64-encoded DER, in this order:

| Subject | SHA-256 fingerprint | SPKI SHA-256 |
|---|---|---|
| CN=EM DV TLS CA - G3B,O=eMudhra BV,C=NL | 42c4accd12c4f59597925e1a08a7a90102608543809308d50ec427e118ba1493 | ebed6475c2c2d80fcb199f3fe8dd6e6b3ce60b77eb15d4e42c3dec0c6f5b5105 |
| CN=EM DV TLS CA - G3C,O=eMudhra Inc,C=US | 0164d7ceae5bb909c272af151ff44b1177ae9b47d9424b94f1d9558c30934d19 | 49dd353dc2b919a3770645117d0e60c16115e7d1bc259eefe734b00ea434fe5f |
| CN=EM OV TLS CA - G3B,O=eMudhra BV,C=NL | 98b896625c0c230adeec3eb2cf6aad5001ecf9156a68644e82374ce5833bc25b | 43bffa19d6ef651451f6841e019931e96f6f2eaeff28ab4b6f1ce4576de2717b |
| CN=EM OV TLS CA - G3C,O=eMudhra Inc,C=US | cb6e15165ac802e9b3f993f16c25d41f4e81c21ebde71ae1b012ac00bf9c7c3f | 63ecefee431d49523bc1136c4e72d0206a477086caf606cd5cf025686c109cf8 |
| CN=EM EV TLS CA - G3B,O=eMudhra BV,C=NL | e7568fe6e12331f4fd7de61da4c7559d0f8eb192a218d4741a3ba75184333838 | e0254c7fcdc265e2f0f8a428dabb75ab4ae039b4872d62f5ee57f0877d5a8a41 |
| CN=EM EV TLS CA - G3C,O=eMudhra Inc,C=US | 432ec25f0d28de9006d97bf752f17bbb2cd41f669933fcb072d9a1148d0261f3 | 5c0660a2b164910d8ff589c18e14552e9e0ec237dcefe2cb736d41a4811f81a0 |
| CN=EM OV CS CA - G3B,O=eMudhra BV,C=NL | 9e39de2881273acc225a149c72ba3e0f51424963669ab633ee1dc7df5db067b4 | ec4ffa1ad0ac88081314b7aaffef6a91f97cd57291bb5ba686c5415f5eb4f6b6 |
| CN=EM OV CS CA - G3C,O=eMudhra Inc,C=US | 4b2460a466f95fd40113bcdcca2ceb29b3b093921de45474da7df48874c630b1 | 92c063d67e8f14db71d288e11266ffdaf69cbf115f7bab14f3bc2f68d25e0e30 |

The six TLS intermediates come from the advisory's `chains.zip`; the two code-signing intermediates from crt.sh
([18286207189](https://crt.sh/?id=18286207189), [18286207185](https://crt.sh/?id=18286207185)).

To check the list against Go's hashes:

```sh
jq -r '.CADistrustedCertificates[]' chromium-policies/emudhra-distrust.json | while read -r c; do
  echo "$c" | base64 -d | openssl x509 -inform DER -noout -pubkey | openssl pkey -pubin -outform DER | sha256sum
done
```

To check a built image, every host below must report `blocked`:

```sh
for h in {dv,ov,ev}-g3{b,c}{,-aaa}; do
  out=$(docker run --rm -e HOME=/tmp --entrypoint chromium IMAGE --headless=new --no-sandbox --disable-gpu \
    --disable-crash-reporter --no-zygote --user-data-dir=/tmp/p --dump-dom "https://$h-emudhra.we-have-a-problem.com/" 2>&1)
  case $out in
    *net::ERR_CERT*) echo "$h blocked" ;;
    *"successfully connected"*) echo "$h LOADED (affected)" ;;
    *) echo "$h unknown, check the output" ;;
  esac
done
```
