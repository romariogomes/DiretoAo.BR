module PoliticiansHelper

	def load_states
    @states = State.all
  end

  def load_charges
    @charges = Charge.first(2)
  end

  def load_parties
    @parties = Party.all
  end
end
