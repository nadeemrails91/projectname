require 'rails_helper'

RSpec.describe User, type: :model do
  subject {
    described_class.new(password: 'pw1234', email: 'jane@doe.com')
  }
  describe "Validations" do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a valid password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'is not valid without a valid email' do
      subject.email = nil
      expect(subject).to_not be_valid
    end
  end

end
