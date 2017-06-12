module PoliticiansHelper

	def load_states
    @states = State.all
  end

  def load_charges
    @charges = Charge.first(2)
  end
end
