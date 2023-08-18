require 'spec_helper'

describe 'mrepo::rhn', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:node) { 'mrepo.example.com' } # gives uuid 51188cb3-b227-598a-a1d4-f508c78f9e77

      let(:facts) do
        facts
      end

      context 'with default parameters' do
        let :pre_condition do
          'class {"mrepo":
            rhn          => true,
            rhn_username => "bob",
            rhn_password => "hunter2",
          }'
        end

        it { is_expected.to compile.with_all_deps }

        it { is_expected.to contain_package('pyOpenSSL') }

        it { is_expected.to contain_file('/etc/sysconfig/rhn/up2date-uuid').with_content(%r{rhnuuid=51188cb3-b227-598a-a1d4-f508c78f9e77}) } if facts[:operatingsystem] == 'CentOS'
      end
    end
  end
end
