require File.dirname(__FILE__) + '/../spec_helper'

describe User do
  include Matchers::ClassExtensions

  before :each do
    @anonymous = User.anonymous :name => 'John Doe'
  end

  describe 'class extensions:' do
    it 'acts as authenticated user (with single token authentication)' do
      User.should act_as_authenticated_user
    end
  end

  describe 'validations:' do
    it 'validates the presence of a name' do
      @anonymous.should validate_presence_of(:first_name)
    end

    it 'validates the presence of an email' do
      @anonymous.should validate_presence_of(:email)
    end

    it 'validates the length of the name (3-40 chars)' do
      @anonymous.should validate_length_of(:first_name, :within => 3..40)
    end

    describe 'validates the format of the email' do
      it 'succeeds with a valid email address' do
        @anonymous.email = 'valid@email.org'
        @anonymous.should be_valid
      end

      it 'fails with an invalid email address' do
        @anonymous.email = 'invalid-email.org'
        @anonymous.should_not be_valid
      end
    end
  end

  describe '#has_role?' do
    it 'returns true when the passed role is Role::Anonymous' do
      @anonymous.has_role?(:anonymous).should be_true
    end

    it 'returns false when the passed role is not Role::Anonymous' do
      @anonymous.has_role?(:user).should be_false
    end
  end

  it '#anonymous? returns true' do
    @anonymous.anonymous?.should be_true
  end

  it '#registered? returns false' do
    @anonymous.registered?.should be_false
  end

end
