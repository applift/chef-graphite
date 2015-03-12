name              "graphite"
maintainer        "Hector Castro"
maintainer_email  "hectcastro@gmail.com"
license           "Apache 2.0"
description       "Installs and configures Graphite."
version           "0.1.6"
recipe            "graphite", "Installs and configures Graphite and all of its components"
recipe            "graphite::carbon", "Installs and configures Carbon"
recipe            "graphite::web", "Installs and configures the Graphite web interface"
recipe            "graphite::whisper", "Installs and configures Whisper"

%w{ nginx logrotate python yum yum-epel build-essential }.each do |d|
  depends d
end

%w{ centos redhat ubuntu amazon }.each do |os|
    supports os
end
