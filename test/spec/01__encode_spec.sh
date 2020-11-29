#shellcheck shell=sh disable=SC2154

Describe "Encode feature:"
  Path workdir="$(mktemp -d)"
  setup()    { :; }
  teardown() { rm -rf "${workdir}"; }
  
  Before 'setup'
  After  'teardown'

  checksum() {
  	test "$(sha256sum "${checksum}"| awk '{print $1}')" "$1" "$2"
  }

  It "hello from stdin, then png data to stdout"
    qrencode() { docker run --rm -i "${IMAGE_NAME}" encode > "$2"; }
    Data:expand
      #| hello
    End
    Path hello-png="${workdir}/hello-of-stdin.png"
    When call qrencode hello-png
    The status should be success
    The path hello-png should not be empty file
    The path hello-png should satisfy checksum -eq "b30026c9a1a92e0e1da3dcae8ba3eff46db5141931735886af9676ef83270f19"
  End

  It "hello from argument, then png data to stdout"
    qrencode() { echo hello | docker run --rm -i "${IMAGE_NAME}" encode > "$2"; }
    Data:expand
      #| hello
    End
    Path hello-png="${workdir}/hello-of-args.png"
    When call qrencode hello-png
    The status should be success
    The path hello-png should not be empty file
    The path hello-png should satisfy checksum -eq "b30026c9a1a92e0e1da3dcae8ba3eff46db5141931735886af9676ef83270f19"
  End
End
