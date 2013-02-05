# Overrides certificate check
module OpenSSL
  module SSL
    def verify_certificate_identity(cert, hostname)
      true
    end
    module_function :verify_certificate_identity
  end
end