# frozen_string_literal: true

describe TokenManager do
  describe '#save' do
    let(:token) { 1 }

    it 'saves token in config folder' do
      subject.new.save(token)
    end
  end

  describe '#load' do
    it 'loads token from config' do
      subject.new.load
    end
  end
end
