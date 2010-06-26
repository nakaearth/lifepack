class Task < ActiveRecord::Base
    #belongs_to :user
    #named_scope :doing_status, :conditions=>["status = ?" , 'doing']

    def validate
      errors.add(:user_id, "ユーザIDは必須です。")if user_id.blank?
      errors.add(:content, "本文は必須です。") if content.blank?
    end

end
