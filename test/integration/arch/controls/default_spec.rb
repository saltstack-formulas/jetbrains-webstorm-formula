# frozen_string_literal: true

title 'webstorm archives profile'

control 'webstorm archive' do
  impact 1.0
  title 'should be installed'

  describe file('/etc/default/webstorm.sh') do
    it { should exist }
  end
  # describe file('/usr/local/jetbrains/webstorm-*/bin/webstorm.sh') do
  #    it { should exist }
  # end
  describe file('/usr/share/applications/webstorm.desktop') do
    it { should exist }
  end
end
