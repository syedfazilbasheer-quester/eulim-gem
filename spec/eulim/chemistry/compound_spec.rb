require 'spec_helper'
require 'unitwise'

RSpec.describe Eulim::Chemistry::Compound do
  C = Eulim::Chemistry::Compound
  it 'molecular mass for H2SO4 is 98.07919999999999' do
    expect(C.new('H2SO4').molecular_mass)
      .to eq(Unitwise(98.0792, 'u'))
  end

  it 'Constituents of KClO3 are "K","Cl", "O"' do
    expect(C.new('KClO3').constituents).to include('K', 'Cl', 'O')
  end

  it 'Constituent atoms with count for KClO3' do
    constituents = C.new('KClO3').constituents
    expect(constituents['K'][:atom_count]).to eq 1
    expect(constituents['Cl'][:atom_count]).to eq 1
    expect(constituents['O'][:atom_count]).to eq 3
  end
end
