require 'spec_helper'

describe 'mrepo::iso' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }
      let(:title) { 'CentOS-7-x86_64-Minimal-1804.iso' }
      let(:params) do
        {
          'source_url' => 'http://example.com/isos',
          'repo'       => 'centos7-x86_64'
        }
      end
      let(:pre_condition) do
        'mrepo::repo { \'centos7-x86_64\': ensure => present, release => \'7\', arch => \'x86_64\' }'
      end

      it { is_expected.to compile }

      it {
        is_expected.to contain_mrepo__iso('CentOS-7-x86_64-Minimal-1804.iso').
          with('source_url' => 'http://example.com/isos').
          with('repo' => 'centos7-x86_64')
      }

      it {
        is_expected.to contain_file('/var/mrepo/iso').
          with_ensure('directory').
          with_owner('apache').
          with_group('apache').
          with_mode('0644')
      }

      it {
        is_expected.to contain_archive('/var/mrepo/iso/CentOS-7-x86_64-Minimal-1804.iso').
          with('source' => 'http://example.com/isos/CentOS-7-x86_64-Minimal-1804.iso').
          that_requires('File[/var/mrepo/iso]')
      }
    end
  end
end
