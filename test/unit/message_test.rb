require File.dirname(__FILE__) + '/../test_helper'

class MessageTest < ActiveSupport::TestCase
  context "Message" do
    setup do
      @message = Factory.create(:message)
      
      @deactivated_message = Factory.create(:message)
      @abuse_report = Factory.create(:abuse_report, :user => @deactivated_message.user, :message => @deactivated_message)
      @deactivated_message.abuse_report = @abuse_report
      @deactivated_message.save
    end
    
    should "return 2 messages when find" do
      assert_equal Message.find(:all).length, 2
    end
    
    should "return only activated messages when find with published named_scope" do
      assert_equal Message.published.length, 1
    end
  end
  
  context "A Message instance" do    
    setup do
      @message = Factory(:message)
    end

    should_belong_to :conversation
    should_belong_to :user

    should_have_many :abuse_reports
    should_belong_to :abuse_report
    
    should_have_many :conversations #conversations spawned from this message

    should_have_index :user_id
    should_have_index :conversation_id
    should_have_index :created_at

    should_require_attributes :message
    should_require_attributes :user_id, :conversation_id


  end    
end
