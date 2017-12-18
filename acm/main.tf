resource "aws_cloudformation_stack" "acm_cert" {
  name = "networking-stack"

  parameters {
    DomainName = "${var.domain_name}"
  }

  template_body = <<STACK
{
  "Parameters" : {
    "DomainName" : {
      "Type" : "String",
      "Description" : "The domain to get a certificate for. Can be a wildcard."
    }
  },
  "Resources": {
    "TLSCert": {
      "Type": "AWS::CertificateManager::Certificate",
      "Properties": {
        "DomainName": { "Ref": "DomainName" }
      }
    }
  },
  "Outputs": {
    "ACMCertArn": {
      "Value": {
        "Ref": "TLSCert"
      }
    }
  }
}
STACK
}
