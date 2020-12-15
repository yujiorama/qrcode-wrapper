#shellcheck shell=sh disable=SC2154

Describe "Decode:"
  setup()    { :; }
  teardown() { :; }
  
  Before 'setup'
  After  'teardown'

  It "png data from stdin, then hello to stdout"
    decode() { base64 -d | docker run --rm -i "${IMAGE_NAME}" decode; }
    Data:expand
      #|iVBORw0KGgoAAAANSUhEUgAAAFcAAABXAQMAAABLBksvAAAABlBMVEUAAAD///+l2Z/dAAAAAnRS
      #|TlP//8i138cAAAAJcEhZcwAACxIAAAsSAdLdfvwAAAC3SURBVDiNzdOxDYQwDAVQIwp3TBApa6Rj
      #|pWSBcCzATOmyBhILQJfCwuc7iaPJOd3pXL3y59sBvgf+wjtAdAbAKj6YvKOJVSfjR+Ox4eio6cCm
      #|YaZQzCdD1ZI/5PstVcvsgquTqndHA1KXNJ/QP0aailXMae1yf6Lqsh2FT6eazYBSBauW/Dxnq1h6
      #|8LgtwIqlzwj9zKrfu+uuG/jmkHiBhiPaI6uWe8N1ujJU/dpvsovT/Mv/1fYTAMOy+mpPXEgAAAAA
      #|SUVORK5CYII=
    End
    When call decode
    The status should be success
    The output should eq "QR-Code:hello"
  End
End
