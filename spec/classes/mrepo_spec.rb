require 'spec_helper'

describe 'mrepo', type: :class do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) do
        facts
      end

      it { is_expected.to compile.with_all_deps }

      context 'with service mrepo manage and disable' do
        let(:params) do
          {
            service_enable: false,
            service_manage: true
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_service('mrepo').with('enable' => false) }
      end

      context 'with service mrepo manage and enable' do
        let(:params) do
          {
            service_enable: true,
            service_manage: true
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_service('mrepo').with('enable' => true) }
      end
    end
  end
end
