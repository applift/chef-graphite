name              "graphite"
maintainer        "Giuseppe Correnti"
maintainer_email  "correnti.g@gmail.com"
license           "Apache 2.0"
description       "Installs and configures Graphite (API only no dashboard)"
version           "0.0.1"
recipe            "graphite", "Installs and configures Graphite and all of its components"
recipe            "graphite::carbon", "Installs and configures Carbon"
recipe            "graphite::whisper", "Installs and configures Whisper"

%w{ nginx graphite-api logrotate python yum yum-epel }.each do |d|
  depends d
end

%w{ ubuntu }.each do |os|
    supports os
end
