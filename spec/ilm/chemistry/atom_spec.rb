# frozen_string_literal: true

require 'spec_helper'

require 'ilm/chemistry'

Atom = Ilm::Chemistry::Atom
Element = Ilm::Chemistry::Element
Electron = Ilm::Chemistry::Electron
Proton = Ilm::Chemistry::Proton
Neutron = Ilm::Chemistry::Neutron

RSpec.describe Atom do
  let(:hydrogen) { Element.get_by_symbol 'H' }
  let(:helium) { Element.get_by_symbol 'He' }

  let(:empty_atom) { Atom.new }

  let(:hydrogen_atom) { Atom.new(element: hydrogen) }
  let(:helium_atom) { Atom.new(element: helium) }

  let(:deuterium_ion) do
    Atom.new(
      element: hydrogen,
      neutron_count: 1, electron_count: 0
    )
  end

  let(:custom_atom) do
    Atom.new(
      proton_count: 8,
      neutron_count: 4, electron_count: 2
    )
  end

  context '#initialize' do
    context 'when_only_element_is_given' do
      it 'should_have_element' do
        expect(hydrogen_atom.element).to be hydrogen
      end
      it 'should_have_same_number_of_sub_atomic_particle_count_as_element' do
        expect(hydrogen_atom.electrons.count).to be hydrogen.no_of_electrons
        expect(hydrogen_atom.protons.count).to be hydrogen.no_of_protons
        expect(hydrogen_atom.neutrons.count).to be hydrogen.no_of_neutrons
      end
    end

    context 'when_element_and_sub_atomic_particle_count_are_given' do
      it 'should_have_element' do
        expect(deuterium_ion.element).to be hydrogen
      end
      it 'should_have_given_number_of_sub_atomic_particles' do
        expect(deuterium_ion.electrons.count).to be_zero
        expect(deuterium_ion.protons.count).to be 1
        expect(deuterium_ion.neutrons.count).to be 1
      end
    end

    context 'when_only_sub_atomic_particle_count_are_given' do
      it 'should_not_have_element' do
        expect(custom_atom.element).to be_nil
      end
      it 'should_have_given_number_of_sub_atomic_particles' do
        expect(custom_atom.electrons.count).to be 2
        expect(custom_atom.protons.count).to be 8
        expect(custom_atom.neutrons.count).to be 4
      end
    end

    context 'when_neither_element_nor_sub_atomic_particle_count_are_given' do
      it 'should_not_have_element' do
        expect(empty_atom.element).to be_nil
      end
      it 'should_have_no_sub_atomic_particles' do
        expect(empty_atom.protons.count).to be_zero
        expect(empty_atom.electrons.count).to be_zero
        expect(empty_atom.neutrons.count).to be_zero
      end
    end
  end

  context '#charge' do
    it 'should_be_zero_for_hydrogen_and_helium_atoms' do
      expect(hydrogen_atom.charge.value).to be_zero
      expect(helium_atom.charge.value).to be_zero
    end
    it 'should_be_correct_for_deuterium_ion' do
      expect(deuterium_ion.charge).to eq Proton::CHARGE
    end
    it 'should_be_correct_for_custom_atom' do
      expect(custom_atom.charge).to eq Proton::CHARGE * 6
    end
    it 'should_be_zero_for_empty_atom' do
      expect(empty_atom.charge.value).to be_zero
    end
  end

  context '#mass' do
    it 'should_be_correct_for_hydrogen_and_helium_atoms' do
      expect(hydrogen_atom.mass)
        .to eq Proton::MASS + Electron::MASS
      expect(helium_atom.mass)
        .to eq 2 * Proton::MASS + 2 * Neutron::MASS + 2 * Electron::MASS
    end
    it 'should_be_correct_for_deuterium_ion' do
      expect(deuterium_ion.mass)
        .to eq Proton::MASS + Neutron::MASS
    end
    it 'should_be_correct_for_custom_atom' do
      expect(custom_atom.mass)
        .to eq 8 * Proton::MASS + 4 * Neutron::MASS + 2 * Electron::MASS
    end
    it 'should_be_zero_for_empty_atom' do
      expect(empty_atom.mass.value).to be_zero
    end
  end

  context '#element?' do
    it 'should_return_hydrogen_for_hydrogen_atom' do
      expect(hydrogen_atom.element?).to be Element.get_by_symbol 'H'
    end
    it 'should_return_helium_for_helium_atom' do
      expect(helium_atom.element?).to be Element.get_by_symbol 'He'
    end
    it 'should_return_hydrogen_for_deuterium_ion' do
      expect(deuterium_ion.element?).to be Element.get_by_symbol 'H'
    end
    it 'should_return_oxygen_for_custom_atom' do
      expect(custom_atom.element?).to be Element.get_by_symbol 'O'
    end
    it 'should_return_nil_for_empty_atom' do
      expect(empty_atom.element?).to be_nil
    end
  end
end
