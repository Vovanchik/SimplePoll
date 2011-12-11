class User < ActiveRecord::Base
  belongs_to :role

  acts_as_authentic do |c|
    c.login_field = :nick
  end

  def role?(role)
    unless self.role.nil?
      return self.role.name == role.to_s
    end
  end
end
