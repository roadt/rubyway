
require 'openssl'
cert_store = OpenSSL::X509::Store.new
cert_store.add_file '/etc/ssl/cert.pem'

ssl_context = OpenSSL::SSL::SSLContext.new
ssl_context.cert_store = cert_store

tcp_socket = TCPSocket.open 'baidu.com', 443
ssl_socket = OpenSSL::SSL::SSLSocket.new tcp_socket, ssl_context

