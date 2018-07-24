module AasmHistory
  extend ActiveSupport::Concern
  included do
    has_many :state_histories, as: :stateable, inverse_of: :stateable, dependent: :destroy
  end

  # rubocop:disable Metrics/ParameterLists, Lint/UnderscorePrefixedVariableName
  def aasm_fired(_state_machine_name, _event, old_state, new_state_name, _options, *args)
    # stateを保存する場合は履歴も作成する
    # stateの保存に失敗した場合は履歴もロールバックされる
    if _options[:persist]
      state_history = state_histories.new
      state_history.update(state: new_state_name, previous_state: old_state)
    end

    self.aasm_state = new_state_name
    super
  end
  # rubocop:enable Metrics/ParameterLists, Lint/UnderscorePrefixedVariableName
end
