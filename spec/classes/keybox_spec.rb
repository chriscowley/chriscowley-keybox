require 'spec_helper'

describe 'keybox' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
      describe "keybox class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should compile.with_all_deps }

        it { should contain_class('staging') }
        it { should contain_class('staging::params') }
        it { should contain_class('keybox') }
        it { should contain_class('keybox::params') }
        it { should contain_class('keybox::install').that_comes_before('keybox::config') }
        it { should contain_class('keybox::config') }
        it { should contain_class('keybox::service').that_subscribes_to('keybox::config') }

        it { should contain_service('keybox') }
        it { should contain_group('keybox')}
        it { should contain_user('keybox')}
        it { should contain_exec('download-keybox').with_command('curl -o /opt/staging/keybox-jetty-v2.50_00.tar.gz https://github.com/skavanagh/KeyBox/releases/download/v2.50.00/keybox-jetty-v2.50_00.tar.gz')}
      end
    end
  end

  context 'unsupported operating system' do
    describe 'keybox class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}
    end
  end
end
