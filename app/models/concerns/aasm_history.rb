module AasmHistory
  extend ActiveSupport::Concern
  included do
    has_many :state_histories, as: :stateable, inverse_of: :stateable, dependent: :destroy
  end

  def aasm_fired(_state_machine_name, _event, old_state, new_state_name, _options, *args)
    state_history = state_histories.new
    state_history.update(state: new_state_name, previous_state: old_state)
    self.aasm_state = new_state_name
    super
  end
end
