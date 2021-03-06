class Invite < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :conversation
  belongs_to :requestor, 
    :class_name  => "User",
    :foreign_key => "requestor_id"

  validates_presence_of :requestor_id
  validates_presence_of :user_id
  validates_presence_of :conversation_id
  
  def reset_token!
    self.token = nil
    self.save
  end
  
end
