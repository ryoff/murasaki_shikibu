require 'spec_helper'

class User < ActiveRecord::Base
  attribute :name, MurasakiShikibu::Type.new { |name| name.capitalize }
  attribute :address, MurasakiShikibu::Type.new { |name| name.tr('0-9a-zA-Z', '０-９ａ-ｚＡ-Ｚ') }
end

describe MurasakiShikibu do
  it 'has a version number' do
    expect(MurasakiShikibu::VERSION).not_to be nil
  end

  describe '#type_cast_from_user' do
    let(:user) { User.new(name: 'ryoff', address: '東京1-2-3') }

    describe "name" do
      subject { user.name }

      it { is_expected.to eq 'Ryoff' }
      it { expect(user.name_before_type_cast).to eq 'ryoff' }
    end

    describe "address" do
      subject { user.address }

      it { is_expected.to eq '東京１-２-３' }
      it { expect(user.address_before_type_cast).to eq '東京1-2-3' }
    end
  end

  describe '#type_cast_for_database' do
    let(:user) { User.new(name: 'ryoff', address: '東京1-2-3') }

    before { user.save }

    context 'using where' do
      describe "name" do
        subject { User.where(name: 'ryoff').first.try!(:name) }

        it { is_expected.to eq 'Ryoff' }
      end

      describe "address" do
        subject { User.where(address: '東京1-2-3').first.try!(:address) }

        it { is_expected.to eq '東京１-２-３' }
      end
    end

    context 'using find_by' do
      describe "name" do
        subject { User.find_by(name: 'ryoff').try!(:name) }

        it { is_expected.to eq 'Ryoff' }
      end

      describe "address" do
        subject { User.find_by(address: '東京1-2-3').try!(:address) }

        it { is_expected.to eq '東京１-２-３' }
      end
    end


  end
end
