require 'spec_helper'

describe 'mrepo::package', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with default parameters' do
        let :pre_condition do
          'class { "mrepo": }'
        end

        it { is_expected.to compile.with_all_deps }
        describe '/etc/mrepo.conf' do
          it { is_expected.to contain_file('/etc/mrepo.conf') }
          it 'does not have rhnget-cleanup line' do
            content = catalogue.resource('file', '/etc/mrepo.conf').send(:parameters)[:content]
            expect(content).not_to match %r{rhnget-cleanup}
          end
          it 'does not have rhnget-download-all line' do
            content = catalogue.resource('file', '/etc/mrepo.conf').send(:parameters)[:content]
            expect(content).not_to match %r{rhnget-download-all}
          end
        end
      end

      describe 'rhnget_cleanup parameter' do
        context 'with rhnget_cleanup = true' do
          let(:pre_condition) do
            'class { "mrepo": rhnget_cleanup => true }'
          end

          it do
            content = catalogue.resource('file', '/etc/mrepo.conf').send(:parameters)[:content]
            expect(content).to match %r{^rhnget-cleanup = yes$}
          end
        end
        context 'with rhnget_cleanup = false' do
          let(:pre_condition) do
            'class { "mrepo": rhnget_cleanup => false }'
          end

          it do
            content = catalogue.resource('file', '/etc/mrepo.conf').send(:parameters)[:content]
            expect(content).to match %r{^rhnget-cleanup = no$}
          end
        end
      end

      describe 'rhnget_download_all parameter' do
        context 'with rhnget_download_all = true' do
          let(:pre_condition) do
            'class { "mrepo": rhnget_download_all => true }'
          end

          it do
            content = catalogue.resource('file', '/etc/mrepo.conf').send(:parameters)[:content]
            expect(content).to match %r{^rhnget-download-all = yes$}
          end
        end
        context 'with rhnget_download_all = false' do
          let(:pre_condition) do
            'class { "mrepo": rhnget_download_all => false }'
          end

          it do
            content = catalogue.resource('file', '/etc/mrepo.conf').send(:parameters)[:content]
            expect(content).to match %r{^rhnget-download-all = no$}
          end
        end
      end
    end
  end
end
