class AlertNotes < ActiveRecord::Base
   validates :user_id, presence: true, numericality: { only_integer: true, message: "is not a valid number" }
   validates :alert_id, presence: true, numericality: { only_integer: true, message: "is not a valid number" }
   validates :description, presence: true
   validates :sent_by, presence: true
end
