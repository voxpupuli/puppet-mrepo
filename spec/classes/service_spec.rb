require 'spec_helper'

describe 'mrepo::service', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      context 'with default parameters' do
        it { is_expected.to compile.with_all_deps }
      end

      context 'with service mrepo enable' do
        let(:params) { { service_enable: true } }

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_service('mrepo').with('enable' => true) }
      end
    end
  end
end
