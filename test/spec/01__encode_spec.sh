#shellcheck shell=sh disable=SC2154

Describe "Encode:"
  setup()    { :; }
  teardown() { :; }
  
  Before 'setup'
  After  'teardown'

  checksum() {
  	test "$(sha256sum "${checksum}"| cut -d ' ' -f 1)" "$1" "$2"
  }

  It "hello from stdin, then png data to stdout"
    encode() { docker run --rm -i "${IMAGE_NAME}" encode > "$1"; }
    Data:expand
      #|hello
    End
    Path hello-png="${SHELLSPEC_WORKDIR}/hello-of-stdin.png"
    When call encode "${SHELLSPEC_WORKDIR}/hello-of-stdin.png"
    The status should be success
    The path hello-png should not be empty file
    The path hello-png should satisfy checksum = "e0d9bf9b952bfdd8140e8ec722c03fd945b6bb8d21b290886ccf9d575d75c8ad"
  End
End
