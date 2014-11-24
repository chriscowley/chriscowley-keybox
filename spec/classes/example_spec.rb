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

        it { should contain_class('keybox::params') }
        it { should contain_class('keybox::install').that_comes_before('keybox::config') }
        it { should contain_class('keybox::config') }
        it { should contain_class('keybox::service').that_subscribes_to('keybox::config') }

        it { should contain_service('keybox') }
        it { should contain_package('keybox').with_ensure('present') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'keybox class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { should contain_package('keybox') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end
