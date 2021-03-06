require 'spec_helper'

RSpec.describe Ilm::Chemistry::Substance do
  s = Ilm::Chemistry::Substance.new 'CaCO3' => 1, 'CO2' => 2, 'CaO' => 0.5

  it 'should_collect_species_correctly' do
    expect(s.species).to include('CaCO3', 'CO2', 'CaO')
  end

  it 'should_calculate_weight_percentages' do
    expect(s.species['CaCO3'][:weight_percent]).to eq(1.0 / 3.5 * 100)
    expect(s.species['CO2'][:weight_percent]).to eq(2.0 / 3.5 * 100)
    expect(s.species['CaO'][:weight_percent]).to eq(0.5 / 3.5 * 100)
  end

  it 'should_have_compound_objects' do
    expect(s.species['CaCO3'][:compound].class).to eq(Ilm::Chemistry::Compound)
    expect(s.species['CaO'][:compound].formula).to eq('CaO')
  end
end
